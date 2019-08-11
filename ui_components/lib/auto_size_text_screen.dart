import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AutoSizeTextScreen extends StatefulWidget {
  @override
  _AutoSizeTextScreenState createState() => _AutoSizeTextScreenState();
}

class _AutoSizeTextScreenState extends State<AutoSizeTextScreen> {
  String text = "Simple text";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auto Size Text Demo'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addText,
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              '$text',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              minFontSize: 8,
              overflowReplacement: Text(
                "Overflow !!",
                style: TextStyle(fontSize: 24, color: Colors.redAccent),
              ),
              maxLines: 3,
            ),
          ),
        ),
      ),
    );
  }

  void _addText() {
    setState(() {
      text += " New Text";
    });
  }
}
