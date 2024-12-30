import 'package:flutterblockit/di/db/entity/etag_entity.dart';
import 'package:isar/isar.dart';

class EtagRepo {
  final IsarCollection<EtagEntity> _collection;
  final Future<T> Function<T>(Future<T> Function() f) _transaction;

  EtagRepo(
    this._collection,
    this._transaction,
  );

  Future<int> insert(String key, String etag) async {
    return _transaction(() => _collection.put(EtagEntity()..key = key..value = etag));
  }

  Future<void> clear() async {
    _transaction(() async => await _collection.clear());
  }

  Future<List<EtagEntity>> get() async {
    return _collection.where().findAll();
  }

  Future<EtagEntity?> getByKey(String key) async {
    return _collection.where().filter().keyEqualTo(key).findFirst();
  }
}