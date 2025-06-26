struct Rect {
    1: required double x;
    2: required double y;
    3: required double height;
    4: required double width;
}

struct AdSlot {
    1: required Rect rect;
    2: optional map<string,string> targetingParams;
    3: required bool isSquare;
}

struct Topic {
    1: required string id;
    2: required string displayName;
    3: required string type;
}

struct Image {
    1: required string url;
    2: required double width;
    3: required double height;
    4: optional string caption;
    5: optional string credit;
}

struct Epic {
    1: required string title;
    2: required string body;
    3: required string firstButton;
    4: optional string secondButton;
}

struct MaybeEpic {
    1: optional Epic epic;
}

struct VideoSlot {
    1: required Rect rect;
    2: required string videoId;
    3: required string posterUrl;
    4: optional i32 duration;
}

struct MetricPaint {
    1: required double time;
}

struct MetricFont {
    1: required double duration;
    2: optional i32 size;
    3: optional string name;
}

union Metric {
    1: MetricPaint firstPaint;
    2: MetricPaint firstContentfulPaint;
    3: MetricFont font;
}

enum MediaEvent {
    request = 0,
    ready = 1,
    play = 2,
    percent25 = 3,
    percent50 = 4,
    percent75 = 5,
    end = 6
}

struct VideoEvent {
    /** for YouTube Atoms videoId should the atom id  */
    1: required string videoId;
    2: required MediaEvent event;
}

enum PurchaseScreenReason {
    hideAds = 0,
    epic = 1
}

enum SignInScreenReason {
    accessDiscussion = 0
    postComment = 1,
    recommendComment = 2,
    replyToComment = 3,
    reportComment = 4
}

enum SignInScreenReferrer {
    accessDiscussion = 0
    postComment = 1,
    recommendComment = 2,
    replyToComment = 3,
    reportComment = 4
}

enum NativePlatform {
    ios = 0,
    android = 1
}

service Environment {
    string nativeThriftPackageVersion()
    bool isMyGuardianEnabled()
    bool isListenToArticleEnabled()
}

service Commercial {
    void insertAdverts(1:list<AdSlot> adSlots),
    void updateAdverts(1:list<AdSlot> adSlots),
    void sendTargetingParams(1:map<string, string> targetingParams)    
}

service Acquisitions {
    void launchPurchaseScreen(1: PurchaseScreenReason reason),
    MaybeEpic getEpics(),
    void epicSeen()
}

service Tag {
    bool follow(1:Topic topic),
    bool unfollow(1:Topic topic),
    bool isFollowing(1:Topic topic),
}

service Notifications {
    bool follow(1:Topic topic),
    bool unfollow(1:Topic topic),
    bool isFollowing(1:Topic topic),
}

service ListenToArticle {
    bool isAvailable(1: string articleId)
    bool play(1: string articleId)
    bool isPlaying(1: string articleId)
    bool pause(1: string articleId)
}

service User {
    bool isPremium(),
    list<string> filterSeenArticles(1:list<string> articleIds),
    string discussionId(),
    bool doesCcpaApply(),
    bool isSignedIn(),
    bool signIn(1:SignInScreenReason reason, 2:SignInScreenReferrer referrer),
}

service Gallery {
    void launchSlideshow(1:list<Image> images, 2:i32 selectedIndex, 3:string articleTitle)
}

service Videos {
    void insertVideos(1:list<VideoSlot> videoSlots),
    void updateVideos(1:list<VideoSlot> videoSlots),
    void sendVideoEvent(1:VideoEvent videoEvent),
    /**
     * This method is used by the web layer to instruct the native layer to activate or deactivate fullscreen mode
     * This is currently only required for Android as the fullscreen control on the YouTube player in Android webviews is a no-op
     *
     * @param isFullscreen true if the web layer is fullscreen, false otherwise
     * @returns true if the native operation was successful, false otherwise
     *
     * On Android, this method will return true if the operation was successful, false otherwise
     * On iOS, this method will always return false
     */
    bool setFullscreen(1:bool isFullscreen),
}

service Metrics {
    void sendMetrics(1:list<Metric> metrics)
}

enum DiscussionNativeError {
    UNKNOWN_ERROR = 0
}

union DiscussionServiceResponse {
    /** the JSON parsing will be done in DCR */
    1: string response;
    2: DiscussionNativeError error;
}

/** only available for signed in user, see https://github.com/guardian/bridget/issues/149 */
service Discussion {
    DiscussionServiceResponse recommend(1:string commentId),
    DiscussionServiceResponse comment(1:string shortUrl, 2:string body),
    DiscussionServiceResponse reply(1:string shortUrl, 2:string body, 3:string parentCommentId),
    DiscussionServiceResponse getUserProfile(),
}

service Analytics {
    void sendTargetingParams(1:map<string, string> targetingParams)
}

service Navigation {
    void openPrivacySettings(),
    void openPrivacyPolicy()
}

/**
 * Service to manage requests from the weblayer related to newsletter subscriptions.
 * added  version 2.0.0
 * methods:
 *  - requestSignUp: request to sign up to a newsletter using an email address entered by the user.
 * Returns `true` if the request was successful, `false` if it failed for any reason. Exceptions
 * thrown will be discarded.
 */
service Newsletters {
    bool requestSignUp(1: string emailAddress, 2:string newsletterIdentityName)
}

service Interaction {
    /**
     * Notify the native layer to disable the article swipe feature.
     *
     * @param disableSwipe true if native needs to disable article swipe
     */
    void disableArticleSwipe(1:bool disableSwipe)
}

service Interactives {
    NativePlatform getNativePlatform(),
}