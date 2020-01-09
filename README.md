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
