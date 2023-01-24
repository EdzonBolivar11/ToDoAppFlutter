import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:to_do_app/data/datas.dart';
import 'package:to_do_app/src/constants/api/api_constants.dart';

class ApiProvider {
  final _dio = Dio();

  Future<TokenModel> login() async {
    try {
      var body = {
        "email": "test@test.com",
        "password": "password",
        "returnSecureToken": true
      };

      Response response = await _dio.post(
        ApiConstants.loginURL,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(body),
      );

      return TokenModel.fromJson(response.data);
    } catch (error) {
      return TokenModel.withError(error.toString());
    }
  }

  Future<ListTaskModel> getTasks() async {
    try {
      String? token = "";

      await StorageProvider.readData("token").then((value) {
        if (value != "") {
          token = tokenModelFromJson(value).idToken;
        }
      });

      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers["authorization"] = "Bearer $token";

      Response response = await _dio.get(ApiConstants.tasksURL);
      return ListTaskModel.fromJson(response.data);
    } on DioError catch (e) {
      return ListTaskModel.withError(e.message);
    } catch (error) {
      return ListTaskModel.withError(error.toString());
    }
  }

  Future<ListCategoriesModel> getCategories() async {
    try {
      String? token = "";

      await StorageProvider.readData("token").then((value) {
        if (value != "") {
          token = tokenModelFromJson(value).idToken;
        }
      });
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers["authorization"] = "Bearer $token";

      Response response = await _dio.get(ApiConstants.getCategoriesURL);
      return ListCategoriesModel.fromJson(response.data);
    } on DioError catch (e) {
      return ListCategoriesModel.withError(e.message);
    } catch (error) {
      return ListCategoriesModel.withError(error.toString());
    }
  }

  Future<TaskModel> postTask(TaskModel taskModel) async {
    try {
      String? token = "";

      await StorageProvider.readData("token").then((value) {
        if (value != "") {
          token = tokenModelFromJson(value).idToken;
        }
      });
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers["authorization"] = "Bearer $token";

      var body = {
        "fields": {
          "date": {"integerValue": taskModel.fields!.date!.integerValue},
          "categoryId": {
            "stringValue": taskModel.fields!.categoryId!.stringValue
          },
          "name": {"stringValue": taskModel.fields!.name!.stringValue},
          "isCompleted": {"booleanValue": false}
        }
      };

      Response response = await _dio.post(
        ApiConstants.tasksURL,
        data: jsonEncode(body),
      );

      return TaskModel.fromJson(response.data);
    } on DioError catch (e) {
      return TaskModel.withError(e.message);
    } catch (error) {
      return TaskModel.withError(error.toString());
    }
  }

  Future<TaskModel> patchTask(TaskModel taskModel) async {
    try {
      String? token = "";

      await StorageProvider.readData("token").then((value) {
        if (value != "") {
          token = tokenModelFromJson(value).idToken;
        }
      });
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers["authorization"] = "Bearer $token";

      var body = {
        "fields": {
          "date": {"integerValue": taskModel.fields!.date!.integerValue},
          "categoryId": {
            "stringValue": taskModel.fields!.categoryId!.stringValue
          },
          "name": {"stringValue": taskModel.fields!.name!.stringValue},
          "isCompleted": {"booleanValue": false}
        }
      };

      Response response = await _dio.patch(
        ApiConstants.updateTaskURL(taskModel.id),
        data: jsonEncode(body),
      );

      return TaskModel.fromJson(response.data);
    } on DioError catch (e) {
      return TaskModel.withError(e.message);
    } catch (error) {
      return TaskModel.withError(error.toString());
    }
  }
}
