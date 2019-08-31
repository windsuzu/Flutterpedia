import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinKitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SpinKit Demo'),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          _buildShowCase(_buildRotatingPlane()),
          _buildShowCase(_buildDoubleBounce()),
          _buildShowCase(_buildWave()),
          _buildShowCase(_buildWanderingCubes()),
          _buildShowCase(_buildFadingFour()),
          _buildShowCase(_buildPulse()),
          _buildShowCase(_buildChasingDots()),
          _buildShowCase(_buildThreeBounce()),
          _buildShowCase(_buildCircle()),
          _buildShowCase(_buildCubeGrid()),
          _buildShowCase(_buildRotatingCircle()),
          _buildShowCase(_buildFoldingCube()),
          _buildShowCase(_buildPumpingHeart()),
          _buildShowCase(_buildDualRing()),
          _buildShowCase(_buildHourGlass()),
          _buildShowCase(_buildFadingGrid()),
          _buildShowCase(_buildRing()),
          _buildShowCase(_buildRipple()),
          _buildShowCase(_buildSpinningCircle()),
        ],
      ),
    );
  }

  Widget _buildShowCase(Widget child) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.blue[300]),
      child: Center(child: child),
    );
  }

  // * Rotating Plane
  // * https://raw.githubusercontent.com/ybq/AndroidSpinKit/master/art/RotatingPlane.gif
  Widget _buildRotatingPlane() {
    return SpinKitRotatingPlain(color: Colors.white);
  }

  // * Double Bounce
  // * https://raw.githubusercontent.com/ybq/AndroidSpinKit/master/art/DoubleBounce.gif
  Widget _buildDoubleBounce() {
    return SpinKitDoubleBounce(color: Colors.white);
  }

  // * Wave
  // * https://raw.githubusercontent.com/ybq/AndroidSpinKit/master/art/Wave.gif
  Widget _buildWave() {
    return SpinKitWave(color: Colors.white, type: SpinKitWaveType.center);
  }

  // * Wandering Cubes
  // * https://raw.githubusercontent.com/ybq/AndroidSpinKit/master/art/WanderingCubes.gif
  Widget _buildWanderingCubes() {
    return SpinKitWanderingCubes(color: Colors.white, shape: BoxShape.circle);
  }

  // * Fading Four
  // * https://raw.githubusercontent.com/jogboms/flutter_spinkit/master/screenshots/FadingFour.gif
  Widget _buildFadingFour() {
    return SpinKitFadingFour(color: Colors.white);
  }

  // * Pulse
  // * https://raw.githubusercontent.com/ybq/AndroidSpinKit/master/art/Pulse.gif
  Widget _buildPulse() {
    return SpinKitPulse(color: Colors.white);
  }

  // * Chasing Dots
  // * https://raw.githubusercontent.com/ybq/AndroidSpinKit/master/art/ChasingDots.gif
  Widget _buildChasingDots() {
    return SpinKitChasingDots(color: Colors.white);
  }

  // * Three Bounce
  // * https://raw.githubusercontent.com/ybq/AndroidSpinKit/master/art/ThreeBounce.gif
  Widget _buildThreeBounce() {
    return SpinKitThreeBounce(color: Colors.white);
  }

  // * Circle
  // * https://raw.githubusercontent.com/ybq/AndroidSpinKit/master/art/Circle.gif
  Widget _buildCircle() {
    return SpinKitCircle(color: Colors.white);
  }

  // * Cube Grid
  // * https://raw.githubusercontent.com/ybq/AndroidSpinKit/master/art/CubeGrid.gif
  Widget _buildCubeGrid() {
    return SpinKitCubeGrid(color: Colors.white);
  }

  // * Rotating Circle
  // * https://raw.githubusercontent.com/ybq/AndroidSpinKit/master/art/RotatingCircle.gif
  Widget _buildRotatingCircle() {
    return SpinKitRotatingCircle(color: Colors.white);
  }

  // * Folding Cube
  // * https://raw.githubusercontent.com/ybq/AndroidSpinKit/master/art/FoldingCube.gif
  Widget _buildFoldingCube() {
    return SpinKitFoldingCube(color: Colors.white);
  }

  // * Pumping Heart
  // * https://raw.githubusercontent.com/jogboms/flutter_spinkit/master/screenshots/heart.gif
  Widget _buildPumpingHeart() {
    return SpinKitPumpingHeart(color: Colors.white);
  }

  // * Dual Ring
  // * https://raw.githubusercontent.com/jogboms/flutter_spinkit/master/screenshots/dual-ring.gif
  Widget _buildDualRing() {
    return SpinKitDualRing(color: Colors.white, lineWidth: 10.0);
  }

  // * Hour Glass
  // * https://raw.githubusercontent.com/jogboms/flutter_spinkit/master/screenshots/hour-glass.gif
  Widget _buildHourGlass() {
    return SpinKitHourGlass(color: Colors.white);
  }

  // * Fading Grid
  // * https://raw.githubusercontent.com/jogboms/flutter_spinkit/master/screenshots/grid.gif
  Widget _buildFadingGrid() {
    return SpinKitFadingGrid(color: Colors.white);
  }

  // * Ring
  // * https://raw.githubusercontent.com/jogboms/flutter_spinkit/master/screenshots/ring.gif
  Widget _buildRing() {
    return SpinKitRing(color: Colors.white, lineWidth: 5.0);
  }

  // * Ripple
  // * https://raw.githubusercontent.com/jogboms/flutter_spinkit/master/screenshots/ripple.gif
  Widget _buildRipple() {
    return SpinKitRipple(color: Colors.white);
  }

  // * Spinning Circle
  // * https://raw.githubusercontent.com/jogboms/flutter_spinkit/master/screenshots/spinning-circle.gif
  Widget _buildSpinningCircle() {
    return SpinKitSpinningCircle(color: Colors.white);
  }
}
