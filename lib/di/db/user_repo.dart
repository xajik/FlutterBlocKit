import 'package:isar/isar.dart';

import 'entity/user_entity.dart';

class UserRepo {
  final IsarCollection<UserEntity> _collection;
  final Future<T> Function<T>(Future<T> Function() f) _transaction;

  UserRepo(
    this._collection,
    this._transaction,
  );

  Future<int> insert(UserEntity user) async {
    return _transaction(() => _collection.put(user));
  }

  Future<UserEntity?> getUser(int userId) async {
    return _collection.where().userIdEqualTo(userId).findFirst();
  }

  Future<UserEntity?> first() async {
    return _collection.where().findFirst();
  }
}
