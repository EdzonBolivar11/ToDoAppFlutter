import 'package:to_do_app/data/datas.dart';

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
