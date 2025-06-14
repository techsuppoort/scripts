This is a simple API written in bash.
It can create a user, authenticate them and perform basic tasks on them.

# Example:

`root@wsl:/srv/script# ./add_user.sh alice secret123`

```
root@wsl:/srv/script/auth# curl -X POST http://127.0.0.1/api/login   -H "Content-Type: application/json"   -d '{"username":"alice", "password":"secret123"}'
{"token": "b36a60344ab6f0c99be2d8ea848ceccf", "user": "alice", "expires": "2025-04-22"}
```

```
root@wsl:/srv/script/auth# curl -H "Authorization: Bearer a7c3fe35d72f8c0dbbd73782fc2fdc70" http://127.0.0.1/api/users/list
{"status": "ok", "users": ["alice", "bob"]}
```
