import 'package:flutter/material.dart';
import 'package:nesa_machine_test/views/widget/CustomAppBarWidget.dart';
import 'package:provider/provider.dart';
import '../../controllers/ProductController.dart';

class EditProductScreen extends StatelessWidget {
  final int productId;

  EditProductScreen({super.key, required this.productId});

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ProductController>();
    final product = controller.selectedProduct;

    // Prefill values
    if (product != null) {
      titleController.text = product.title;
      priceController.text = product.price.toString();
      descriptionController.text = product.description;
    }

    return Scaffold(
      appBar: CustomAppBarWidget(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (value) => value!.isEmpty ? "Enter title" : null,
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Price",),
                validator: (value) => value!.isEmpty ? "Enter price" : null,
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: "Description"),
                validator: (value) =>
                    value!.isEmpty ? "Enter description" : null,
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await controller.updateProduct(
                        productId,
                        titleController.text,
                        double.tryParse(priceController.text) ?? 0,
                        descriptionController.text,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Product updated successfully"),
                        ),
                      );

                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Update Product"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
