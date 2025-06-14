#!/bin/bash
check_auth() {
    auth_token=$(echo "$HTTP_AUTHORIZATION" | cut -d' ' -f2)
    token_file="/srv/script/auth/tokens.txt"

    [ -z "$auth_token" ] && echo '{"error": "missing token"}' && exit 1

    line=$(grep "^$auth_token:" "$token_file")
    [ -z "$line" ] && echo '{"error": "invalid token"}' && exit 1

    username=$(echo "$line" | cut -d':' -f2)
    expiry=$(echo "$line" | cut -d':' -f3)

    today=$(date +%F)
    [[ "$expiry" < "$today" ]] && echo '{"error": "token expired"}' && exit 1
}

echo "Content-type: application/json"
echo ""

check_auth

command=$(echo "$PATH_INFO" | cut -d/ -f2)

case "$command" in
            list)
            echo "{\"status\": \"ok\", \"users\": [\"alice\", \"bob\"]}"
            ;;
            *)
            echo "{\"error\": \"unknown command\"}"
            ;;
esac
