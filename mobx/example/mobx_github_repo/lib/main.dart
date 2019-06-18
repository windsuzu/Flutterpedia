import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_github_repo/github_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MobX Github Repo Demo',
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
  final GithubStore store = GithubStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MobX Github Repo Example'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            UserInput(store),
            ShowError(store),
            LoadingIndicator(store),
            RepositoryListView(store)
          ],
        ),
      ),
    );
  }
}

class UserInput extends StatefulWidget {
  UserInput(this.store);

  final GithubStore store;

  @override
  _UserInputState createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TextField(
                controller: myController,
                autocorrect: false,
                autofocus: true,
                onSubmitted: (String user) {
                  if (user.isNotEmpty) {
                    widget.store.setUser(user);
                    widget.store.fetchRepos();
                  }
                },
              ),
            ),
          ),
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if (myController.text.isNotEmpty) {
                  widget.store.setUser(myController.text);
                  widget.store.fetchRepos();
                }
              })
        ],
      );
}

class ShowError extends StatelessWidget {
  const ShowError(this.store);

  final GithubStore store;

  @override
  Widget build(BuildContext context) => Observer(
      builder: (_) => store.fetchReposFuture.status == FutureStatus.rejected
          ? Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              const Icon(
                Icons.warning,
                color: Colors.deepOrange,
              ),
              Container(
                width: 8,
              ),
              const Text(
                'Failed to fetch repos for',
                style: TextStyle(color: Colors.deepOrange),
              ),
              Text(
                store.user,
                style: const TextStyle(
                    color: Colors.deepOrange, fontWeight: FontWeight.bold),
              )
            ])
          : Container());
}

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator(this.store);

  final GithubStore store;

  @override
  Widget build(BuildContext context) => Observer(
      builder: (_) => store.fetchReposFuture.status == FutureStatus.pending
          ? LinearProgressIndicator()
          : Container());
}

class RepositoryListView extends StatelessWidget {
  const RepositoryListView(this.store);

  final GithubStore store;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Observer(
          builder: (_) {
            if (!store.hasResults) {
              return Container();
            }

            if (store.repositories.isEmpty) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('We could not find any repos for user: '),
                  Text(
                    store.user,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }

            return ListView.builder(
                itemCount: store.repositories.length,
                itemBuilder: (context, index) {
                  final repo = store.repositories[index];
                  return ListTile(
                    title: Row(
                      children: <Widget>[
                        Text(
                          repo.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(' (${repo.stargazersCount} ⭐️)'),
                      ],
                    ),
                    subtitle: Text(repo.description ?? ''),
                  );
                });
          },
        ),
      );
}
