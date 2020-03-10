#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

@test "cf push from env vars" {
  stub cf "push -f manifest.yml : echo Deploying"

  run $PWD/hooks/command
  assert_success

  unstub cf
}