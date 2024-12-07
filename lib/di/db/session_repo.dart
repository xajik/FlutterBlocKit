import 'dart:async';

import 'package:isar/isar.dart';

import 'entity/session_entity.dart';

class SessionRepo {
  final IsarCollection<SessionEntity> _collection;
  final Future<T> Function<T>(Future<T> Function() f) _transaction;

  SessionRepo(
    this._collection,
    this._transaction,
  );

  Future<int> insert(SessionEntity session) async {
    return _transaction(() => _collection.put(session));
  }

  Future<SessionEntity?> getSession(int userId) async {
    return _collection.where().userIdEqualTo(userId).findFirst();
  }

  Future<SessionEntity?> first() async {
    return _collection.where().findFirst();
  }

  Future<void> sessionStream(StreamController<String?> controller) async {
    final SessionEntity? entity = await _collection.where(sort: Sort.desc).findFirst();
    if(entity != null) {
      controller.add(entity.accessToken.token);
    }
    Stream<List<SessionEntity?>> userChanged =
        _collection.where(sort: Sort.desc).anyId().watch();
    userChanged.listen((sessions) {
      if (sessions.isEmpty) {
        controller.add(null);
      } else {
        controller.add(sessions.first?.accessToken.token);
      }
    });
  }
}
