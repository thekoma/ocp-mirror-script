#!/bin/bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

if [ $# -ne 2 ]; then
	echo "You need to specify action [sync|delete] and tag [4.6.12|4.7-fc.2|etcetc..]"
	exit 1
fi
source $DIR/env.sh
ACTIVITY=${1}
OCP_RELEASE=${2}
occlient() {
	export PATH=$PATH:$DIR/bin
	if [ ! $(command -v oc) ]; then
	   if [ ! -d $DIR/bin ] ; then mkdir ./bin; fi
	   curl -qL https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz|tar -xzf - -C $DIR/bin oc 
	   OC=$DIR/oc
	else
           OC=$(command -v oc)
	fi
}
sync() {
	occlient
	$OC adm release mirror -a ${LOCAL_SECRET_JSON}  \
	     --from=quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_RELEASE}-${ARCHITECTURE} \
	     --to=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY} \
	     --to-release-image=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY}:${OCP_RELEASE}-${ARCHITECTURE} 
}
delete() {
	for tag in $(skopeo list-tags docker://registry.gpslab.club/ocpmirror |jq -c '.Tags[]'|grep ${OCP_RELEASE}-|sed 's/"//g'); do
		skopeo delete --authfile=${LOCAL_SECRET_JSON} docker://${LOCAL_REGISTRY}/${LOCAL_REPOSITORY}:$tag
		if [ $? -eq 0 ]; then
		      echo  "Deleted ${LOCAL_REGISTRY}/${LOCAL_REPOSITORY}:$tag"
		fi
       	done
}
$ACTIVITY
