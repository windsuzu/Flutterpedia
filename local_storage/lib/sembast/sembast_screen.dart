import 'package:flutter/material.dart';
import 'package:local_storage/sembast/sembast_db.dart';
import 'package:local_storage/sqflite/sqflite_screen.dart';
import 'package:local_storage/sqflite/user.dart';

class SembastScreen extends StatefulWidget {
  @override
  _SembastScreenState createState() => _SembastScreenState();
}

class _SembastScreenState extends State<SembastScreen> {
  final UserDao _userDao = UserDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sembast Example'),
      ),
      body: Center(
        child: _buildUserListViewBuilder(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddUserDialog,
        tooltip: 'Add user',
        child: Icon(Icons.add), //Change Icon
      ),
    );
  }

  Widget _buildUserListViewBuilder() {
    return FutureBuilder<List<User>>(
      future: _userDao.getAllSortedByName(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.length > 0) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                User user = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (_) => _removeUser(user),
                  child: ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  ),
                );
              });
        }

        return Container(
          child: Text('No user.'),
        );
      },
    );
  }

  void _showAddUserDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AddUserDialog(callback: _addUser);
      },
    );
  }

  void _addUser(String username, String email) {
    _userDao.insert(User(username, email));
    setState(() {});
  }

  void _removeUser(User user) {
    _userDao.delete(user);
    setState(() {});
  }
}
