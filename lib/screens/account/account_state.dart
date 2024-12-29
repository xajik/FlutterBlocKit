import 'package:flutterblockit/di/db/entity/page_entiry.dart';
import 'package:flutterblockit/utils/data_snapshot.dart';

abstract class AccountScreenState {
  AccountScreenState();
}

class AccountInitialState extends AccountScreenState {}

class AccountLoadedScreenState extends AccountScreenState {
  final DataSnapshot<PageEntity> page; 
  AccountLoadedScreenState(this.page);
}