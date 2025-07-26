import 'package:injectable/injectable.dart';

import '../data/source/local/db.dart';

@singleton
class UserRepository {
  final Database db;

  String? _userName;

  bool get isAuth => _userName != null;

  String? get currentName => _userName;

  UserRepository({required this.db});

  Future<void> saveUserName(String name) async {
    await db.saveUserName(name);
  }

  Future<String?> getUserName() async {
    final user = await db.getUserName();
    _userName = user;
    return user;
  }

  Future<bool> hasUser() async {
    return db.hasUser();
  }
}
