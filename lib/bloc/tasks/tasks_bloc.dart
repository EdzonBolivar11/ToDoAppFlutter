// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_app/data/datas.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final _apiRepository = ApiRepository();

  TasksBloc() : super(TasksLoading()) {
    on<GetListTask>(_getTasks);
  }

  Future<void> _getTasks(event, emit) async {
    try {
      emit(TasksLoading());
      final list = await _apiRepository.getTasks();
      emit(TasksLoaded(list));
      if (list.error != null) {
        emit(TasksError(list.error));
      }
    } on NetworkError {
      emit(TasksError("Failed to get data. Try again later."));
    }
  }
}
