# refactored-waffle
Spike repo for testing actions and workflows for validating OpenAPI schema versions

The action uses a containerized version of [openapitools/openapi-diff](https://github.com/OpenAPITools/openapi-diff)

Possible alternative to the diff lib could be [tufin/oasdiff](https://github.com/Tufin/oasdiff)

Install Act to work on the action locally:
```
brew install act
```

If using [act](https://github.com/nektos/act) to dev the action locally run the command below:

```
act pull_request -e /act_data/pull_request.json -s GITHUB_TOKEN=[TOKEN] --privileged --bind
```

or if you are using env and secret files.

```
act pull_request -e /act_data/pull_request.json --env-file ${HOME}/.config/act/.env --secret-file ${HOME}/.config/act/vault.env --privileged --bind
```


Running act currently pollutes the repo root with the following directories and files but are ignored in .gitignore:

```
_actions
base
head
workflow
results
```