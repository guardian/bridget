struct AdSlot {
    1: required i32 x;
    2: required i32 y;
    3: optional i32 height;
    4: optional i32 width;
}

struct Topic {
	1: required string id;
}

service Native {
    void insertAdverts(1:list<AdSlot> adSlots),
    i32 nativeThriftPackageVersion(),
    void follow(topic: Topic),
    void unfollow(topic: Topic),
    bool isFollowing(topic: Topic),
}
