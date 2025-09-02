import 'package:breach/data/endpoints/auth_endpoints.dart';
import 'package:breach/data/endpoints/blog_endpoints.dart';
import 'package:breach/data/endpoints/users_endpoints.dart';

class BreachApi with AuthEndpoints, UsersEndpoints, BlogEndpoints {
  BreachApi._();

  static final BreachApi _instance = BreachApi._();

  static BreachApi get instance => _instance;
}
