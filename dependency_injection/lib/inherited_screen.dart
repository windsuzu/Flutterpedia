import 'package:flutter/material.dart';
import 'motivation.dart';

// 在 Android Studio 可以透過 inh 指令建立 InheritedWidget
class InheritedInjection extends InheritedWidget {
  final AppInfo appInfo;

  final Function() increment;

  InheritedInjection({
    Key key,
    @required this.appInfo,
    @required this.increment,
    @required Widget child,
  }) : super(key: key, child: child);

  static InheritedInjection of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(InheritedInjection)
        as InheritedInjection;
  }

  // 當 widget tree 中的 data 被改變時，要不要通知依賴該 data 的 widgets
  @override
  bool updateShouldNotify(InheritedInjection old) {
    return old.appInfo != appInfo;
  }
}

class InheritedScreen extends StatefulWidget {
  @override
  _InheritedScreenState createState() => _InheritedScreenState();
}

class _InheritedScreenState extends State<InheritedScreen> {
  AppInfo appInfo = AppInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inherited Example'),
        actions: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.account_circle),
                color: Colors.white,
                onPressed: () {},
              ),
              _buildBadge()
            ],
          )
        ],
      ),
      // 在頂端建立 InheritedWidget
      body: InheritedInjection(
        increment: _increment,
        appInfo: appInfo,
        child: Center(
          child: LikeButton(),
        ),
      ),
    );
  }

  _increment() {
    setState(() => appInfo.likeCount++);
  }

  Widget _buildBadge() {
    return appInfo.likeCount == 0
        ? Container()
        : Positioned(
            right: 11,
            top: 11,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: BoxConstraints(
                minWidth: 14,
                minHeight: 14,
              ),
              child: Text(
                '${appInfo.likeCount}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
  }
}

class LikeButton extends StatefulWidget {
  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    final AppInfo _appInfo = InheritedInjection.of(context).appInfo;

    return FlatButton(
        shape: StadiumBorder(side: BorderSide(width: 2, color: Colors.blue)),
        padding: EdgeInsets.all(8),
        child: Text('${_appInfo.likeCount} likes'),
        onPressed: InheritedInjection.of(context).increment);
  }
}
