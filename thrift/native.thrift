struct AdSlot {
    1: required i32 x;
    2: required i32 y;
    3: optional i32 height;
    4: optional i32 width;
}

struct Image {
    1: required string url;
    2: optional string caption;
    3: optional string credit;
}

service Native {
    void insertAdverts(1:list<AdSlot> adSlots),
    i32 nativeThriftPackageVersion(),
    bool isPremiumUser(),
    void launchSlideshow(1:list<Image> images, 2:i32 selectedIndex),
}
