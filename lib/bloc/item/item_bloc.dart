import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/models/item.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(const ItemState()) {
    on<AddItem>(_onAddItem);
    on<UpdateItem>(_onUpdateItem);
  }

  void _onAddItem(AddItem event, Emitter<ItemState> emit) {
    final state = this.state;
    emit(ItemState(allItems: List.from(state.allItems)..add(event.item)));
  }

  void _onUpdateItem(UpdateItem event, Emitter<ItemState> emit) {
    final state = this.state;
    emit(ItemState(allItems: List.from(state.allItems)..add(event.item)));
  }
}
