# bridget

## 8.7.5

### Patch Changes

- 92e7a75: Bump lodash from 4.17.21 to 4.17.23

## 8.7.4

### Patch Changes

- fc4c026: Add repository URL to published package.json

## 8.7.3

### Patch Changes

- 7c2c001: add README to package
- 52bbd07: use npm trusted publishing

## 8.7.2

### Patch Changes

- 284e7ff: Update Node to v24 from v22. This should be an internal change only and shouldn't affect consumers.

## 8.7.1

### Patch Changes

- a29b0e2: Update Node to v22 from v20. This should be an internal change only and shouldn't affect consumers.

## 8.7.0

### Minor Changes

- d39357c: Add AbTesting Service

## 8.6.0

### Minor Changes

- c3f6ff3: Add ListenToArticle.getAudioDurationSeconds

## 8.5.1

### Patch Changes

- b611f15: Remove isListenToArticleEnabled flag as we won't use it

## 8.5.0

### Minor Changes

- da6639f: Add methods for listen to article button

## 8.4.0

### Minor Changes

- 18a85c5: Add nativePlatform function

## 8.3.3

### Patch Changes

- 62ddf97: Update Bridget Version to Set Minimum Requirement for Liveblogs

  This version update introduces no changes to Bridget itself. Its sole purpose is to establish a minimum Bridget version requirement for DCAR liveblogs. This is necessary because Android recently fixed an ad-related bug, allowing DCAR liveblogs to be released in production.

## 8.3.2

### Patch Changes

- 95506b8: Update bridget patch version to re-publish bridget-android

  This version update doesn't have any changes in bridget.It's only purpose is to re-publish the bridget-android kotlin library with new thrift version.

## 8.3.1

### Patch Changes

- e68f9a2: Update bridget version after horizontal scroll release in prod

  This version update doesn't have any changes in bridget. The Bridget version 8.1.0 that introduced Interaction service hadn't been fully implemented in the native app. Now the implementation is completed in the android, so we are updating bridget in order to rely on this version in MAPI for articles that need the Interaction service.

## 8.3.0

### Minor Changes

- 68b1fff: Copy sendTargetingParams method from analytics to commercial service

## 8.2.0

### Minor Changes

- be4b32d: Update to french-thrift@v0.21.0-gu2

## 8.1.0

### Minor Changes

- bc1eda3: Add Service Interaction and disableArticleSwipe function

## 8.0.0

### Major Changes

- e7036dc: Replace `void fullscreen()` method with `bool setFullscreen(bool isFullscreen)`

## 7.0.0

### Major Changes

- ea19d0f: Add sendVideoEvent and fullscreen methods to Videos service

  The sendVideoEvent method is required to send video events from webviews to the native layer so that they can be forwarded to Ophan. Webviews do not have access to the Ophan page view id and the native layer will also handle offline mode and batching of requests.

  The fullscreen method is required for Android as the web YouTube player performs a no-op for fullscreen on Android. We therefore need to instruct the native layer to resize the player into a fullscreen view.

## 6.0.0

### Major Changes

- ae1aa8a: Treat DiscussionServiceResponse as an opaque `string`.

  This a major change and supercedes the version 5.0.0,
  while keeping the Native and DCAR implementations simpler.

## 5.0.0

### Major Changes

- f3fefa7: Add remaining discussion methods

## 4.0.0

### Major Changes

- a717da0: Return a boolean when a user signs in

## 3.0.0

### Major Changes

- 3c8eb3c: Replace previous disucssion service stubs with new recommend signature

## 2.9.0

### Minor Changes

- 7c91206: Add `isSignedIn` and `signIn` methods to `User` service

## 2.8.1

### Patch Changes

- 798b422: Version bump to trigger a release

## 2.8.0

### Minor Changes

- 6c990e1: Compile models with `guardian/french-thrift@0.19.0-gu1`
