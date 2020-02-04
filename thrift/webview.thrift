struct Epic {
	1: required string title;
	2: required string body;
	3: required string firstButton;
	4: optional string secondButton;
}

service Webview {
    i32 webviewThriftPackage(),
    void insertEpics(1:list<Epic> epics),
	void insertEpic(1:Epic epic),
}