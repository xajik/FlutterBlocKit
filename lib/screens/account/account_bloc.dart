import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblockit/di/usecase/pages_use_case.dart';
import 'package:flutterblockit/utils/data_snapshot.dart';

import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountScreenState> {
  final PagesUseCase _pagesUseCase;

  AccountBloc(this._pagesUseCase) : super(AccountInitialState()) {
    on<AccountLoadEvent>((event, emit) async {
      emit(AccountLoadedScreenState(DataSnapshot.loading()));
      try {
        final page = await _pagesUseCase.getAboutPage();
        emit(AccountLoadedScreenState(page));
      } catch (e) {
        emit(AccountLoadedScreenState(DataSnapshot.error(e.toString())));
      }
    });
  }
}
