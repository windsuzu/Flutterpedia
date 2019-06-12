class HomeView {
  final AppInfo appInfo;

  HomeView(this.appInfo);

  void showMyCustomList() => MyCustomList(appInfo);
}

class MyCustomList {
  final AppInfo appInfo;

  MyCustomList(this.appInfo);

  void showPostItem() => PostItem(appInfo);
}

class PostItem {
  final AppInfo appInfo;

  PostItem(this.appInfo);

  void showPostMenu() => PostMenu(appInfo);
}

class PostMenu {
  final AppInfo appInfo;

  PostMenu(this.appInfo);

  void showPostAction() => PostAction(appInfo);
}

class PostAction {
  final AppInfo appInfo;

  PostAction(this.appInfo);

  void showLikeButton() => LikeButton(appInfo);
}

// 只是為了顯示 appInfo 中的 likeCount
// 結果 Widget tree 上的 parent 都要注入 appInfo
class LikeButton {
  final AppInfo appInfo;

  LikeButton(this.appInfo);

  void displayLikeCount() => print('${appInfo.likeCount}');
}

// Data Model
class AppInfo {
  int likeCount = 0;

  void addLike() => likeCount++;
}
