// To parse this JSON data, do
//
//     final listCategoriesModel = listCategoriesModelFromJson(jsonString);

import 'dart:convert';

ListCategoriesModel listCategoriesModelFromJson(String str) =>
    ListCategoriesModel.fromJson(json.decode(str));

String listCategoriesModelToJson(ListCategoriesModel data) =>
    json.encode(data.toJson());

class ListCategoriesModel {
  ListCategoriesModel({
    this.documents = const [],
  });

  List<CategoryModel>? documents;
  String? error;

  factory ListCategoriesModel.fromJson(Map<String, dynamic> json) =>
      ListCategoriesModel(
        documents: List<CategoryModel>.from(
            json["documents"].map((x) => CategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "documents": documents == null
            ? []
            : List<dynamic>.from(documents!.map((x) => x.toJson())),
      };

  ListCategoriesModel.withError(String message) {
    error = message;
  }
}

class CategoryModel {
  CategoryModel({
    this.name,
    this.fields,
    this.createTime,
    this.updateTime,
  });

  String? name;
  FieldsCategory? fields;
  DateTime? createTime;
  DateTime? updateTime;

  String get id {
    return name!.replaceAll(
        "projects/applaudo-todo-app/databases/(default)/documents/categories/",
        "");
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        name: json["name"],
        fields: FieldsCategory.fromJson(json["fields"]),
        createTime: DateTime.parse(json["createTime"]),
        updateTime: DateTime.parse(json["updateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "fields": fields?.toJson(),
        "createTime": createTime?.toIso8601String(),
        "updateTime": updateTime?.toIso8601String(),
      };
}

class FieldsCategory {
  FieldsCategory({
    this.name,
    this.color,
  });

  NameCategory? name;
  ColorCategory? color;

  factory FieldsCategory.fromJson(Map<String, dynamic> json) => FieldsCategory(
        name: NameCategory.fromJson(json["name"]),
        color: ColorCategory.fromJson(json["color"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name?.toJson(),
        "color": color?.toJson(),
      };
}

class ColorCategory {
  ColorCategory({
    this.stringValue = "",
  });

  String stringValue;

  factory ColorCategory.fromJson(Map<String, dynamic> json) => ColorCategory(
        stringValue: json["stringValue"],
      );

  Map<String, dynamic> toJson() => {
        "stringValue": stringValue,
      };
}

class NameCategory {
  NameCategory({
    this.stringValue = "",
  });

  String stringValue;

  factory NameCategory.fromJson(Map<String, dynamic> json) => NameCategory(
        stringValue: json["stringValue"],
      );

  Map<String, dynamic> toJson() => {
        "stringValue": stringValue,
      };
}
