#!/bin/bash

if [ $# != 1 ]; then
    echo "引数にMASTERのURLだけを指定して下さい"
    echo 例 \: $0 https://api.cluster-xxxx.xxxx.sandboxxxxx.opentlc.com:6443
    exit 1
fi

#export CONTENT_URL_PREFIX=https://raw.githubusercontent.com/RedHat-Middleware-Workshops/keycloak-workshop-guides/ocp-4.10/docs
#export WORKSHOPS_URLS=https://raw.githubusercontent.com/RedHat-Middleware-Workshops/keycloak-workshop-guides/ocp-4.10/docs/_sso-workshop-guides.yml

export CONTENT_URL_PREFIX=https://raw.githubusercontent.com/takahiro-ino/keycloak-workshop-guides/ocp-4.10/docs
export WORKSHOPS_URLS=https://raw.githubusercontent.com/takahiro-ino/keycloak-workshop-guides/ocp-4.10/docs/_sso-workshop-guides.yml


# ログイン
export MASTER_URL=$1
oc login ${MASTER_URL} -u opentlc-mgr -p r3dh4t1! --insecure-skip-tls-verify=true
oc project guides

  echo モジュールを置き換えます
  # 元データ確保
  oc get dc/web -o yaml > orignal_web.yml
  # ドキュメント参照先変更
  oc set env dc/web --overwrite CONTENT_URL_PREFIX=${CONTENT_URL_PREFIX} WORKSHOPS_URLS=${WORKSHOPS_URLS}

