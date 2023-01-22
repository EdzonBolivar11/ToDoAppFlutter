part of 'item_bloc.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class AddItem extends ItemEvent {
  final Item item;
  const AddItem({required this.item});

  @override
  List<Object> get props => [item];
}

class UpdateItem extends ItemEvent {
  final Item item;
  const UpdateItem({required this.item});

  @override
  List<Object> get props => [item];
}
