import 'package:flutterblockit/utils/data_snapshot.dart';

import '../api/post_service.dart';
import '../db/db.dart';
import '../db/entity/page_entiry.dart';

class AboutUseCase {
  static const String aboutPageUrl = '/about';

  final PostApi _postApi;
  final Database _database;

  AboutUseCase(this._postApi, this._database);

  Future<DataSnapshot<PageEntity>> getAboutPage() async {
    try {
      final pages = await _postApi.getPages();
      final pageEntities = pages.map((page) => page.toEntity()).toList();
      await _database.page.insert(pageEntities);
    } catch (e) {
      print(e);
    }

    final aboutPageEntity = await _database.page.getByUrl(aboutPageUrl);

    if (aboutPageEntity == null) {
      return DataSnapshot.error("Not Found");
    } else {
      return DataSnapshot.data(aboutPageEntity);
    }
  }
}
