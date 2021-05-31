# OpenShift  Mirror Syncer
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fthekoma%2Focp-mirror-script.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fthekoma%2Focp-mirror-script?ref=badge_shield)


it will sync a release in your registry.
 
 - Copy `env.sh.dist` in `env.sh` and add your information
 - Create the pull.json with the needed infomration follow [the info.](https://docs.openshift.com/container-platform/4.2/installing/install_config/installing-restricted-networks-preparations.html)
 - Run the Script:

```bash
# To sync
./mirror sync 4.6.12

# To delete
./mirror delete 4.6.12
```



## License
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fthekoma%2Focp-mirror-script.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fthekoma%2Focp-mirror-script?ref=badge_large)