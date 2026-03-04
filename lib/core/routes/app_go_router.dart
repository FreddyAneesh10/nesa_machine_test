import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nesa_machine_test/views/screens/edit_product_screen.dart';
import 'package:nesa_machine_test/views/screens/product_details_screen.dart';
import 'package:nesa_machine_test/views/screens/product_list_screen.dart';
import 'app_routes.dart';

class AppGoRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.productListScreen,
    routes: [
      GoRoute(
        path: AppRoutes.productListScreen,
        builder: (context, state) => const ProductListScreen(),
      ),

      GoRoute(
        path: "${AppRoutes.productDetailScreen}/:id",
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);

          return ProductDetailsScreen(productId: id);
        },
      ),
      // ✅ FIXED EDIT ROUTE
      GoRoute(
        path: "${AppRoutes.editProductScreen}/:id",
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return EditProductScreen(productId: id);
        },
      ),
    ],
  );
}
