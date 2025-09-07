import 'package:injectable/injectable.dart';
import 'package:l/l.dart';

import '../data/source/local/db.dart';

@singleton
class UserRepository {
  final Database db;

  String? _userName;

  bool get isAuth => _userName != null;

  String? get currentName => _userName;

  UserRepository({required this.db});

  Future<void> saveUserName(String name) async {
    try {
      await db.saveUserName(name);
    } catch (e, st) {
      l.e('$e, $st');
      rethrow;
    }
  }

  Future<String?> getUserName() async {
    try {
      final user = await db.getUserName();
      _userName = user;
      return user;
    } catch (e, st) {
      l.e('$e, $st');
      rethrow;
    }
  }

  Future<bool> hasUser() async {
    try {
      return db.hasUser();
    } catch (e, st) {
      l.e('$e, $st');
      rethrow;
    }
  }
}
