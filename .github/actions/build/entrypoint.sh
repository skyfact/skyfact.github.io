#!/bin/sh
set -e

## necessary environment variables:
##   ::ITEM::                      ::DESCRIPTION::                  ::DEFAULT::
##   github_actor                  repository ownership
##   github_token                  github authority
##   source_branch                 branch to pull hugo source
##   release_branch                branch to release changes
##   git_actor_email               email for git commit
##   git_actor_name                name for git commit
##   commit_format_string          commit message                   "rebuilding site on $(date) -- auto gen"


# setup
base_dir=$(pwd)
commit_format_string=${commit_format_string:-"rebuilding site on $(date) -- auto gen"}
remote_repo="https://${github_actor}:${github_token}@github.com/${github_actor}.github.io.git"
git config --local user.email $git_actor_email
git config --local user.name $git_actor_name


# clone source
git clone -b --recursive $source_branch $remote_repo sources
git clone -b $release_branch $remote_repo sources/public


# generate static pages
cd base_dir/sources
hugo


# commit changes
cd base_dir/sources/public
git add .
git commit -m


# release changes
git push $remote_repo HEAD:$release_branch
