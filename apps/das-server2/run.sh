ansible-playbook tasks/main.yml -i ../../hosts -l turfoo-new -e "target=all" -e "ansible_user=jmirre" --extra-vars "@registry.json" --extra-vars "@db.json" --extra-vars "@auth.json" -b -K
