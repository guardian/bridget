struct AdSlot {
    1: required i32 x;
    2: required i32 y;
    3: optional i32 height;
    4: optional i32 width;
    5: optional map<string,string> adTargeting;
}

struct Topic {
    1: required string id;
    2: required string displayName;
    3: required string type;
}

struct Image {
    1: required string url;
    2: optional string caption;
    3: optional string credit;
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

service Environment {
    string nativeThriftPackageVersion()
}

service Commercial {
    void insertAdverts(1:list<AdSlot> adSlots),
    void updateAdverts(1:list<AdSlot> adSlots)
}

service Acquistions {
    void launchFrictionScreen(),
    MaybeEpic getEpics(),
    void epicSeen()
}

service Notifications {
    bool follow(1:Topic topic),
    bool unfollow(1:Topic topic),
    bool isFollowing(1:Topic topic),
}

service User {
    bool isPremium()
}

service Gallery {
    void launchSlideshow(1:list<Image> images, 2:i32 selectedIndex, 3:string articleTitle)
}
