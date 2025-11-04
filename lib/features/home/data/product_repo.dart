import 'package:food_app/core/network/api_service.dart';
import 'package:food_app/features/home/data/product_model.dart';

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

  ///SEARCH

  ///CATEGORY

  ///ORDER
}
