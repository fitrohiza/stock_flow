import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stock_flow/app/data/models/brand_model.dart';
import 'package:stock_flow/app/data/models/product_model.dart';
import 'package:stock_flow/app/theme/app_color_theme.dart';
import 'package:stock_flow/app/theme/app_text_theme.dart';
import 'package:stock_flow/widgets/custom_form_field_widget.dart';
import 'package:stock_flow/widgets/empty_page.dart';
import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (product) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: product?.length ?? 0,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(MingCute.box_2_fill, color: Colors.green),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product?[index].name ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          controller.brandController.state!
                              .firstWhere(
                                (b) => b.id == product?[index].brandId,
                                orElse: () => BrandModel(id: 0, name: "-"),
                              )
                              .name,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Action
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _showForm(context, product: product?[index]);
                        },
                        icon: const Icon(Icons.edit, color: Colors.orange),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.deleteProduct(product?[index].id ?? 0);
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        onEmpty: Center(
          child: EmptyPage(
            message: "No products available",
            icon: MingCute.box_2_fill,
          ),
        ),
      ),

      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: Get.height * 0.1),
        child: FloatingActionButton(
          onPressed: () {
            _showForm(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showForm(BuildContext context, {ProductModel? product}) {
    if (product != null) {
      controller.nameController.text = product.name;
      controller.codeController.text = product.code;
    } else {
      controller.nameController.clear();
      controller.codeController.clear();
    }

    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                product == null ? "Add New Product" : "Edit Product",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Product Name",
                style: appTextStyle(
                  context,
                ).titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              CustomeFormField(
                hint: "Enter product name",
                controller: controller.nameController,
              ),
              const SizedBox(height: 16),
              Text(
                "Product Code",
                style: appTextStyle(
                  context,
                ).titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              CustomeFormField(
                hint: "Enter product code",
                controller: controller.codeController,
              ),
              const SizedBox(height: 16),
              Text(
                "Select Brand",
                style: appTextStyle(
                  context,
                ).titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              CustomDropdown(
                hintText: "Select Brand",
                controller: controller.typeBrand,
                decoration: CustomDropdownDecoration(
                  closedFillColor: appColorTheme(context).onPrimary,
                  closedBorder: BoxBorder.all(
                    color: appColorTheme(context).outlineVariant,
                  ),
                  closedBorderRadius: BorderRadius.circular(30),
                  expandedSuffixIcon: const Icon(MingCute.up_line),
                ),
                items: controller.brandController.state
                    ?.map((b) => b.name)
                    .toList(),
                onChanged: (String? newValue) {
                  final brand = controller.brandController.state?.firstWhere(
                    (b) => b.name == newValue,
                    orElse: () => BrandModel(id: 0, name: ""),
                  );
                  controller.brandId.value = brand?.id ?? 0;
                },
              ),
              const SizedBox(height: 16),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: appColorTheme(context).primary,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 48),
                ),
                onPressed: () {
                  if (product == null) {
                    controller.addProduct();
                  } else {
                    controller.updateProduct(product.id!);
                  }
                  Get.back();
                },
                child: Text(product == null ? "Add Product" : "Update Product"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
