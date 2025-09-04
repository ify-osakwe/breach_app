import 'package:breach/data/common/api_client.dart';
import 'package:breach/data/common/api_path.dart';
import 'package:breach/data/common/api_response_model.dart';
import 'package:breach/data/models/categories_list_reponse.dart';
import 'package:breach/data/models/post_entity.dart';

mixin BlogEndpoints {
  final _apiClient = ApiClient();

  Future<ApiResult<CategoriesListResponse>> getCategories() {
    return _apiClient.getJsonList(
      ApiPath.getCategories,
      fromJsonList: CategoriesListResponse.fromJsonList,
    );
  }

  Future<ApiResult<CategoriesPostResponse>> getPostsByCategory({
    required int categoryId,
    required String authToken,
  }) {
    return _apiClient.getJsonList(
      ApiPath.getPostByCategory(categoryId),
      fromJsonList: CategoriesPostResponse.fromJsonList,
      headers: {'Authorization': 'Bearer $authToken'},
    );
  }
}
