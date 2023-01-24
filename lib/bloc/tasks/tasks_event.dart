part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class GetListTask extends TasksEvent {}

class PostTask extends TasksEvent {
  final TaskModel taskModel;

  const PostTask({required this.taskModel});
}
