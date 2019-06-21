import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PathProviderScreen extends StatefulWidget {
  @override
  _PathProviderScreenState createState() => _PathProviderScreenState();
}

class _PathProviderScreenState extends State<PathProviderScreen> {
  Future<Directory> _tempDirectory;
  Future<Directory> _appSupportDirectory;
  Future<Directory> _appDocumentsDirectory;
  Future<Directory> _externalDocumentsDirectory;
  String writeResult = 'Click to write';
  String readResult = 'Click to read';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PathProvider Demo'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Get Temporary Directory'),
              onTap: _requestTempDirectory,
              subtitle: FutureBuilder(
                  future: _tempDirectory, builder: _buildDirectory),
            ),
            ListTile(
              title: Text('Get Application Documents Directory'),
              onTap: _requestAppDocumentsDirectory,
              subtitle: FutureBuilder(
                  future: _appDocumentsDirectory, builder: _buildDirectory),
            ),
            ListTile(
              title: Text(
                  '${Platform.isAndroid ? "App support directories are unavailable on Android" : 'Get Application Support Directory'}'),
              onTap: Platform.isAndroid ? null : _requestAppSupportDirectory,
              subtitle: FutureBuilder(
                  future: _appSupportDirectory, builder: _buildDirectory),
            ),
            ListTile(
              title: Text(
                  '${Platform.isIOS ? "External directories are unavailable " "on iOS" : "Get External Storage Directory"}'),
              onTap: Platform.isIOS ? null : _requestExternalStorageDirectory,
              subtitle: FutureBuilder(
                  future: _externalDocumentsDirectory,
                  builder: _buildDirectory),
            ),
            ListTile(
              title: Text('Write data to the file'),
              subtitle: Text(writeResult),
              onTap: _writeData,
            ),
            ListTile(
              title: Text('Read data from the file'),
              subtitle: Text(readResult),
              onTap: _readData,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDirectory(
      BuildContext context, AsyncSnapshot<Directory> snapshot) {
    Text text = const Text('');
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        text = Text('Error: ${snapshot.error}');
      } else if (snapshot.hasData) {
        text = Text('path: ${snapshot.data.path}');
      } else {
        text = const Text('path unavailable');
      }
    }
    return text;
  }

  void _requestTempDirectory() {
    setState(() {
      _tempDirectory = getTemporaryDirectory();
    });
  }

  void _requestAppDocumentsDirectory() {
    setState(() {
      _appDocumentsDirectory = getApplicationDocumentsDirectory();
    });
  }

  void _requestAppSupportDirectory() {
    setState(() {
      _appSupportDirectory = getApplicationSupportDirectory();
    });
  }

  void _requestExternalStorageDirectory() {
    setState(() {
      _externalDocumentsDirectory = getExternalStorageDirectory();
    });
  }

  Future<File> _loadFile() async {
    if (_appDocumentsDirectory == null) {
      _requestAppDocumentsDirectory();
    }
    final dir = await _appDocumentsDirectory;
    final path = dir.path;
    return File('$path/message.txt');
  }

  void _writeData() async {
    File file = await _loadFile();
    try {
      await file.writeAsString('Hello!');
      writeResult = 'Write succeeded';
    } catch (e) {
      writeResult = 'Write failed: $e';
    }
    setState(() {});
  }

  void _readData() async {
    File file = await _loadFile();

    try {
      String content = await file.readAsString();
      readResult = 'Read succeeded: "$content"';
    } catch (e) {
      readResult = 'Read failed: $e';
    }
    setState(() {});
  }
}
