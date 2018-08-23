ansible-playbook tasks/main.yml -i ../../hosts -l turfoo-new -e "target=all" -e "ansible_user=jmirre" --extra-vars "@registry.json" -b -K
