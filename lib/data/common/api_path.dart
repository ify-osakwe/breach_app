abstract class ApiPath {
  /// Base URL for the Breach API.
  static const baseUrl = 'https://breach-api.qa.mvm-tech.xyz';

  /// Endpoint for creating a new user account (registration).
  static const register = '/api/auth/register';

  /// Endpoint for user authentication (login).
  static const login = '/api/auth/login';

  /// Endpoint for fetching all blog categories.
  static const getCategories = '/api/blog/categories';

  /// Builds the endpoint to fetch blog posts filtered by a
  /// specific category [categoryId].
  static getPostByCategory(int categoryId) =>
      "/api/blog/posts?categoryId=$categoryId";

  /// Builds the endpoint to create or update the interests for
  /// a specific user identified by [userId].
  static saveUserInterest(int userId) => "/api/users/$userId/interests";

  /// Builds the endpoint to retrieve the interests for a
  /// specific user identified by [userId].
  static getUserInterest(int userId) => "/api/users/$userId/interests";

  /// Builds the WebSocket URL used for real-time communication.
  /// Attaches the provided [authToken] as a `token` query parameter
  /// and returns a secure `wss://` endpoint.
  static socketUrl(String authToken) =>
      "wss://breach-api-ws.qa.mvm-tech.xyz?token=$authToken";
}
