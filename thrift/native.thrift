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

service Environment {
    string nativeThriftPackageVersion()
    bool isMyGuardianEnabled()
}

service Commercial {
    void insertAdverts(1:list<AdSlot> adSlots),
    void updateAdverts(1:list<AdSlot> adSlots)
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
    void updateVideos(1:list<VideoSlot> videoSlots)
}

service Metrics {
    void sendMetrics(1:list<Metric> metrics)
}

struct DiscussionBadge {
    1: required string name;
}

struct DiscussionUserProfile {
    1: required string userId;
    2: required string displayName;
    3: required string webUrl;
    4: required string apiUrl;
    5: required string avatar;
    6: required string secureAvatarUrl;
    7: required list<DiscussionBadge> badge;
    8: required bool canPostComment;
    9: required bool isPremoderated;
    10: required bool hasCommented;
}

struct DiscussionApiResponse {
    1: required string status;
    2: required i32 statusCode;
    3: required string message;
    4: optional string errorCode;
}

union GetUserProfileResponse {
    1:DiscussionUserProfile profile;
    2:DiscussionNativeError error;
}

struct ReportAbuseParameters {
    1:string commentId;
    2: string categoryId;
    3:optional string reason;
    4:optional string email;
}

enum DiscussionNativeError {
    UNKNOWN_ERROR = 0
}

union DiscussionResponse {
    1: DiscussionApiResponse response;
    2: DiscussionNativeError error;
}

service Discussion {
    DiscussionResponse recommend(1:string commentId),
    GetUserProfileResponse getUserProfile(),
    DiscussionResponse comment(1:string shortUrl, 2:string body),
    DiscussionResponse reply(1:string shortUrl, 2:string body, 3:string parentCommentId),
    DiscussionResponse addUsername(1:string username),
    DiscussionResponse reportAbuse(1:ReportAbuseParameters parameters)
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
