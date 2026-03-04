import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:nesa_machine_test/views/widget/CustomAppBarWidget.dart';

import '../../controllers/ProductController.dart';
import '../../core/routes/app_routes.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    scrollController.addListener(() {
      final controller = context.read<ProductController>();

      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          controller.hasMore &&
          !controller.isFetchingMore) {
        controller.loadProducts(loadMore: true);
      }
    });
    Future.microtask(() {
      final controller = context.read<ProductController>();
      if (controller.products.isEmpty && !controller.isLoading) {
        controller.loadProducts();
      }
    });

    return Scaffold(
      appBar: CustomAppBarWidget(
        leading: const Icon(Icons.menu),
        action: const Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(Icons.shopping_cart_outlined),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            Text(
              "Discover our exclusive\nproducts",
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Products',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Show all',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Expanded(
              child: Consumer<ProductController>(
                builder: (context, controller, child) {
                  if (controller.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.error != null) {
                    return Center(child: Text(controller.error!));
                  }

                  return GridView.builder(
                    itemCount: controller.products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.7,
                        ),
                    itemBuilder: (context, index) {
                      final product = controller.products[index];

                      return GestureDetector(
                        onTap: () {
                          context.go(
                            "${AppRoutes.productDetailScreen}/${product.id}",
                          );
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                child: Image.network(
                                  product.thumbnail,
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "₹${product.description}",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "₹${product.price}",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
