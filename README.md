# Meta package for dotfiles

This is an ellipsis package that acts as a meta package for running my personal dotfiles.

## Installation

1. Ensure git is installed, and checkouts automatically use the right line endings (run `git config --global core.autocrlf false` on WSL).
2. Ensure ssh access to your github account is set up and working, including adding entries to ~/.ssh/config so that the git user is used instead of your local one when connecting to github.com. Also check that add keys to agent is set in the ~/.ssh/config file.
3. Install [chocolatey](https://chocolatey.org/install).
4. Install [ellipsis.sh](https://ellipsis.sh).
5. Restart the terminal to update the path.
6. Create .ellipsisrc at the home folder with the following contents:
```
export ELLIPSIS_USER=katharinegillis
export ELLIPSIS_PROTO=ssh
```
7. Install the package using `ellipsis install desktop-work`