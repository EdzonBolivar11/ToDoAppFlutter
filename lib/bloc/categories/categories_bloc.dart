// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_app/data/datas.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final _apiRepository = ApiRepository();

  CategoriesBloc() : super(CategoriesInitial()) {
    on<GetListCategories>(_getListCategories);
  }

  Future<void> _getListCategories(event, emit) async {
    try {
      emit(CategoriesLoading());
      final list = await _apiRepository.getCategories();
      emit(CategoriesLoaded(list));
      if (list.error != null) {
        emit(CategoriesError(list.error));
      }
    } on NetworkError {
      emit(CategoriesError("Failed to get categories. Try again later."));
    }
  }
}
