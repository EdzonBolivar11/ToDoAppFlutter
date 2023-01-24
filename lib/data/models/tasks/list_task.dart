import 'dart:convert';

ListTaskModel listTaskModelFromJson(String str) =>
    ListTaskModel.fromJson(json.decode(str));

String listTaskModelToJson(ListTaskModel data) => json.encode(data.toJson());

class ListTaskModel {
  ListTaskModel({
    this.documents,
    this.nextPageToken,
  });

  List<TaskModel>? documents;
  String? nextPageToken;
  String? error;

  factory ListTaskModel.fromJson(Map<String, dynamic> json) => ListTaskModel(
        documents: json["documents"] == null
            ? []
            : List<TaskModel>.from(
                json["documents"]!.map((x) => TaskModel.fromJson(x))),
        nextPageToken: json["nextPageToken"],
      );

  Map<String, dynamic> toJson() => {
        "documents": documents == null
            ? []
            : List<dynamic>.from(documents!.map((x) => x.toJson())),
        "nextPageToken": nextPageToken,
      };

  ListTaskModel.withError(String message) {
    error = message;
  }

  copyWith({
    List<TaskModel>? documents,
    String? nextPageToken,
  }) =>
      ListTaskModel(
          documents: documents ?? this.documents,
          nextPageToken: nextPageToken ?? this.nextPageToken);
}

class TaskModel {
  TaskModel({
    this.name,
    this.fields,
    this.createTime,
    this.updateTime,
  });

  String? name;
  FieldsTask? fields;
  DateTime? createTime;
  DateTime? updateTime;
  String? error;

  String get id {
    return name!.replaceAll(
        "projects/applaudo-todo-app/databases/(default)/documents/tasks/", "");
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        name: json["name"],
        fields:
            json["fields"] == null ? null : FieldsTask.fromJson(json["fields"]),
        createTime: json["createTime"] == null
            ? null
            : DateTime.parse(json["createTime"]),
        updateTime: json["updateTime"] == null
            ? null
            : DateTime.parse(json["updateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "fields": fields?.toJson(),
        "createTime": createTime?.toIso8601String(),
        "updateTime": updateTime?.toIso8601String(),
      };

  factory TaskModel.copyWith() {
    return TaskModel(
        name: "",
        fields: FieldsTask(
            date: Date(integerValue: ""),
            categoryId: CategoryId(stringValue: ""),
            name: TaskName(stringValue: ""),
            isCompleted: IsCompleted(booleanValue: false)),
        createTime: DateTime.now(),
        updateTime: DateTime.now());
  }

  TaskModel.withError(String message) {
    error = message;
  }
}

class FieldsTask {
  FieldsTask({
    this.date,
    this.categoryId,
    this.name,
    IsCompleted? isCompleted,
  }) : isCompleted = isCompleted ?? IsCompleted();

  Date? date;
  CategoryId? categoryId;
  TaskName? name;
  IsCompleted isCompleted;

  factory FieldsTask.fromJson(Map<String, dynamic> json) => FieldsTask(
        date: json["date"] == null ? null : Date.fromJson(json["date"]),
        categoryId: json["categoryId"] == null
            ? null
            : CategoryId.fromJson(json["categoryId"]),
        name: json["name"] == null ? null : TaskName.fromJson(json["name"]),
        isCompleted: IsCompleted.fromJson(json["isCompleted"]),
      );

  Map<String, dynamic> toJson() => {
        "date": date?.toJson(),
        "categoryId": categoryId?.toJson(),
        "name": name?.toJson(),
        "isCompleted": isCompleted.toJson(),
      };
}

class CategoryId {
  CategoryId({
    this.stringValue = "",
  });

  String stringValue;

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        stringValue: json["stringValue"],
      );

  Map<String, dynamic> toJson() => {
        "stringValue": stringValue,
      };
}

class TaskName {
  TaskName({
    this.stringValue = "",
  });

  String stringValue;

  factory TaskName.fromJson(Map<String, dynamic> json) => TaskName(
        stringValue: json["stringValue"],
      );

  Map<String, dynamic> toJson() => {
        "stringValue": stringValue,
      };
}

class Date {
  Date({
    this.integerValue = "",
  });

  String integerValue;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        integerValue: json["integerValue"],
      );

  Map<String, dynamic> toJson() => {
        "integerValue": integerValue,
      };
}

class IsCompleted {
  IsCompleted({
    this.booleanValue = false,
  });

  bool booleanValue;

  factory IsCompleted.fromJson(Map<String, dynamic> json) => IsCompleted(
        booleanValue: json["booleanValue"],
      );

  Map<String, dynamic> toJson() => {
        "booleanValue": booleanValue,
      };
}
