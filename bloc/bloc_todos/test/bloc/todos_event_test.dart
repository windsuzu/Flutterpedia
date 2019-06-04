import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_todos/bloc/blocs.dart';
import 'package:bloc_todos/data/model/models.dart';

main() {
  group('TodosEvent', () {
    group('LoadTodos', () {
      test('toString returns correct value', () {
        expect(
          LoadTodos().toString(),
          'LoadTodos',
        );
      });
    });

    group('AddTodo', () {
      test('toString returns correct value', () {
        expect(
          AddTodo(Todo('wash car', id: '0')).toString(),
          'AddTodo { todo: ${Todo('wash car', id: '0')} }',
        );
      });
    });

    group('UpdateTodo', () {
      test('toString returns correct value', () {
        expect(
          UpdateTodo(Todo('wash car', id: '0')).toString(),
          'UpdateTodo { updatedTodo: ${Todo('wash car', id: '0')} }',
        );
      });
    });

    group('DeleteTodo', () {
      test('toString returns correct value', () {
        expect(
          DeleteTodo(Todo('wash car', id: '0')).toString(),
          'DeleteTodo { todo: ${Todo('wash car', id: '0')} }',
        );
      });
    });

    group('ClearCompleted', () {
      test('toString returns correct value', () {
        expect(
          ClearCompleted().toString(),
          'ClearCompleted',
        );
      });
    });

    group('ToggleAll', () {
      test('toString returns correct value', () {
        expect(
          ToggleAll().toString(),
          'ToggleAll',
        );
      });
    });
  });
}