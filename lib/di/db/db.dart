import 'package:flutterblockit/di/db/entity/post_entity.dart';
import 'package:flutterblockit/di/db/entity/session_entity.dart';
import 'package:flutterblockit/di/db/entity/user_entity.dart';
import 'package:flutterblockit/di/db/user_repo.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'post_repo.dart';
import 'session_repo.dart';

class Database {
  final PostRepo post;
  final SessionRepo session;
  final UserRepo user;

  Database._(
    this.post,
    this.session,
    this.user,
  );

  static Future<Database> crete() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [
        PostEntitySchema,
        SessionEntitySchema,
        UserEntitySchema,
      ],
      directory: dir.path,
    );

    transaction<T>(Future<T> Function() f) async {
      return await isar.writeTxn<T>(f);
    }

    return Database._(
      PostRepo(isar.postEntitys, transaction),
      SessionRepo(isar.sessionEntitys, transaction),
      UserRepo(isar.userEntitys, transaction),
    );
  }
}
