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
    on<PostTask>(_postTask);
    on<UpdateTask>(_updateTask);
    on<FilterTasks>(_filterTasks);
  }

  DateTime ConvertToDate(String date) {
    DateTime newDate =
        DateTime.fromMillisecondsSinceEpoch(int.parse(date) * 1000);
    return dateOnly(newDate);
  }

  DateTime dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  Future<void> _getTasks(event, emit) async {
    try {
      emit(TasksLoading());
      final list = await _apiRepository.getTasks();

      ListTaskModel listFiltered = ListTaskModel().copyWith(
          documents: list.documents, nextPageToken: list.nextPageToken);
      final List<TaskModel> filteredList = List.from(listFiltered.documents!);

      filteredList.retainWhere((t) =>
          ConvertToDate(t.fields!.date!.integerValue) ==
          dateOnly(DateTime.now()));

      listFiltered.documents = filteredList;

      emit(TasksLoaded(
          listTaskModel: list, filteredlistsTasksModel: listFiltered));
      if (list.error != null) {
        emit(TasksError(list.error));
      }
    } catch (e) {
      emit(TasksError("Failed to get data. Try again later."));
    }
  }

  Future<void> _postTask(PostTask event, emit) async {
    final state = this.state;
    final original = [...state.listsTasks!.documents!];
    final filtered = [...state.filteredlistsTasks!.documents!];

    try {
      emit(TasksLoading());
      final task = await _apiRepository.postTask(event.taskModel);

      if (task.error != null) {
        emit(TasksError(task.error));
      } else {
        original.add(task);

        if (filtered.isNotEmpty) {
          // ignore: unrelated_type_equality_checks
          if (ConvertToDate(task.fields!.date!.integerValue).day ==
              ConvertToDate(filtered[0].fields!.date!.integerValue)) {
            filtered.add(task);
          }
        }

        emit(TasksLoaded(
            listTaskModel: state.listsTasks!.copyWith(documents: [...original]),
            filteredlistsTasksModel:
                state.filteredlistsTasks!.copyWith(documents: [...filtered])));
      }
    } catch (e) {
      emit(TasksError("Failed to post data. Try again later."));
    }
  }

  Future<void> _updateTask(UpdateTask event, emit) async {
    final state = this.state;
    final original = [...state.listsTasks!.documents!];
    final filtered = [...state.filteredlistsTasks!.documents!];

    try {
      emit(TasksLoading());
      final task = await _apiRepository.patchTask(event.taskModel);

      if (task.error != null) {
        emit(TasksError(task.error));
      } else {
        if (filtered.isNotEmpty) {
          // ignore: unrelated_type_equality_checks
          if (ConvertToDate(task.fields!.date!.integerValue).day !=
              ConvertToDate(filtered[0].fields!.date!.integerValue)) {
            filtered.removeWhere((element) => element.id == task.id);
          } else {
            int i = filtered.indexOf(task);
            filtered[i] = task;
          }
        }

        int i = original.indexOf(task);
        original[i] = task;

        emit(TasksLoaded(
            listTaskModel: state.listsTasks!.copyWith(documents: [...original]),
            filteredlistsTasksModel:
                state.filteredlistsTasks!.copyWith(documents: [...filtered])));
      }
    } catch (e) {
      emit(TasksError("Failed to update data. Try again later."));
    }
  }

  Future<void> _filterTasks(FilterTasks event, emit) async {
    final state = this.state;
    ListTaskModel listFiltered = ListTaskModel().copyWith(
        documents: state.listsTasks!.documents,
        nextPageToken: state.listsTasks!.nextPageToken);
    final filteredList = [...listFiltered.documents!];
    try {
      filteredList.retainWhere(
          (t) => ConvertToDate(t.fields!.date!.integerValue) == event.dateTime);

      listFiltered.documents = filteredList;

      emit(TasksLoaded(
          listTaskModel: state.listsTasks!,
          filteredlistsTasksModel: listFiltered));
    } catch (e) {
      emit(TasksError("Failed to filter data. Try again later."));
    }
  }
}
