#!/bin/bash
echo "git-user:x:$(id -u):$(id -g):Git User:/tmp:/bin/bash" > /tmp/fake_passwd

docker run \
    --rm \
    --tty \
    --interactive \
    --user $(id -u):$(id -g) \
    --workdir /data \
    --env GIT_SSH_COMMAND='ssh -i /data/.ssh/id_rsa -o "StrictHostKeyChecking=no"' \
    --volume ${HOME}/.ssh:/data/.ssh \
    --volume $(pwd):/data \
    --volume ~/.azure:/data/.azure \
    --volume ~/.gitconfig:/data/.gitconfig \
    --volume /tmp/fake_passwd:/etc/passwd \
    devopsinfra/docker-terragrunt:azure-tf-1.0.0-tg-0.30.7 bash

docker run \
    --rm \
    --tty \
    --interactive \
    --user $(id -u):$(id -g) \
    --workdir /data \
    --env GIT_SSH_COMMAND='ssh -i /data/.ssh/id_rsa -o "StrictHostKeyChecking=no"' \
    --env ARM_CLIENT_ID="${ARM_CLIENT_ID?}" \
    --env ARM_CLIENT_SECRET="${ARM_CLIENT_SECRET?}" \
    --env ARM_SUBSCRIPTION_ID="${ARM_SUBSCRIPTION_ID?}" \
    --env ARM_TENANT_ID="${ARM_TENANT_ID?}" \
    --env ARM_ACCESS_KEY="${ARM_ACCESS_KEY?}" \
    --env GOOGLE_CREDENTIALS="${GOOGLE_CREDENTIALS?}" \
    --env GOOGLE_PROJECT="${GOOGLE_PROJECT?}" \
    --env GOOGLE_REGION="${GOOGLE_REGION?}" \
    --env GOOGLE_ZONE="${GOOGLE_ZONE?}" \
    --volume ${HOME}/.ssh:/data/.ssh \
    --volume $(pwd):/data \
    --volume ~/.azure:/data/.azure \
    --volume /tmp/fake_passwd:/etc/passwd \
    devopsinfra/docker-terragrunt:azure-tf-1.0.0-tg-0.30.7 terragrunt run-all plan --terragrunt-working-dir ./
