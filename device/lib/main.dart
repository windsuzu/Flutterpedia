import 'package:flutter/material.dart';
import 'package:device/screen/screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Device Functionality Demo',
      initialRoute: '/',
      routes: {
        '/': (_) => MyHomePage(),
        '/battery_screen': (_) => BatteryScreen(),
        '/camera_screen': (_) => CameraScreen(),
        '/google_maps_screen': (_) => GoogleMapsScreen(),
        '/image_picker_screen': (_) => ImagePickerScreen(),
        '/path_provider_screen': (_) => PathProviderScreen(),
        '/info_screen': (_) => InfoScreen(),
        '/package_screen': (_) => PackageScreen(),
        '/sensor_screen': (_) => SensorScreen(),
        '/video_screen': (_) => VideoScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Functionality'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            _buildListTile(
                context: context,
                title: "Battery",
                screenNamed: "/battery_screen"),
            _buildListTile(
                context: context,
                title: "Device Info",
                screenNamed: "/info_screen"),
            _buildListTile(
                context: context,
                title: "Package Info",
                screenNamed: "/package_screen"),
            _buildListTile(
                context: context,
                title: "Path Provider",
                screenNamed: "/path_provider_screen"),
            _buildListTile(
                context: context, title: "Video", screenNamed: "/video_screen"),
            _buildListTile(
                context: context,
                title: "Camera",
                screenNamed: "/camera_screen"),
            _buildListTile(
                context: context,
                title: "Image Picker",
                screenNamed: "/image_picker_screen"),
            _buildListTile(
                context: context,
                title: "Google Maps",
                screenNamed: "/google_maps_screen"),
            _buildListTile(
                context: context,
                title: "Sensor",
                screenNamed: "/sensor_screen"),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(
      {BuildContext context, String title, String screenNamed}) {
    return ListTile(
        title: Text(title),
        onTap: () => Navigator.pushNamed(context, screenNamed));
  }
}
