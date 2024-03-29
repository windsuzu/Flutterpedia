import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_todos/bloc/blocs.dart';
import 'package:bloc_todos/data/model/models.dart';

main() {
  group('TodosState', () {
    group('TodosLoading', () {
      test('toString returns correct value', () {
        expect(
          TodosLoading().toString(),
          'TodosLoading',
        );
      });
    });

    group('TodosLoaded', () {
      test('toString returns correct value', () {
        expect(
          TodosLoaded([Todo('wash car', id: '0')]).toString(),
          'TodosLoaded { todos: [${Todo("wash car", id: "0")}] }',
        );
      });
    });

    group('TodosNotLoaded', () {
      test('toString returns correct value', () {
        expect(
          TodosNotLoaded().toString(),
          'TodosNotLoaded',
        );
      });
    });
  });
}