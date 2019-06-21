import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class PackageScreen extends StatefulWidget {
  @override
  _PackageScreenState createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  PackageInfo _info;

  @override
  void initState() {
    _initPackageInfo();
    super.initState();
  }

  _initPackageInfo() async {
    _info = await PackageInfo.fromPlatform();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Package Info Demo'),
      ),
      body: ListView(
        children: <Widget>[
          _buildListTile('App Name', _info.appName),
          _buildListTile('Package Name', _info.packageName),
          _buildListTile('App Version', _info.version),
          _buildListTile('Build Number', _info.buildNumber),
        ],
      ),
    );
  }

  _buildListTile(String title, String info) {
    return ListTile(
      title: Text(title),
      subtitle: Text(info ?? "Unknown"),
    );
  }
}
