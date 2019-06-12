import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppInfo(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Provider Example'),
          actions: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.account_circle),
                  color: Colors.white,
                  onPressed: () {},
                ),
                Badge()
              ],
            )
          ],
        ),
        body: Center(child: LikeButton()),
      ),
    );
  }
}

class Badge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppInfo appInfo = Provider.of<AppInfo>(context);
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
    final AppInfo _appInfo = Provider.of<AppInfo>(context);

    return FlatButton(
        shape: StadiumBorder(side: BorderSide(width: 2, color: Colors.blue)),
        padding: EdgeInsets.all(8),
        child: Text('${_appInfo.likeCount} likes'),
        onPressed: _appInfo.increment);
  }
}

class AppInfo with ChangeNotifier {
  int likeCount = 0;

  void increment() {
    likeCount++;
    notifyListeners();
  }
}
