# Bridget
This repo contains the thrift definitions defining the API between native layers (iOS, Android) and [Webview](https://github.com/guardian/dotcom-rendering/tree/main/apps-rendering).

The repo is also responsible for generating and publishing packages to be used by iOS, Android and the Webview.

## Thrift definitions
`native.thrift` are the functions to be implemented by iOS and Android. The webview will be able to call these functions with the specified arguments.

## Generated packages
The Swift and TypeScript packages are generated and published using this [GitHub action](.github/workflows/generate-packages.yml).

- The TypeScript package can be installed from [NPM](https://www.npmjs.com/package/@guardian/bridget)
- Swift package can be installed with Swift Package Manager from [GitHub](https://github.com/guardian/mobile-apps-thrift-swift)

For Android, Java interfaces for Bridget services are generated at build time [in the Bridget module](https://github.com/guardian/android-news-app/blob/ffe36dbeb4a6c75709dba526a9b0e707a8f982a5/bridget/build.gradle.kts#L24-L31).


## Adding a new function
1. Define the function in `native.thrift` if it needs to be implemented in Swift & Kotlin
2. Make sure to add a comment above the function to document what it does. It's a good idea to add the version it was available from too (this will be a minor update to the latest tag)
3. Make a pull request. It would be good to get a review from all teams who would need to implement or call the function. e.g. Android, iOS and apps-rendering
4. Merging into main will automatically run the GitHub actions to publish packages
5. If you don't see the published packages, start by inspecting the GitHub action started on the branch that was merged into main
6. Bump the version in your repo (iOS, Android or apps-rendering) and implement the function or make the function call. Make sure the function is always available in the current environment. This can be done by checking the thrift version number of the webView or native layer

## Releasing Bridget

Bridget is released by the [`generate-packages.yml`](.github/workflows/generate-packages.yml) GitHub Action. The repository needs the following secrets available to the action:

- `NPM_TOKEN`
- `ACCESS_TOKEN`: a GitHub Personal Access Token (PAT). The PAT needs read/write permissions for the [`guardian/bridget-swift`](https://github.com/guardian/bridget-swift) repository. Please use a [Fine Grained PAT](https://github.blog/2022-10-18-introducing-fine-grained-personal-access-tokens-for-github/).

### Setting the version bump

Versions are managed by [`github-tag-action`](https://github.com/anothrNick/github-tag-action). The default bump is a `minor` version. However, you can specify what version bump to perform using a token at the end of your merge commit message.

For example, to perform a patch bump, your merge commit message could look like:

```
Release new version of Bridget. #patch
```

You can use the following tokens:

- `#patch`
- `#minor`
- `#major`
- `#none`, which will not perform a version bump

For more information, see the [`github-tag-action` docs](https://github.com/anothrNick/github-tag-action#bumping).

## About the name
The name Bridget was chosen out of a list of a dozen suggestions, containing mostly bridge related puns.
