import 'package:injectable/injectable.dart';

import '../data/source/local/db.dart';

@singleton
class UserRepository {
  final Database db;

  UserRepository({required this.db});

  Future<void> saveUserName(String name) async {
    await db.saveUserName(name);
  }

  Future<String?> getUserName() async {
    final user = await db.getUserName();
    return user;
  }

  Future<bool> hasUser() async {
    return db.hasUser();
  }
}
