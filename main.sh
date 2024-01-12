#!/bin/sh

echo -e "${PLUGIN_SSH_KEY}" > ~/.ssh/gtkey
chmod 400 ~/.ssh/gtkey
echo -e "${PLUGIN_KNOWN_HOSTS}" > ~/.ssh/known_hosts
echo -e 'Host git.lab.kvd.studio\n  Port 3322\n  IdentityFile ~/.ssh/gtkey\n' > ~/.ssh/config

git clone "git@git.lab.kvd.studio:r/${PLUGIN_REPO_NAME}.git"
cd "${PLUGIN_REPO_NAME}"
yq eval "${PLUGIN_YAML_IMAGE_TAG_PATH} = \"${PLUGIN_IMAGE_TAG}\"" --inplace "${PLUGIN_HELM_VALUES_PATH}"

git add "${PLUGIN_HELM_VALUES_PATH}"
git commit -m "Update ${PLUGIN_APP_NAME} release tag to ${PLUGIN_IMAGE_TAG}"
git push
