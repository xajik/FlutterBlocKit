import 'package:flutterblockit/di/db/entity/post_entity.dart';
import 'package:isar/isar.dart';

class PostRepo {
  final IsarCollection<PostEntity> _collection;
  final Future<T> Function<T>(Future<T> Function() f) _transaction;

  PostRepo(
    this._collection,
    this._transaction,
  );

  Future<List<int>> insert(List<PostEntity> session) async {
    return _transaction(() => _collection.putAll(session));
  }

  Future<void> clear() async {
    _transaction(() async => await _collection.clear());
  }

  Future<List<PostEntity>> get() async {
    return _collection.where().findAll();
  }

  Future<PostEntity?>  getByUrl(String url) async {
    return _collection.where().filter().urlEqualTo(url).findFirst();
  }
}
