import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final int id;
  final String title;
  final String description;
  bool done;

  Item(
      {required this.id,
      required this.title,
      this.description = "",
      this.done = false});

  Item copyWith({int? id, String? title, String? description, bool? done}) {
    return Item(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        done: done ?? this.done);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'done': done,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
        id: map['id'] ?? "",
        title: map['title'] ?? "",
        description: map['description'] ?? "",
        done: map['done'] ?? "");
  }

  @override
  List<Object?> get props => [id, title, description, done];
}
