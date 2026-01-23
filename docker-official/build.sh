#!/usr/bin/bash
TMP_BUD="/tmp/IosevkaDockerBuild"
WORK_DIR="/work"
PRIVATE_FILE="private-build-plans.toml"
BUILD_ARGS="$@"
set -e
rm -rf $TMP_BUD
mkdir -p $TMP_BUD
cd $TMP_BUD

[ -f "${WORK_DIR}/$PRIVATE_FILE" ] || {
    echo "No build plans!"
    exit 2
}

[ ! -z "$VERSION_TAG" ] || {
    echo "No version tag!"
    exit 2
}

echo "Fonts building param: $BUILD_ARGS"
echo "Downloading source code tarball ${VERSION_TAG}"

TARGZ_URL="https://github.com/be5invis/Iosevka/archive/${VERSION_TAG}.tar.gz"
if [[ "main" == "$VERSION_TAG" ]] || [[ "dev" == "$VERSION_TAG" ]]; then
    TARGZ_URL="https://github.com/be5invis/Iosevka/archive/refs/heads/${VERSION_TAG}.tar.gz"
fi
curl -LO "$TARGZ_URL" \
    && tar -xf "${VERSION_TAG}.tar.gz" || {
        echo "Decompression failed!"
        exit 2
    }
cd Iosevka*

cp "${WORK_DIR}/${PRIVATE_FILE}" .

echo "Now building fonts ${VERSION_TAG}"

npm install \
    && npm run build -- $BUILD_ARGS \
    && cp -rf dist ${WORK_DIR}/

