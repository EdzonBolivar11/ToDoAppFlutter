part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  final ListCategoriesModel? listCategories;
  const CategoriesState({this.listCategories});

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final ListCategoriesModel? listCategories;
  const CategoriesLoaded({this.listCategories})
      : super(listCategories: listCategories);
}

class CategoriesError extends CategoriesState {
  final String? message;

  const CategoriesError(this.message);
}

class CategoriesNoInternetState extends CategoriesState {}
