import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:to_do_app/data/models/list_task.dart';
import 'package:to_do_app/data/models/user/token.dart';
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
        loginURL,
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
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers["authorization"] =
          "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjFhZjYwYzE3ZTJkNmY4YWQ1MzRjNDAwYzVhMTZkNjc2ZmFkNzc3ZTYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vYXBwbGF1ZG8tdG9kby1hcHAiLCJhdWQiOiJhcHBsYXVkby10b2RvLWFwcCIsImF1dGhfdGltZSI6MTY1ODkwMDAzMSwidXNlcl9pZCI6IllWM1BkRTRlenZkcUl3dlU5RGVFdFhXZDN4QzMiLCJzdWIiOiJZVjNQZEU0ZXp2ZHFJd3ZVOURlRXRYV2QzeEMzIiwiaWF0IjoxNjU4OTAwMDMxLCJleHAiOjE2NTg5MDM2MzEsImVtYWlsIjoidGVzdEB0ZXN0LmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ0ZXN0QHRlc3QuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.YEnChWrib8vrmGtuuUyEDQdDPUDlFxJPEEPI-AptgdLYrL3dZjgO0O1qJcKKdcJH_9ezOVVH_n6jxkjVhbLi-EX5dL6oYdQyKztW5uLwfasHCaJw-9KRuqERcQv0pDw2m4DVr4ZcXqJ9zL70Wf7dct8pfXXJfYf2nK5VW57AyG4QEOEsz0pq-6Maw2zle4rChI2QFRYsdAcFG8q8u5Esae4bfxCaIX1Lh2KnU13zS8I41hnrn3wlHWaxcugCSzCvvlyuXpl2D4gUt7vIIJZ1tiDtKdGX-CWmOCYLIvEmN1n9iy5sAsqwohlEbybhERVr-5fPlLD8t3RIiAxDMr4DrA";

      Response response = await _dio.get(getTasksURL);
      return ListTaskModel.fromJson(response.data);
    } on DioError catch (e) {
      return ListTaskModel.withError(e.message);
    } catch (error) {
      return ListTaskModel.withError(error.toString());
    }
  }
}
