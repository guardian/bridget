struct AdSlot {
    1: i32 x;
    2: i32 y;
    3: optional i32 height;
    4: optional i32 width;
}

service Native {
    void insertAdverts(1:list<AdSlot> adSlots),
    i32 webviewVersionNumber(),
}
