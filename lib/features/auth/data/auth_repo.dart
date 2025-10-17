import 'package:dio/dio.dart';
import 'package:food_app/core/network/api_error.dart';
import 'package:food_app/core/network/api_exceptions.dart';
import 'package:food_app/core/network/api_service.dart';
import 'package:food_app/core/utils/pref_helper.dart';
import 'package:food_app/features/auth/data/user_model.dart';

class AuthRepo {
  final ApiService apiService = ApiService();

  //Login == post
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiService.post("/login", {
        "email": email,
        "password": password,
      });
      final user = UserModel.fromJson(response['data']);
      if (user.token != null) {
        await PrefHelper.saveToken(user.token!);
      }
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // SignUp == post
  Future<UserModel?> signUp(String name, String email, String password) async {
    try {
      final response = await apiService.post('/register', {
        "name": name,
        "email": email,
        "password": password,
      });
      final user = UserModel.fromJson(response['data']);
      if (user.token != null) {
        await PrefHelper.saveToken(user.token!);
      }
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //Get Profile Data

  //Update Profile Data

  //Logout
}
