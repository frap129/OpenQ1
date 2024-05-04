#!/usr/bin/env bash

_set_timezone_and_locales() {

    # Grab this machine's public IP address
    PUBLIC_IP=$(curl --max-time 5 -s https://ipinfo.io/ip)

    # Check if we have wireless adaptor
    WIFI_DEVICE=$(LC_ALL=C nmcli dev status | grep  " wifi " 2>/dev/null)

    if [ -z "$PUBLIC_IP" ]; then

        # ask for connecting to wireless if wifi device is found
        if [[ -n "$WIFI_DEVICE" ]]; then
            echo -e "Internet connection was \x1B[91mnot detected\x1B[0m."
            echo ""
            unset response
            while [[ ! "${response}" =~ ^(Y|y|N|n)$ ]]; do
                read -n1 -s -r -p "Connect via wireless? [Y/n] " response
                response=${response:-Y}
                echo "$response"
            done
            if [[ "${response}" =~ ^(Y|y)$ ]]; then
                nmtui-connect
            fi
            echo ""
        fi
    fi

    # Grab IP once again if not found
    [[ -z "$PUBLIC_IP" && -n "$WIFI_DEVICE" ]] && PUBLIC_IP=$(curl --max-time 5 -s https://ipinfo.io/ip)

    # Call the geolocation API and capture the output
    RES=$(
        curl --max-time 5 -s "http://ipwhois.app/json/${PUBLIC_IP}" | \
            jq '.timezone, .country, .country_code' | \
            while read -r TIMEZONE; do
                read -r COUNTRY
                echo "${TIMEZONE},${COUNTRY},${COUNTRYCODE}" | tr --delete '"\n'
            done
        )

    TZDATA=$(echo "${RES}" | cut -d"," -f1)
    CCODE=$(echo "${RES}" | cut -d"," -f3 | xargs)
    echo -e "Detected timezone: \x1B[92m$TZDATA\x1B[0m"
    echo ""
    unset response
    while [[ ! "${response}" =~ ^(Y|y|N|n)$ ]]; do
        read -n1 -s -r -p "Set user language based on your location? [Y/n] " response
        response=${response:-Y}
        echo "$response"
    done
    # change it only if we have a match and if we agree
    if [[ "${response}" =~ ^(N|n)$ ]]; then
        unset CCODE TZDATA
    fi

    LOCALES=$(grep territory /usr/share/i18n/locales/* | grep _"$CCODE" | cut -d ":" -f 1 | cut -d "/" -f 6 |  \
    xargs -I{} grep {} /usr/share/i18n/SUPPORTED | grep "\.UTF-8" | cut -d " " -f 1)
    # UTF8 is not present everywhere so check again in case it returns empty value
    [[ -z "$LOCALES" ]] && LOCALES=$(grep territory /usr/share/i18n/locales/* | grep _"$CCODE" | cut -d ":" -f 1 | cut -d "/" -f 6 |  \
    xargs -I{} grep {} /usr/share/i18n/SUPPORTED | cut -d " " -f 1)

    readarray -t options <<<"${LOCALES}"

    # when having more locales, prompt for choosing one
    if [[ "${#options[@]}" -gt 1 ]]; then

        options+=("Skip generating locales")
        echo -e "\nAt your location, more locales are possible:\n"
        PS3='Please enter your choice:'
        select opt in "${options[@]}"
            do
                if [[ " ${options[*]} " == *" ${opt} "* ]]; then
                    LOCALES=${opt}
                    break
                fi
            done
    fi

    if [[ "${LOCALES}" != *Skip* ]]; then

        # if TZDATA was not detected, we need to select one
        if [[ -z ${TZDATA} ]]; then
            TZDATA=$(tzselect | tail -1)
        fi

        timedatectl set-timezone "${TZDATA}"
        sudo dpkg-reconfigure --frontend=noninteractive tzdata > /dev/null 2>&1

        # generate locales
        echo ""
        sudo sed -i 's/# '"${LOCALES}"'/'"${LOCALES}"'/' /etc/locale.gen
        echo -e "Generating locales: \x1B[92m${LOCALES}\x1B[0m"
        sudo locale-gen "${LOCALES}" > /dev/null 2>&1

        # setting detected locales only for user
        {
            echo "export LC_ALL=$LOCALES"
            echo "export LANG=$LOCALES"
            echo "export LANGUAGE=$LOCALES"
        } >> /home/"$USER"/.bashrc
        {
            echo "export LC_ALL=$LOCALES"
            echo "export LANG=$LOCALES"
            echo "export LANGUAGE=$LOCALES"
        } >> /home/"$USER"/.xsessionrc

    fi
}

_setup_passwds() {
    passwd
    sudo rm /root/.not_logged_in_yet
    sudo -i passwd
}

first_login() {
    if [ -f "/home/$USER/.not_logged_in_yet" ]; then
        _setup_passwds
        _set_timezone_and_locales
        rm ~/.not_logged_in_yet
    fi
}

