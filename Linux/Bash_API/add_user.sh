#!/bin/bash
user="$1"
pass="$2"

if [ -z "$user" ] || [ -z "$pass" ]; then
    echo "Usage: $0 username password"
        exit 1
        fi

        hashed=$(echo -n "$pass" | sha256sum | awk '{print $1}')
        echo "$user:$hashed" >> /srv/script/auth/users.txt
        echo "User $user added."
