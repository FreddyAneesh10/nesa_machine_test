import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ProductService {
  final Dio dio = Dio(
    BaseOptions(baseUrl: "https://dummyjson.com"),
  );

  Future<List<ProductModel>> fetchProducts({
    int limit = 10,
    int skip = 0,
  }) async {
    final response = await dio.get(
      "/products",
      queryParameters: {
        "limit": limit,
        "skip": skip,
      },
    );

    final List products = response.data['products'];
    return products.map((e) => ProductModel.fromJson(e)).toList();
  }

  Future<ProductModel> fetchProductById(int id) async {
    final response = await dio.get("/products/$id");
    return ProductModel.fromJson(response.data);
  }

  Future<ProductModel> updateProduct(
      int id, Map<String, dynamic> data) async {
    final response = await dio.put(
      "/products/$id",
      data: data,
    );
    return ProductModel.fromJson(response.data);
  }
}