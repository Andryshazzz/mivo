import 'package:drift/drift.dart';

class UserName extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}
