#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

setup() {
  export BUILDKITE_PLUGIN_CLOUDFOUNDRY_DEPLOY_API=https://api.mycf.com
}

@test "cf push from env vars" {
  stub cf "api https://api.mycf.com : echo cf api"
  # stub cf "auth : echo cf auth"
  # stub cf "target : echo cf target"
  # stub cf "push : echo cf push"

  run $PWD/hooks/command
  assert_success

  unstub cf
}