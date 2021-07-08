#!/bin/sh
set -e

namespace=$1
name=$2
build=$3
file=$4
wd=$5

if [[ ! -z "$OKTETO_CA_CERT" ]]; then
   echo "Custom certificate is provided"
   echo "$OKTETO_CA_CERT" > /usr/local/share/ca-certificates/okteto_ca_cert
   update-ca-certificates
fi

params="--wait "

if [ ! -z "$namespace" ]; then
params="${params} --namespace $namespace"
fi

if [ ! -z "$name" ]; then
params="${params} --name $name"
fi

if [ "$build" == "true" ]; then
params="${params} --build"
fi

if [ ! -z "$file" ]; then
params="${params} --file $file"
fi

if [ ! -z "$wd" ]; then
cd $wd
fi

echo running: okteto stack deploy $params on $(pwd)
okteto stack deploy $params