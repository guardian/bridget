struct AdSlot {
    1: required i32 x;
    2: required i32 y;
    3: optional i32 height;
    4: optional i32 width;
}

struct Topic {
    1: required string id;
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

service Native {
    i32 nativeThriftPackageVersion(),
    void insertAdverts(1:list<AdSlot> adSlots),
    void updateAdverts(1:list<AdSlot> adSlots),
    void launchFrictionScreen(),
    void follow(1:Topic topic),
    void unfollow(1:Topic topic),
    void launchSlideshow(1:list<Image> images, 2:i32 selectedIndex),
    bool isFollowing(1:Topic topic),
    bool isPremiumUser(),
    MaybeEpic getEpics(),
}
