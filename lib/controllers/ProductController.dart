import 'package:flutter/foundation.dart';
import '../models/product_model.dart';
import '../services/product_services.dart';

class ProductController extends ChangeNotifier {
  final ProductService _service = ProductService();

  List<ProductModel> products = [];
  ProductModel? selectedProduct;

  bool isLoading = false;
  bool isFetchingMore = false;
  bool hasMore = true;

  String? error;

  int _limit = 10;
  int _skip = 0;

  // ===============================
  // LOAD PRODUCT LIST (Pagination)
  // ===============================

  Future<void> loadProducts({bool loadMore = false}) async {
    if (isLoading || isFetchingMore) return;

    try {
      if (loadMore) {
        isFetchingMore = true;
      } else {
        isLoading = true;
        products.clear();
        _skip = 0;
        hasMore = true;
      }

      notifyListeners();

      final newProducts = await _service.fetchProducts(
        limit: _limit,
        skip: _skip,
      );

      if (newProducts.isEmpty) {
        hasMore = false;
      } else {
        _skip += _limit;
        products.addAll(newProducts);
      }

      error = null;
    } catch (e) {
      error = "Failed to load products";
    }

    isLoading = false;
    isFetchingMore = false;
    notifyListeners();
  }

  // ===============================
  // LOAD PRODUCT DETAILS
  // ===============================

  Future<void> loadProductDetails(int id) async {
    try {
      isLoading = true;
      notifyListeners();

      selectedProduct = await _service.fetchProductById(id);
      error = null;
    } catch (e) {
      error = "Failed to load product details";
    }

    isLoading = false;
    notifyListeners();
  }

  // ===============================
  // UPDATE PRODUCT (PUT)
  // ===============================

  Future<void> updateProduct(
    int id,
    String title,
    double price,
    String description,
  ) async {
    try {
      isLoading = true;
      notifyListeners();

      final updatedProduct = await _service.updateProduct(id, {
        "title": title,
        "price": price,
        "description": description,
      });

      // ✅ Update selected product
      selectedProduct = updatedProduct;
      final index = products.indexWhere((product) => product.id == id);

      if (index != -1) {
        products[index] = updatedProduct;
      }

      error = null;
    } catch (e) {
      error = "Update failed";
    }

    isLoading = false;
    notifyListeners();
  }
}
