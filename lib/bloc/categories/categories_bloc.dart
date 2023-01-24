// ignore: depend_on_referenced_packages

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
    on<PostCategory>(_postCategory);
  }

  Future<void> _getListCategories(event, emit) async {
    try {
      emit(CategoriesLoading());
      final list = await _apiRepository.getCategories();
      emit(CategoriesLoaded(listCategories: list));
      if (list.error != null) {
        emit(CategoriesError(list.error));
      }
    } on NetworkError {
      emit(CategoriesError("Failed to get categories. Try again later."));
    }
  }

  Future<void> _postCategory(PostCategory event, emit) async {
    final state = this.state;
    ListCategoriesModel listCategoriesModel =
        ListCategoriesModel.copyWith(obj: state.listCategories!);
    try {
      emit(CategoriesLoading());
      final cat = await _apiRepository.postCategory(event.categoryModel);
      listCategoriesModel.documents = [...?listCategoriesModel.documents, cat];
      emit(CategoriesLoaded(listCategories: listCategoriesModel));
      if (cat.error != null) {
        emit(CategoriesError(cat.error));
      }
    } on NetworkError {
      emit(CategoriesError("Failed to post this category. Try again later."));
    }
  }
}
