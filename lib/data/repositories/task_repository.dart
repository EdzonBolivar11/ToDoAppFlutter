import 'package:to_do_app/data/models/list_task.dart';
import 'package:to_do_app/data/models/user/token.dart';
import 'package:to_do_app/data/providers/api/api.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<ListTaskModel> getTasks() {
    return _provider.getTasks();
  }

  Future<TokenModel> login() {
    return _provider.login();
  }
}

class NetworkError extends Error {}
