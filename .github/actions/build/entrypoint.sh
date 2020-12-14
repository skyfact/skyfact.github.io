#!/bin/sh
set -e

## necessary environment variables:
##   ::ITEM::                      ::DESCRIPTION::                  ::DEFAULT::
##   customized_actor              repository ownership             "${GITHUB_ACTOR}"
##   token                         github authority                 --  REQUIRED  --
##   source_branch                 branch to pull hugo source       "src"
##   release_branch                branch to release changes        "main"
##   git_actor_email               email for git commit             "${customized_actor}@users.noreply.github.com"
##   git_actor_name                name for git commit              "${customized_actor}"
##   commit_format_string          commit message                   "rebuilding site on $(date) -- auto gen"


# setup
base_dir=$(pwd)
customized_actor=${INPUT_CUSTOMIZED_ACTOR:-$GITHUB_ACTOR}
token=${GITHUB_TOKEN}
source_branch=${INPUT_SOURCE_BRANCH:-'src'}
release_branch=${INPUT_RELEASE_BRANCH:-'main'}
git_actor_email=${INPUT_GIT_ACTOR_EMAIL:-"${customized_actor}@users.noreply.github.com"}
git_actor_name=${INPUT_GIT_ACTOR_NAME:-"${customized_actor}"}
commit_format_string=${INPUT_COMMIT_FORMAT_STRING:-"rebuilding site on $(date) -- auto gen"}
remote_repo="https://${customized_actor}:${token}@github.com/${customized_actor}.github.io.git"
git config --local user.email ${git_actor_email}
git config --local user.name ${git_actor_name}


# clone source
git clone -b --recursive ${source_branch} ${remote_repo} sources
git clone -b ${release_branch} ${remote_repo} sources/public


# generate static pages
cd base_dir/sources
hugo


# commit changes
cd base_dir/sources/public
git add .
git commit -m ${commit_format_string}


# release changes
git push ${remote_repo} HEAD:${release_branch}
