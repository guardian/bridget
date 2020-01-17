# mobile-apps-thrift
This repo contains the thrift definitions defining the API between native layers (iOS, Android) and [Webview](https://github.com/guardian/apps-rendering).

The repo is also responsible for generating and publishing packages to be used by iOS, Android and the Webview.

## Thrift definitions
`native.thrift` are the functions to be implemented by iOS and Android. The webview will be able to call these functions with the specified arguments.

`webview.thrift` are the functions to be implemented by the [Webview](https://github.com/guardian/apps-rendering). iOS and Android will be able to call these functions with the specified arguments.

## Generated packages
The Swift and Java packages are generated and published using this [GitHub action](https://github.com/guardian/mobile-apps-thrift/blob/master/.github/actions/generate-native-package/action.yml)

- The TypeScript package can be installed from [NPM](https://www.npmjs.com/package/mobile-apps-thrift-typescript)
- Swift package can be installed with Swift Package Manager from [GitHub](https://github.com/guardian/mobile-apps-thrift-swift)


## Adding a new function
1. Define the function in `native.thrift` if it needs to be implemented in Swift & Kotlin or define the function in `webview.thrift` if it needs to be implemented in the webView
2. Make sure to add a comment above the function to document what it does. It's a good idea to add the version it was available from too (this will be a minor update to the latest tag)
3. Make a pull request. It would be good to get a review from all teams who would need to implement or call the function. e.g. Android, iOS and apps-rendering
4. Merging into master will automatically run the GitHub actions to publish packages
5. If you don't see the published packages, start by inspecting the GitHub action started on the branch that was merged into master
