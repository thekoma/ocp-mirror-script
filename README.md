# OpenShift  Mirror Syncer

it will sync a release in your registry.
 
copy `env.sh.dist` in `env.sh` and add your information
create the pull.json with the needed infomration ( follow [https://docs.openshift.com/container-platform/4.2/installing/install_config/installing-restricted-networks-preparations.html](the info) 
```bash
# To sync
./mirror sync 4.6.12

# To delete
./mirror delete 4.6.12
```
