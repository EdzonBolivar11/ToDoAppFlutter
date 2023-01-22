import 'dart:convert';

ListTaskModel listTaskModelFromJson(String str) =>
    ListTaskModel.fromJson(json.decode(str));

String listTaskModelToJson(ListTaskModel data) => json.encode(data.toJson());

class ListTaskModel {
  ListTaskModel({
    this.documents,
    this.nextPageToken,
  });

  List<Document>? documents;
  String? nextPageToken;
  String? error;

  factory ListTaskModel.fromJson(Map<String, dynamic> json) => ListTaskModel(
        documents: json["documents"] == null
            ? []
            : List<Document>.from(
                json["documents"]!.map((x) => Document.fromJson(x))),
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
}

class Document {
  Document({
    this.name,
    this.fields,
    this.createTime,
    this.updateTime,
  });

  String? name;
  Fields? fields;
  DateTime? createTime;
  DateTime? updateTime;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        name: json["name"],
        fields: json["fields"] == null ? null : Fields.fromJson(json["fields"]),
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
}

class Fields {
  Fields({
    this.date,
    this.categoryId,
    this.name,
    this.isCompleted,
  });

  Date? date;
  CategoryId? categoryId;
  CategoryId? name;
  IsCompleted? isCompleted;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        date: json["date"] == null ? null : Date.fromJson(json["date"]),
        categoryId: json["categoryId"] == null
            ? null
            : CategoryId.fromJson(json["categoryId"]),
        name: json["name"] == null ? null : CategoryId.fromJson(json["name"]),
        isCompleted: json["isCompleted"] == null
            ? null
            : IsCompleted.fromJson(json["isCompleted"]),
      );

  Map<String, dynamic> toJson() => {
        "date": date?.toJson(),
        "categoryId": categoryId?.toJson(),
        "name": name?.toJson(),
        "isCompleted": isCompleted?.toJson(),
      };
}

class CategoryId {
  CategoryId({
    this.stringValue,
  });

  String? stringValue;

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        stringValue: json["stringValue"],
      );

  Map<String, dynamic> toJson() => {
        "stringValue": stringValue,
      };
}

class Date {
  Date({
    this.integerValue,
  });

  String? integerValue;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        integerValue: json["integerValue"],
      );

  Map<String, dynamic> toJson() => {
        "integerValue": integerValue,
      };
}

class IsCompleted {
  IsCompleted({
    this.booleanValue,
  });

  bool? booleanValue;

  factory IsCompleted.fromJson(Map<String, dynamic> json) => IsCompleted(
        booleanValue: json["booleanValue"],
      );

  Map<String, dynamic> toJson() => {
        "booleanValue": booleanValue,
      };
}
