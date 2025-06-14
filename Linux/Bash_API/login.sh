#!/bin/bash
echo "Content-type: application/json"
echo ""

read_body() {
        if [[ "$REQUEST_METHOD" == "POST" && "$CONTENT_LENGTH" -gt 0 ]]; then
        read -n "$CONTENT_LENGTH" body
        echo "$body"
        else
        echo ""
        fi
}

parse_json() {
    echo "$1" | jq -r "$2"
}

auth_user() {
    username="$1"
    password="$2"

    line=$(grep "^$username:" /srv/script/auth/users.txt)
    [ -z "$line" ] && echo '{"error": "invalid credentials"}' && exit 1

    stored_hash=$(echo "$line" | cut -d':' -f2)
    input_hash=$(echo -n "$password" | sha256sum | awk '{print $1}')

    [ "$stored_hash" != "$input_hash" ] && echo '{"error": "invalid credentials"}' && exit 1

    token=$(openssl rand -hex 16)
    expiry=$(date -d "+7 days" +%F)
    echo "$token:$username:$expiry" >> /srv/script/auth/tokens.txt

    echo "{\"token\": \"$token\", \"user\": \"$username\", \"expires\": \"$expiry\"}"
}

[ "$REQUEST_METHOD" != "POST" ] && echo '{"error": "POST only"}' && exit 1

raw=$(read_body)
username=$(parse_json "$raw" '.username')
password=$(parse_json "$raw" '.password')

[ -z "$username" ] || [ -z "$password" ] && echo '{"error": "missing username or password"}' && exit 1

auth_user "$username" "$password"
