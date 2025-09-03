abstract class ApiPath {
  static const baseUrl = 'https://breach-api.qa.mvm-tech.xyz';

  static const register = '/api/auth/register';
  static const login = '/api/auth/login';

  static const getCategories = '/api/blog/categories';
  static getPostByCategory(int categoryId) =>
      "api/blog/posts?categoryId=$categoryId";

  static saveUserInterest(int userId) => "/api/users/$userId/interests";
  static getUserInterest(int userId) => "/api/users/$userId/interests";
}
