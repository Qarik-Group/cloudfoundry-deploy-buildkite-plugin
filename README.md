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
        manifest_path: cf/manifest.yml
```

## Testing

Test plugin using [buildkite-plugin-tester](https://github.com/buildkite-plugins/buildkite-plugin-tester):

```
docker run -v $(pwd):/plugin buildkite/plugin-tester:latest bats /plugin/tests

# or

docker-compose run tests
```
