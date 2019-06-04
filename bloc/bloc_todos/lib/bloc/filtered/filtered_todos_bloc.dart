import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:bloc_todos/bloc/todos/bloc.dart';
import 'package:bloc_todos/data/model/todo.dart';
import 'package:bloc_todos/data/model/visibility_filter.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final TodosBloc todosBloc;
  StreamSubscription todosSubscription;

  FilteredTodosBloc({@required this.todosBloc}) {
    todosSubscription = todosBloc.state.listen((state) {
      if (state is TodosLoaded) {
        dispatch(UpdateTodos((todosBloc.currentState as TodosLoaded).todos));
      }
    });
  }

  @override
  FilteredTodosState get initialState => todosBloc.currentState is TodosLoaded
      ? FilteredTodosLoaded(
          (todosBloc.currentState as TodosLoaded).todos,
          VisibilityFilter.all,
        )
      : FilteredTodosLoading();

  @override
  Stream<FilteredTodosState> mapEventToState(
    FilteredTodosEvent event,
  ) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is UpdateTodos) {
      yield* _mapTodosUpdatedToState(event);
    }
  }

  Stream<FilteredTodosState> _mapUpdateFilterToState(
      UpdateFilter event,
      ) async* {
    if (todosBloc.currentState is TodosLoaded) {
      yield FilteredTodosLoaded(
        _mapTodosToFilteredTodos(
          (todosBloc.currentState as TodosLoaded).todos,
          event.filter,
        ),
        event.filter,
      );
    }
  }

  Stream<FilteredTodosState> _mapTodosUpdatedToState(
      UpdateTodos event,
      ) async* {
    final visibilityFilter = currentState is FilteredTodosLoaded
        ? (currentState as FilteredTodosLoaded).activeFilter
        : VisibilityFilter.all;
    yield FilteredTodosLoaded(
      _mapTodosToFilteredTodos(
        (todosBloc.currentState as TodosLoaded).todos,
        visibilityFilter,
      ),
      visibilityFilter,
    );
  }

  List<Todo> _mapTodosToFilteredTodos(
      List<Todo> todos, VisibilityFilter filter) {
    return todos.where((todo) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !todo.complete;
      } else if (filter == VisibilityFilter.completed) {
        return todo.complete;
      }
    }).toList();
  }

  @override
  void dispose() {
    todosSubscription.cancel();
    super.dispose();
  }
}
