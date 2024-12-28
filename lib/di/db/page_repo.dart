import 'package:flutterblockit/di/db/entity/page_entiry.dart';
import 'package:isar/isar.dart';

class PageRepo {
  final IsarCollection<PageEntity> _collection;
  final Future<T> Function<T>(Future<T> Function() f) _transaction;

  PageRepo(
    this._collection,
    this._transaction,
  );

  Future<List<int>> insert(List<PageEntity> pages) async {
    return _transaction(() => _collection.putAll(pages));
  }

  Future<void> clear() async {
    _transaction(() async => await _collection.clear());
  }

  Future<List<PageEntity>> get() async {
    return _collection.where().findAll();
  }

  Future<PageEntity?> getByUrl(String url) async {
    return _collection.where().filter().urlEqualTo(url).findFirst();
  }
}
