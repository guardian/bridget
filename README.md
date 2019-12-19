# mobile-apps-thrift
Thrift files defining the API between native layers (iOS, Android) and [Webview](https://github.com/guardian/apps-rendering).

`native.thrift` are the functions to be implemented by iOS and Android. The webview will be able to call these functions with the specified arguments.

`webview.thrift` are the functions to be implemented by [Webview](https://github.com/guardian/apps-rendering). iOS and Android will be able to call these functions with the specified arguments.
