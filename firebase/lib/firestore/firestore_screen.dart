import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firestore/record.dart';

final dummySnapshot = [
  {"name": "Filip", "votes": 15},
  {"name": "Abraham", "votes": 14},
  {"name": "Richard", "votes": 11},
  {"name": "Ike", "votes": 10},
  {"name": "Justin", "votes": 1},
];

class FirestoreScreen extends StatelessWidget {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FireStore Example'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _buildNewBabyDialog(context),
        child: Icon(Icons.create),
      ),
      body: VoteList(),
    );
  }

  void _createNewBaby(String name) async {
    if (name == null) return;

    final emptyCheck = await Firestore.instance
        .collection('baby')
        .document('${name.toLowerCase()}')
        .get();
    if (!emptyCheck.exists)
      Firestore.instance
          .collection('baby')
          .document('${name.toLowerCase()}')
          .setData({"name": name, "votes": 0});
  }

  _buildNewBabyDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Add a new baby'),
              content: TextField(
                controller: _textFieldController,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('cancel'),
                  onPressed: () {
                    _textFieldController.clear();
                    return Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text('create'),
                  onPressed: () {
                    if (_textFieldController.text.isNotEmpty)
                      _createNewBaby(_textFieldController.text);
                    _textFieldController.clear();
                    return Navigator.pop(context);
                  },
                ),
              ],
            ));
  }
}

class VoteList extends StatefulWidget {
  @override
  _VoteListState createState() => _VoteListState();
}

class _VoteListState extends State<VoteList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('baby').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: EdgeInsets.only(top: 20),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.votes.toString()),
          onTap: () => _votes(record),
          onLongPress: () => _remove(record),
        ),
      ),
    );
  }

  // update votes count without race condition
  void _votes(Record record) {
    Firestore.instance.runTransaction((transaction) async {
      final freshSnapshot = await transaction.get(record.reference);
      final fresh = Record.fromSnapshot(freshSnapshot);

      await transaction.update(record.reference, {'votes': fresh.votes + 1});
    });
  }

  void _remove(Record record) {
    Firestore.instance
        .collection('baby')
        .document(record.name.toLowerCase())
        .delete();
  }
}
