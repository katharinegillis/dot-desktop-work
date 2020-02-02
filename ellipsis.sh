#!/usr/bin/env bash

packages=(
    common
);

pkg.install() {
    pkg.pull
}

pkg.pull() {
    for package in ${packages[*]}; do
        ellipsis.list_packages | grep "$ELLIPSIS_PACKAGES/$package" 2>&1 > /dev/null;
        if [ $? -ne 0 ]; then
            $ELLIPSIS_PATH/bin/ellipsis install $package;
        else
            $ELLIPSIS_PATH/bin/ellipsis pull $package;
        fi
    done
}