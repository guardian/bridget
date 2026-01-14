# Bridget
This repo contains the thrift definitions defining the API between native layers (iOS, Android) and [Webview](https://github.com/guardian/dotcom-rendering).

The repo is also responsible for generating and publishing packages to be used by iOS, Android and the Webview.

## Thrift definitions
`native.thrift` are the functions to be implemented by iOS and Android. The webview will be able to call these functions with the specified arguments.

## Generated packages
The Swift and TypeScript packages are generated and published using this [GitHub action](.github/workflows/release.yml).

- The TypeScript package can be installed from [NPM](https://www.npmjs.com/package/@guardian/bridget)
- Swift package can be installed with Swift Package Manager from [GitHub](https://github.com/guardian/mobile-apps-thrift-swift)

For Android, Java interfaces for Bridget services are generated at build time [in the Bridget module](https://github.com/guardian/android-news-app/blob/ffe36dbeb4a6c75709dba526a9b0e707a8f982a5/bridget/build.gradle.kts#L24-L31).


## Adding a new function
1. Define the function in `native.thrift` if it needs to be implemented in Swift & Kotlin
2. Make sure to add a comment above the function to document what it does. It's a good idea to add the version it was available from too (this will be a minor update to the latest tag)
3. Run `npx changeset` to create a changeset file describing your changes and the version bump type
4. Make a pull request. It would be good to get a review from all teams who would need to implement or call the function. e.g. Android, iOS and apps-rendering
5. Merging into main will trigger the Changesets action to create or update a "Version Packages" PR
6. When the "Version Packages" PR is merged, the workflow will automatically publish the new packages
7. If you don't see the published packages, start by inspecting the GitHub action run
8. Bump the version in your repo (iOS, Android or apps-rendering) and implement the function or make the function call. Make sure the function is always available in the current environment. This can be done by checking the thrift version number of the webView or native layer

## Releasing Bridget

Bridget is released by the [`release.yml`](.github/workflows/release.yml) GitHub Action. The repository uses:

- **npm trusted publishing**: No NPM_TOKEN needed. Publishing to npm is authenticated via GitHub's OIDC token. See [npm's trusted publishing docs](https://docs.npmjs.com/trusted-publishers) for more information.
- **GitHub App authentication**: The workflow uses a GitHub App to publish Swift and Android packages. This requires:
  - `APP_ID` (repository variable)
  - `GH_APP_PRIVATE_KEY` (repository secret)

  The GitHub App needs read/write permissions for the [`guardian/bridget-swift`](https://github.com/guardian/bridget-swift) and [`guardian/bridget-android`](https://github.com/guardian/bridget-android) repositories.

## Testing a prerelease

You can use prereleases to test a new version of the models across web, Android and iOS without making a full release.

To do this, create a new prerelease in the GitHub releases UI (or [click here](https://github.com/guardian/bridget/releases/new?prerelease=true)). The tag is used as the version. For example, once the prerelease workflow has finished running for a prerelease created with tag `v0.0.0-2024-02-16`:

* install from `npm`: `npm install @guardian/bridget@v0.0.0-2024-02-16`
* find the `swift` package: `https://github.com/guardian/bridget-swift/tree/v0.0.0-2024-02-16`
* find the `android` package: `https://github.com/guardian/bridget-android/tree/v0.0.0-2024-02-16`

**Note:** The prerelease workflow is part of the same [`release.yml`](.github/workflows/release.yml) workflow file and also uses npm trusted publishing.

### GitHub Action fails with "Authentication failed"

This is likely caused by an issue with the GitHub App credentials. To fix this:
1. Check that the `GH_APP_PRIVATE_KEY` repository secret is valid and hasn't expired
2. Verify that the `APP_ID` repository variable is correct
3. Ensure the GitHub App has the necessary read/write permissions for the bridget-swift and bridget-android repositories

**Note:** updating secrets and variables requires admin permissions on the repository.

### Setting the version bump

Versions are managed by [Changesets](https://github.com/changesets/changesets). When you make changes that require a version bump:

1. Run `npx changeset` in your local repository
2. Select the type of version bump (patch, minor, or major)
3. Provide a description of the changes
4. Commit the generated changeset file (in `.changeset/`) with your pull request

When your PR is merged to main, the Changesets GitHub Action will:
- Create or update a "Version Packages" PR that includes all pending changesets
- When you merge that PR, the workflow will automatically publish the new version

For more information, see the [Changesets documentation](https://github.com/changesets/changesets/blob/main/docs/intro-to-using-changesets.md).

## About the name
The name Bridget was chosen out of a list of a dozen suggestions, containing mostly bridge related puns.
