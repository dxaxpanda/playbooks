This playbook ensures the two ESP partitions are equally managed while booting on debian 9 stable. It handles the /etc/fstab file accordingly.

TODO : Add comment for each disk line.

# Setup

Inventory file has to be setup first. The target variable ensures you maintain control on which hosts to work on.

```shell
$ ansible-playbook /tasks/main.yml -i hosts -l <group> -e "target=all" -e "ansible_user=<user>" -K -k -b
```


