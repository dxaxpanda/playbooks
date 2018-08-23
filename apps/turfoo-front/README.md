# Introduction

Playbook to boostrap kubernetes applications


create a json files to pass the following variables :
```json
{
    "registry_host": "",
    "registry_username": "",
    "registry_password": "",
    "registry_email": "",
    "registry_state": ""
}
```


And launch playbook using this parameter :
```
$ ansible-playbook -i <inventory> tasks/main.yml --extra-vars "@registry.json" -b -K
```


# Mounts

Mounts from the zpool NAS have to be allowed on the OVH webui.


