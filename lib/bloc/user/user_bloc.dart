// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_app/data/datas.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _apiRepository = ApiRepository();

  UserBloc() : super(UserInitial()) {
    on<Login>(_login);
  }

  Future<void> _login(event, emit) async {
    try {
      emit(UserLoading());
      final list = await _apiRepository.login();
      emit(UserLoaded(list));
      if (list.error != null) {
        emit(UserError(list.error));
      }
    } on NetworkError {
      emit(UserError("Failed to login. Try again later."));
    }
  }
}
