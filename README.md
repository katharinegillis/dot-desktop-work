# Meta package for dotfiles

This is an ellipsis package that acts as a meta package for running my personal dotfiles.

## Installation

1. Ensure git is installed, and checkouts automatically use the right line endings (run `git config --global core.autocrlf false` on WSL).
2. Ensure ssh access to your github account is set up and working, including adding entries to ~/.ssh/config so that the git user is used instead of your local one when connecting to github.com.
3. Install [ellipsis.sh](https://ellipsis.sh).
4. Create .ellipsisrc at the home folder with the following contents:
```
export ELLIPSIS_USER=katharinegillis
export ELLIPSIS_PROTO=ssh
```
5. Install the package using `ellipsis install desktop`