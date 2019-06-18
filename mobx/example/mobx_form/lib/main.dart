import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_form/form_store.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MobX Form Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FormStore store = FormStore();

  @override
  void initState() {
    super.initState();
    store.setupValidations();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MobX Form Example"),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Observer(
                builder: (_) => TextField(
                      onChanged: store.setUsername,
                      decoration: InputDecoration(
                          labelText: 'Username',
                          hintText: 'Pick a username',
                          errorText: store.error.username),
                    ),
              ),
              Observer(
                  builder: (_) => AnimatedOpacity(
                      child: LinearProgressIndicator(),
                      duration: Duration(milliseconds: 300),
                      opacity: store.isUserCheckPending ? 1 : 0)),
              Observer(
                builder: (_) => TextField(
                      onChanged: store.setEmail,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email address',
                          errorText: store.error.email),
                    ),
              ),
              Observer(
                builder: (_) => TextField(
                      onChanged: store.setPassword,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Set a password',
                          errorText: store.error.password),
                    ),
              ),
              Observer(
                builder: (_) => RaisedButton(
                      child: Text('Sign up'),
                      onPressed: store.canLogin ? store.validateAll : null,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
