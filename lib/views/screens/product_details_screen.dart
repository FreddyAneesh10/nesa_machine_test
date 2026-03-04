import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nesa_machine_test/core/constants/app_color.dart';
import 'package:nesa_machine_test/core/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:nesa_machine_test/views/widget/CustomAppBarWidget.dart';
import '../../controllers/ProductController.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<ProductController>();

      if (controller.selectedProduct == null ||
          controller.selectedProduct!.id != productId) {
        controller.loadProductDetails(productId);
      }
    });

    return Scaffold(
      appBar: CustomAppBarWidget(
        leading: IconButton(
          onPressed: () {
            context.go(AppRoutes.productListScreen);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        action: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Icon(Icons.favorite_border),
        ),
      ),
      body: Consumer<ProductController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.error != null) {
            return Center(child: Text(controller.error!));
          }

          final product = controller.selectedProduct;

          if (product == null) {
            return const SizedBox();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.deepPurple.shade100,
                        radius: 90,
                        backgroundImage: NetworkImage(product.thumbnail),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                Text(
                  "₹${product.price}",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 5),
                    Text("${product.rating}"),
                  ],
                ),

                const SizedBox(height: 10),

                Text("Stock: ${product.stock}"),

                const SizedBox(height: 10),

                Text("Category: ${product.category}"),

                const SizedBox(height: 20),

                Text(
                  "Description",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.description),
                    TextButton(
                      onPressed: () async {
                        await context.push(
                          "${AppRoutes.editProductScreen}/${product.id}",
                        );

                        // After coming back, reload details
                        context.read<ProductController>().loadProductDetails(
                          product.id,
                        );
                      },
                      child: Text(
                        'Edit product details',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'ADD TO CART',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
