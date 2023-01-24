part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class GetListCategories extends CategoriesEvent {}

class PostCategory extends CategoriesEvent {
  final CategoryModel categoryModel;

  const PostCategory({required this.categoryModel});
}
