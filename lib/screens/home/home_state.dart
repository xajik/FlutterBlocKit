import 'package:flutterblockit/di/db/entity/post_entity.dart';
import 'package:flutterblockit/utils/data_snapshot.dart';

abstract class HomeUserSessionState {}

class HomeUserSessionInitial extends HomeUserSessionState {}

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final DataSnapshot<List<PostEntity>> posts;

  HomeLoaded(this.posts);
}