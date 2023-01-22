part of 'item_bloc.dart';

class ItemState extends Equatable {
  final List<Item> allItems;

  const ItemState({this.allItems = const <Item>[]});

  @override
  List<Object> get props => [allItems];
}
