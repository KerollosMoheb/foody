import 'package:food_app/core/network/api_service.dart';
import 'package:food_app/features/home/data/models/product_model.dart';
import 'package:food_app/features/home/data/models/topping_model.dart';

class ProductRepo {
  final ApiService _apiService = ApiService();

  ///GET PRODUCTS
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _apiService.get("/products/");
      return (response["data"] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  ///GET TOPPINGS
  Future<List<ToppingModel>> getToppings() async {
    try {
      final response = await _apiService.get("/toppings");
      return (response["data"] as List)
          .map((topping) => ToppingModel.fromJson(topping))
          .toList();
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  ///GET SIDE-OPTIONS
  Future<List<ToppingModel>> getOptions() async {
    try {
      final response = await _apiService.get("/side-options");
      return (response["data"] as List)
          .map((topping) => ToppingModel.fromJson(topping))
          .toList();
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  ///SEARCH
  Future<List<ProductModel?>> searchProducts(String name) async {
    try {
      final response = await _apiService.get(
        "/products",
        param: {"name": name},
      );
      return (response["data"] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  ///CATEGORY

  ///ORDER
}
