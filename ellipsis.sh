#!/usr/bin/env bash

packages=(
    katharinegillis/windowsterminal
    katharinegillis/vcxsrv
    katharinegillis/firefox
    katharinegillis/slack
    katharinegillis/sublime
    katharinegillis/androidstudio
    katharinegillis/dockerdesktop
    katharinegillis/system
    katharinegillis/git
    katharinegillis/docker
    katharinegillis/utils
    katharinegillis/node
    katharinegillis/php
    katharinegillis/phpstorm
    katharinegillis/adminer
    katharinegillis/jade
);

# Store the current package name because it changes in certain circumstances
packageName=$PKG_NAME;

pkg.install() {
    pkg.link

    # Install the packages
    installUpdatePackages
}

pkg.link() {
    [ -d "$PKG_PATH/files" ] && fs.link_files $PKG_PATH/files
    [ -d "$PKG_PATH/bin" ] && fs.link_rfiles $PKG_PATH/bin $HOME/bin
}

pkg.pull() {
    # Check for updates on git
    git remote update 2>&1 > /dev/null
    if git.is_behind; then
        # Unlink files
        hooks.unlink

        # Pull down the updates
        git.pull

        # Re-link files
        pkg.link
    fi

    # Install new packages and update existing ones
    installUpdatePackages

    # Inform user of sourcing their bash to refresh their profile in case it changed
    echo ""
    echo -e "\e[33mPlease run \"\e[0msource .bash_profile\e[33m\" to refresh profile.\e[0m"
}

pkg.uninstall() {
    # Remove managed packages
    removePackages

    # Uninstall self
    hooks.uninstall
}

installUpdatePackages() {
    # Install new packages or update existing ones from the list
    for package in ${packages[*]}; do
	IFS='/' read -ra packageParsed <<< "$package"
        ellipsis.list_packages | grep "$ELLIPSIS_PACKAGES/${packageParsed[1]}\( \|\$\)" 2>&1 > /dev/null;
        if [ $? -ne 0 ]; then
            echo -e "\e[32mInstalling $package...\e[0m"
            $ELLIPSIS_PATH/bin/ellipsis install $package;
            [ $? -eq 1 ] && exit
        else
            echo -e "\e[32mUpdating $package...\e[0m"
            $ELLIPSIS_PATH/bin/ellipsis pull ${packageParsed[1]};
            [ $? -eq 1 ] && exit
        fi
    done

    # Uninstall orphaned packages
    for package in $(ellipsis.list_packages); do
        name=$(pkg.name_from_path $package)
        echo ${packages[*]} | grep "$name" 2>&1 > /dev/null
        if [ $? -ne 0 ] && [[ "$name" != "$packageName" ]]; then
            echo -e "\e[32mUninstalling $package...\e[0m"
            $ELLIPSIS_PATH/bin/ellipsis uninstall $package;
        fi
    done
}

removePackages() {
    # Install new packages or update existing ones from the list
    for package in ${packages[*]}; do
	IFS='/' read -ra packageParsed <<< "$package"
        ellipsis.list_packages | grep "$ELLIPSIS_PACKAGES/${packageParsed[1]}\( \|\$\)" 2>&1 > /dev/null;
        if [ $? -eq 0 ]; then
            echo -e "\e[32mUninstalling $package...\e[0m"
            $ELLIPSIS_PATH/bin/ellipsis uninstall ${packageParsed[1]};
        fi
    done
}
