# bridget

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
