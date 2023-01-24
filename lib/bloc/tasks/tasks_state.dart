part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  final ListTaskModel? listsTasks;

  const TasksState({this.listsTasks});
}

class TasksInitial extends TasksState {
  const TasksInitial() : super(listsTasks: null);

  @override
  List<Object?> get props => [];
}

class TasksLoading extends TasksState {
  const TasksLoading() : super(listsTasks: null);

  @override
  List<Object?> get props => [];
}

class TasksLoaded extends TasksState {
  final ListTaskModel listTaskModel;
  const TasksLoaded(this.listTaskModel) : super(listsTasks: listTaskModel);

  @override
  List<Object?> get props => [];
}

class TasksError extends TasksState {
  @override
  List<Object?> get props => [];

  final String? message;

  const TasksError(this.message) : super(listsTasks: null);
}
