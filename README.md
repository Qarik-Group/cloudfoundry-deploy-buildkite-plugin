# Buildkite Plugin to Deploy to Cloud Foundry

## Usage

Sample usage with minimum required arguments:

```yaml
steps:
  - label: ":cloudfoundry:"
    plugins:
      starkandwayne/cloudfoundry-deploy#HEAD:
        api: https://api.run.pivotal.io
        username: drnic@starkandwayne.com
        organization: starkandwayne
        space: buildkite-plugin-tests
```

The `username` argument is optional, if you provide `$CF_USERNAME` via an agent hook.

You can provide the password via `$CF_PASSWORD` from an agent hook. If you provide the password via a different environment variable, then declare its name with `password_env` argument:

```yaml
steps:
  - label: ":cloudfoundry:"
    plugins:
      starkandwayne/cloudfoundry-deploy#HEAD:
        api: https://api.run.pivotal.io
        username: drnic@starkandwayne.com
        password_env: CF_PASSWORD_DRNIC
        organization: starkandwayne
        space: buildkite-plugin-tests
```

The `cf push` command will look for `-f manifest.yml` by default. Use `manifest_path` argument to explicitly declare the location of the manifest.

```yaml
steps:
  - label: ":cloudfoundry:"
    plugins:
      starkandwayne/cloudfoundry-deploy#HEAD:
        api: https://api.run.pivotal.io
        username: drnic@starkandwayne.com
        organization: starkandwayne
        space: buildkite-plugin-tests
        manifest_path: cf/manifest.yml
```

## Testing

Test plugin using [buildkite-plugin-tester](https://github.com/buildkite-plugins/buildkite-plugin-tester):

```
docker run -v $(pwd):/plugin buildkite/plugin-tester:latest bats /plugin/tests

# or

docker-compose run tests
```
