import 'package:to_do_app/data/datas.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<TokenModel> login() {
    return _provider.login();
  }

  Future<ListTaskModel> getTasks() {
    return _provider.getTasks();
  }

  Future<ListCategoriesModel> getCategories() {
    return _provider.getCategories();
  }
}

class NetworkError extends Error {}
