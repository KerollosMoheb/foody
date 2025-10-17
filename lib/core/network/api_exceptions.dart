import 'package:dio/dio.dart';
import 'package:food_app/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException dio) {
    switch (dio.type) {
      case DioExceptionType.cancel:
        return ApiError(message: "Request to API server was cancelled");

      case DioExceptionType.connectionTimeout:
        return ApiError(message: "Connection timeout with API server");

      case DioExceptionType.sendTimeout:
        return ApiError(message: "Send timeout in connection with API server");

      case DioExceptionType.receiveTimeout:
        return ApiError(
          message: "Receive timeout in connection with API server",
        );

      case DioExceptionType.badResponse:
        final statusCode = dio.response?.statusCode;
        final message = _handleStatusCode(statusCode, dio.response?.data);
        return ApiError(message: message, statusCode: statusCode);

      case DioExceptionType.badCertificate:
        return ApiError(message: "Bad SSL certificate received from server");

      case DioExceptionType.connectionError:
        return ApiError(
          message: "Connection failed. Please check your internet connection",
        );

      case DioExceptionType.unknown:
        return ApiError(
          message: "Unexpected error occurred. Please try again later",
        );
    }
  }

  static String _handleStatusCode(int? statusCode, dynamic data) {
    switch (statusCode) {
      case 400:
        return "Bad request. Please check the data you provided";
      case 401:
        return "Unauthorized. Please log in again";
      case 403:
        return "Forbidden. You don't have permission to access this resource.";
      case 404:
        return "Resource not found";
      case 500:
        return "Internal server error. Please try again later";
      case 502:
        return "Bad gateway";
      case 503:
        return "Service unavailable. Please try again later";
      case 504:
        return "Gateway timeout";
      default:
        // Some APIs return error messages in the response body
        if (data != null && data is Map && data['message'] != null) {
          return data['message'].toString();
        }
        return "Received invalid status code: $statusCode";
    }
  }
}
