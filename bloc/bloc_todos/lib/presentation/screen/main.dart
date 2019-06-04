import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_todos/bloc/blocs.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:bloc_todos/data/model/models.dart';
import 'package:bloc_todos/util/localization.dart';
import 'screens.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final todosBloc = TodosBloc(
    todosRepository: const TodosRepositoryFlutter(
      fileStorage: const FileStorage(
        '__flutter_bloc_app__',
        getApplicationDocumentsDirectory,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: todosBloc,
      child: MaterialApp(
        title: FlutterBlocLocalizations().appTitle,
        theme: ArchSampleTheme.theme,
        localizationsDelegates: [
          ArchSampleLocalizationsDelegate(),
          FlutterBlocLocalizationsDelegate(),
        ],
        routes: {
          ArchSampleRoutes.home: (context) {
            return HomeScreen(
              onInit: () => todosBloc.dispatch(LoadTodos()),
            );
          },
          ArchSampleRoutes.addTodo: (context) {
            return AddEditScreen(
              key: ArchSampleKeys.addTodoScreen,
              onSave: (task, note) {
                todosBloc.dispatch(
                  AddTodo(Todo(task, note: note)),
                );
              },
              isEditing: false,
            );
          },
        },
      ),
    );
  }
}
