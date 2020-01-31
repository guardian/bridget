struct AdSlot {
    1: required i32 x;
    2: required i32 y;
    3: optional i32 height;
    4: optional i32 width;
}

struct Image {
    1: required string url;
}

service Native {
    void insertAdverts(1:list<AdSlot> adSlots),
    i32 nativeThriftPackageVersion(),
    void launchSlideshow(1:list<Image> images),
}
