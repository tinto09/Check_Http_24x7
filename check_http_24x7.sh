#!/bin/bash


while getopts "H:t:" OPT
do
	case $OPT in 
		H) host="$OPTARG" ;;
		t) text="$OPTARG" ;;
    esac
done

code=`curl -s -I $host | grep HTTP | awk {'print $2'}`
text=`curl -s $host | jq -r ."$text"`

if [[ $code = success ]]; then
        case $json_http in
        [true]*)
        echo "OK - $json_http"
        exit 0
        ;;
        [false]*)
        echo "CRITICAL - $json_http"
        exit 2
        ;;
        *)
        echo "UNKNOWN - $json_http"
        exit 3
        ;;
        esac
else
        case $json_http in
        [false]*)
        echo "OK - $json_http"
        exit 0
        ;;
        [true]*)
        echo "CRITICAL - $json_http"
        exit 2
        ;;
        *)
        echo "UNKNOWN - $json_http"
        exit 3
        ;;
        esac
fi



