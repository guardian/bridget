---
"bridget": major
---

Add sendVideoEvent and fullscreen methods to Videos service

The sendVideoEvent method is required to send video events from webviews to the native layer so that they can be forwarded to Ophan. Webviews do not have access to the Ophan page view id and the native layer will also handle offline mode and batching of requests.

The fullscreen method is required for Android as the web YouTube player performs a no-op for fullscreen on Android. We therefore need to instruct the native layer to resize the player into a fullscreen view.
