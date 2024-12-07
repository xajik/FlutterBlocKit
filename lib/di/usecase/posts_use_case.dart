import 'package:flutterblockit/di/api/post_service.dart';
import 'package:flutterblockit/di/db/entity/post_entity.dart';
import 'package:flutterblockit/di/db/post_repo.dart';

class PostsUseCase {
  final PostApi _api;
  final PostRepo _repo;

  PostsUseCase(
    this._api,
    this._repo,
  );

  Future<List<PostEntity>> loadPosts() async {
    try {
      final posts = await _api.getPosts();
      if (posts.isNotEmpty) {
        await _repo.clear();
        await _repo.insert(posts.map((e) => e.toEntity()).toList());
      }
      // ignore: empty_catches
    } catch (e) {}
    return _repo.get();
  }
}
