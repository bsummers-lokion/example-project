# Example project

- This file was added as the first commit to the `main` branch in a new repository. That's it.
- This file was modified as the first commit to the `develop` branch in an existing repository.
- This file was modified to change the verb tenses on the two lines above from `is` to `was` because it looked weird.
- A sample Rust application that prints Hello World was added to this repository using `cargo init`.
- The sample Rust application was changed to run a Twitter clone server.
- A public image repository was created for this project at https://hub.docker.com/numbermess/example-project
- A read/write token was generated for the repository at https://hub.docker.com/settings/security. Store it somewhere safe.
- Secrets were added to the GitHub repository at https://github.com/bsummers-lokion/example-project/settings/secrets/actions  
- It doesn't matter what these names are, they just need to match up to the symbols you'll use in your GitHub workflow files.
  - `DOCKER_HUB_USERNAME` the repository owner. In this case, the value is `numbermess`
  - `DOCKER_HUB_TOKEN` the token value generated in a previous step
- An action was added to `.github/workflows` named `build.yaml`. It is mostly copy and pasted from the example at https://github.com/marketplace/actions/build-and-push-docker-images, but has a couple of changes to when the workflow is run. Namely on commits/merged PRs to the `develop` branch.


## Branch Protection Rules

### main, develop

Set up a branch protection rule for the `main` and `develop` branches. 
In this repository, this setting is located at 
https://github.com/bsummers-lokion/example-project/settings/branches.

- [X] Require a pull request before merging
- [X] Require approvals (at least 1)
- [ ] Allow deletions
- [X] Include administrators

## GitHub Actions

Add some


