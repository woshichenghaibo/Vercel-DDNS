#!/bin/bash

#########  Config  ###########
DOMAIN='abc.com'
SUB_DOMAIN='xyz'
VERCEL_TOKEN='M2qG463fdfdk0Q3BkEjnvdTzI'
##############################

#########   Code   ###########

LOG_FILE="$(dirname $0)/ddns.log"
HEADERS="Authorization: Bearer $VERCEL_TOKEN"

WriteLog()
{ 
    STAMP=$(date +"%Y/%m/%d %H:%M:%S")
    LOG_MESSAGE="$STAMP $1"
    if [ ! $LOG_CONSOLE ]
    then
        echo $LOG_MESSAGE >> $LOG_FILE
    else
        echo $LOG_MESSAGE
    fi
}

IPV6_ADDRESS=$(curl -s 6.ipw.cn)

WriteLog "IPv6 = $IPV6_ADDRESS"

if [ ! -f $(dirname $0)/currentV6.ipaddr ]
then
    touch $(dirname $0)/currentV6.ipaddr
fi

OLD_IP=$(cat $(dirname $0)/currentV6.ipaddr)

if [ "$OLD_IP" != "$IPV6_ADDRESS" ]
then
    if [ -s $(dirname $0)/uid ]
    then
        UID=$(cat $(dirname $0)/uid)
        URI="https://api.vercel.com/domains/records/$UID"
        BODY=$(echo -n "{ \"value\": \"$IPV6_ADDRESS\" }")       
        SERVER_RESPONSE=$(curl -s -X PATCH -H "Content-Type: application/json" -H "$HEADERS" -d "$BODY" "$URI")
        echo $SERVER_RESPONSE | grep -oP '(?<="uid":")[^"]*' > $(dirname $0)/uid
        WriteLog 'Done.'
    else
        URI="https://api.vercel.com/domains/$DOMAIN/records"
        BODY=$(echo -n "{ \"name\": \"$SUB_DOMAIN\", \"type\": \"AAAA\", \"value\": \"$IPV6_ADDRESS\", \"ttl\": 60 }")
        SERVER_RESPONSE=$(curl -s -X POST -H "Content-Type: application/json" -H "$HEADERS" -d "$BODY" "$URI")
        echo $SERVER_RESPONSE | grep -oP '(?<="uid":")[^"]*' > $(dirname $0)/uid
        WriteLog 'Done.'
    fi
else
    WriteLog 'Same address no need to update.'
fi