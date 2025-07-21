import 'package:drift/drift.dart';

class TodoCard extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get description => text().nullable()();

  IntColumn get priority => integer().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  TextColumn get category => text().nullable()();

  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
}
