import 'package:flutter/material.dart';
import 'package:local_storage/sqflite/user.dart';
import 'sqflite_provider.dart';
import 'user_provider.dart';

class SqfliteScreen extends StatefulWidget {
  @override
  _SqfliteScreenState createState() => _SqfliteScreenState();
}

class _SqfliteScreenState extends State<SqfliteScreen> {
  DatabaseProvider provider;
  UserProvider userProvider;

  @override
  void initState() {
    provider = DatabaseProvider();
    userProvider = UserProvider(provider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sqflite Example'),
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
      future: userProvider.getUserList(),
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
    userProvider.insertUser(User(username, email));
    setState(() {});
  }

  void _removeUser(User user) {
    userProvider.deleteUser(user.id);
    setState(() {});
  }
}

class AddUserDialog extends StatefulWidget {
  final Function(String name, String email) callback;

  const AddUserDialog({Key key, this.callback}) : super(key: key);

  @override
  _AddUserDialogState createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  TextEditingController nameController;
  TextEditingController emailController;
  bool nameValidate = true;
  bool emailValidate = true;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    if (nameController != null && emailController != null) {
      nameController.dispose();
      emailController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add user'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: nameController,
            decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                errorText: nameValidate ? null : 'Your name is invalid.'),
          ),
          SizedBox(
            height: 12,
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                errorText: emailValidate ? null : 'Your email is invalid'),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            nameValidate = nameController.text.isNotEmpty;
            emailValidate = emailController.text.isNotEmpty &&
                validateEmail(emailController.text);

            if (!nameValidate || !emailValidate) {
              setState(() {});
              return;
            }

            widget.callback(nameController.text, emailController.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  bool validateEmail(String mail) =>
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(mail);
}
