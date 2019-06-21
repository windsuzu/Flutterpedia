import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  void _initPlatformState() async {
    Map<String, dynamic> deviceData;
    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readiOSData(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Info Demo'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: _deviceData.keys.map((property) {
          return Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  property,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                child: Text(
                  '${_deviceData[property]}',
                  overflow: TextOverflow.ellipsis,
                ),
              )),
            ],
          );
        }).toList(),
      ),
    );
  }

  Map<String, dynamic> _readAndroidData(AndroidDeviceInfo data) {
    return <String, dynamic>{
      'version.securityPatch': data.version.securityPatch,
      'version.sdkInt': data.version.sdkInt,
      'version.release': data.version.release,
      'version.previewSdkInt': data.version.previewSdkInt,
      'version.incremental': data.version.incremental,
      'version.codename': data.version.codename,
      'version.baseOS': data.version.baseOS,
      'board': data.board,
      'bootloader': data.bootloader,
      'brand': data.brand,
      'device': data.device,
      'display': data.display,
      'fingerprint': data.fingerprint,
      'hardware': data.hardware,
      'host': data.host,
      'id': data.id,
      'manufacturer': data.manufacturer,
      'model': data.model,
      'product': data.product,
      'supported32BitAbis': data.supported32BitAbis,
      'supported64BitAbis': data.supported64BitAbis,
      'supportedAbis': data.supportedAbis,
      'tags': data.tags,
      'type': data.type,
      'isPhysicalDevice': data.isPhysicalDevice,
      'androidId': data.androidId,
    };
  }

  Map<String, dynamic> _readiOSData(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}
