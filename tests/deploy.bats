#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

# doesn't work on Docker for Mac https://github.com/docker/for-mac/issues/900
# export CF_STUB_DEBUG=/dev/tty

setup() {
  export BUILDKITE_PLUGIN_CLOUDFOUNDRY_DEPLOY_API=https://api.mycf.com
  export BUILDKITE_PLUGIN_CLOUDFOUNDRY_DEPLOY_USERNAME=drnic@starkandwayne.com
  export BUILDKITE_PLUGIN_CLOUDFOUNDRY_DEPLOY_APPNAME=myapp
  export BUILDKITE_PLUGIN_CLOUDFOUNDRY_DEPLOY_ORGANIZATION=myorg
  export BUILDKITE_PLUGIN_CLOUDFOUNDRY_DEPLOY_SPACE=myspace
  export BUILDKITE_PLUGIN_CLOUDFOUNDRY_DEPLOY_SKIP_ZERO_DOWNTIME=true
}

@test "cf push" {
  stub cf \
    "api https://api.mycf.com : echo cf api" \
    "auth drnic@starkandwayne.com : echo cf auth" \
    "target -o myorg -s myspace : echo cf target" \
    "push : echo 'cf push - no manifest provided'" \
    "app myapp --guid : echo SOMEGUID" \
    "curl /v3/apps/SOMEGUID -X PATCH -d \{\"metadata\":\{\"annotations\":\{\"git-commit\":\"abcdef\"\,\"git-origin-url\":\"https://github.com/some/repo.git\"\}\}\} : set annotations" \
    "curl /v3/apps/SOMEGUID : echo {}"

  stub git \
    "rev-parse --short HEAD : echo abcdef" \
    "config remote.origin.url : echo https://github.com/some/repo.git"

  run $PWD/hooks/command
  assert_success

  unstub cf
  unstub git
}