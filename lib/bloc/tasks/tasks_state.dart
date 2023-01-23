part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TasksInitial extends TasksState {}

class TasksLoading extends TasksState {}

class TasksLoaded extends TasksState {
  final ListTaskModel listTaskModel;
  const TasksLoaded(this.listTaskModel);
}

class TasksError extends TasksState {
  final String? message;

  const TasksError(this.message);
}

class TasksNoInternetState extends TasksState {}
