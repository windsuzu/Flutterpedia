import 'package:flutter/material.dart';
import 'home_animation.dart';
import 'login_screen.dart';

Map<String, String> items = {
  "Back number": "Universal Sigma",
  "Mr.Children": "TOY'S FACTORY",
  "SPITZ": "Universal Music",
  "Kobukuro": "Warner Music",
  "Sukima Switch": "Ariola Japan",
};

List colors = [Colors.teal[200], Colors.purple[200], Colors.blueAccent[200]];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController _controller;
  HomeAnimation _animation;

  AnimationController _buttonController;
  HomeButtonAnimation _buttonAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _buttonController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1200))
          ..addListener(() {
            if (_buttonController.isCompleted) _pushToLoginPage();
          });
    _animation = HomeAnimation(_controller);
    _buttonAnimation = HomeButtonAnimation(_buttonController);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  void _pushToLoginPage() {
    Navigator.pushReplacement(context,
        PageRouteBuilder(pageBuilder: (context, animation, secAnimation) {
      return FadeTransition(
        opacity: animation,
        child: LoginScreen(),
      );
    }));
  }


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Scaffold(
              body: Container(
            width: screenSize.width,
            height: screenSize.height,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    _profileBackground(),
                    _listView(),
                  ],
                ),
                _fadeBox(screenSize.width, screenSize.height),
                _floatingButton(),
              ],
            ),
          )),
    );
  }

  Widget _profileBackground() {
    return Container(
      alignment: Alignment.center,
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.deepPurple[600], Colors.indigoAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white)),
              padding: EdgeInsets.all(6),
              width: _animation.containerGrowAnimation.value * 200,
              height: _animation.containerGrowAnimation.value * 200,
              child: ClipOval(
                child:
                    Image.asset("assets/avt_superfly.jpg", fit: BoxFit.cover),
              )),
          Container(
            alignment: Alignment.bottomCenter,
            height: 32,
            padding: EdgeInsets.all(16),
            child: Text(
              "Welcome",
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 5,
                  fontSize: _animation.containerGrowAnimation.value * 24),
            ),
          )
        ],
      ),
    );
  }

  Widget _listView() {
    var tiles = [];

    items.keys.toList().asMap().forEach((index, val) {
      tiles.add(Container(
        height: _animation.listTileWidthAnimation.value,
        child: ListTile(
          onTap: () {},
          leading: CircleAvatar(
            backgroundColor: colors[index % 3],
            child: Text(
              "${val[0]}",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          title: Text(val),
          subtitle: Text(items[val]),
        ),
      ));
    });

    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return tiles[index];
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 8,
        );
      },
    );
  }

  Widget _floatingButton() {
    return AnimatedBuilder(
      animation: _buttonController,
      builder: (context, animation) => Container(
            margin: _buttonAnimation.buttonZoomOutAnimation.value < 500
                ? EdgeInsets.only(right: 16, bottom: 16)
                : EdgeInsets.zero,
            alignment: _buttonAnimation.buttonBottomCenterAnimation.value,
            child: Container(
              alignment: _buttonAnimation.buttonBottomCenterAnimation.value,
              child: Material(
                shape: _buttonAnimation.buttonZoomOutAnimation.value < 500
                    ? CircleBorder()
                    : BeveledRectangleBorder(),
                elevation: 4,
                color: Colors.deepOrangeAccent,
                child: InkWell(
                  customBorder: CircleBorder(),
                  onTap: () => _buttonController.forward(),
                  child: Container(
                      height: _animation.containerGrowAnimation.value == 1
                          ? _buttonAnimation.buttonZoomOutAnimation.value
                          : _animation.containerGrowAnimation.value * 64,
                      width: _animation.containerGrowAnimation.value == 1
                          ? _buttonAnimation.buttonZoomOutAnimation.value
                          : _animation.containerGrowAnimation.value * 64,
                      child: _buttonAnimation.buttonZoomOutAnimation.value < 100
                          ? Icon(
                              Icons.add,
                              color: Colors.white,
                            )
                          : null),
                ),
              ),
            ),
          ),
    );
  }

  Widget _fadeBox(double screenWidth, double screenHeight) {
    return Hero(
      tag: "fade",
      child: Container(
        width: _animation.containerGrowAnimation.value < 1 ? screenWidth : 0.0,
        height:
            _animation.containerGrowAnimation.value < 1 ? screenHeight : 0.0,
        decoration: BoxDecoration(color: _animation.fadeScreenAnimation.value),
      ),
    );
  }
}
