struct AdSlot {
    1: required i32 x;
    2: required i32 y;
    3: optional i32 height;
    4: optional i32 width;
}

service Native {
    void insertAdverts(1:list<AdSlot> adSlots),
    i32 nativeThriftPackageVersion(),
}
