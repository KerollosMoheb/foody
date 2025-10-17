import 'package:dio/dio.dart';
import 'package:food_app/core/network/api_exceptions.dart';
import 'package:food_app/core/network/dio_client.dart';

class ApiService {
  final DioClient _dioClient = DioClient();

  // GET
  Future<dynamic> get(String endPoint) async {
    try {
      final response = await _dioClient.dio.get(endPoint);
      return response.data;
    } on DioException catch (e) {
      final error = ApiExceptions.handleError(e);
      throw error;
    }
  }

  // POST
  Future<dynamic> post(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.dio.post(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      final error = ApiExceptions.handleError(e);
      throw error;
    }
  }

  // PUT
  Future<dynamic> put(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.dio.put(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      final error = ApiExceptions.handleError(e);
      throw error;
    }
  }

  // DELETE
  Future<dynamic> delete(String endPoint) async {
    try {
      final response = await _dioClient.dio.delete(endPoint);
      return response.data;
    } on DioException catch (e) {
      final error = ApiExceptions.handleError(e);
      throw error;
    }
  }
}
