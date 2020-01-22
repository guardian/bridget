const i32 THRIFT_PACKAGE_VERSION = "0.26.0"

struct AdSlot {
    1: required i32 x;
    2: required i32 y;
    3: optional i32 height;
    4: optional i32 width;
}

service Native {
    void insertAdverts(1:list<AdSlot> adSlots),
    i32 nativeThriftVersionNumber(),
}
