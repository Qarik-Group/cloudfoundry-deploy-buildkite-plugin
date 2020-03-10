#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

# doesn't work on Docker for Mac https://github.com/docker/for-mac/issues/900
# export CF_STUB_DEBUG=/dev/tty

setup() {
  export BUILDKITE_PLUGIN_CLOUDFOUNDRY_DEPLOY_API=https://api.mycf.com
  export BUILDKITE_PLUGIN_CLOUDFOUNDRY_DEPLOY_USERNAME=drnic@starkandwayne.com
}

@test "cf push from env vars" {
  stub cf "api https://api.mycf.com : echo cf api"
  stub cf "auth drnic@starkandwayne.com : echo cf auth"
  # stub cf "target : echo cf target"
  # stub cf "push : echo cf push"

  run $PWD/hooks/command
  assert_success

  unstub cf
}