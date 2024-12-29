import 'package:flutterblockit/di/db/page_repo.dart';
import 'package:flutterblockit/utils/data_snapshot.dart';

import '../api/post_service.dart';
import '../db/entity/page_entiry.dart';

class PagesUseCase {
  static const String aboutPageUrl = '/about';

  final PostApi _postApi;
  final PageRepo _repo;

  PagesUseCase(this._postApi, this._repo);

  Future<DataSnapshot<PageEntity>> getAboutPage() async {
    try {
      final pages = await _postApi.getPages();
      final pageEntities = pages.map((page) => page.toEntity()).toList();
      await _repo.insert(pageEntities);
    } catch (e) {
      //TODO: report analytics
    }

    final aboutPageEntity = await _repo.getByUrl(aboutPageUrl);

    if (aboutPageEntity == null) {
      return DataSnapshot.error("Not Found");
    } else {
      return DataSnapshot.data(aboutPageEntity);
    }
  }
}
