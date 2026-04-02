import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_flow/app/data/models/product_model.dart';
import 'package:stock_flow/app/data/repository/product_repository.dart';
import 'package:stock_flow/app/modules/brands/controllers/brands_controller.dart';
import 'package:stock_flow/app/utils/dialog_utils.dart';

class ProductsController extends GetxController
    with StateMixin<List<ProductModel>> {
  final repo = ProductRepository();

  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final typeBrand = SingleSelectController<String>(null);

  final brandId = 0.obs;

  final brandController = Get.find<BrandsController>();

  @override
  void onInit() {
    getProduct();
    super.onInit();
  }

  Future<void> getProduct() async {
    change(null, status: RxStatus.loading());

    final result = await repo.getProducts();
    result.fold(
      (failure) {
        change(null, status: RxStatus.error(failure.message));
        print("Error: ${failure.message}");
      },
      (response) {
        if (response.isEmpty) {
          change([], status: RxStatus.empty());
        } else {
          change(response, status: RxStatus.success());
        }
      },
    );
  }

  Future<void> addProduct() async {
    final name = nameController.text.trim();
    final code = codeController.text.trim();

    if (name.isEmpty || code.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    final newProduct = ProductModel(
      name: name,
      code: code,
      brandId: brandId.value,
      createdAt: DateTime.now().toIso8601String(),
    );

    final result = await repo.insertProduct(newProduct);

    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
      },
      (success) {
        Get.back();
        Get.snackbar("Success", "Product added successfully");
        nameController.clear();
        codeController.clear();

        getProduct();
      },
    );
  }

  Future<void> deleteProduct(int id) async {
    DialogUtils.showChoose(
      "Do you want to delete this product?",
      "Yes",
      onClick: () async {
        Get.back();
        DialogUtils.showLoading("Deleting product...");
        final result = await repo.deleteProduct(id);

        result.fold(
          (failure) {
            Get.back();
            Get.snackbar("Error", failure.message);
          },
          (success) {
            Get.back();
            Get.snackbar("Success", "Product deleted successfully");
            getProduct();
          },
        );
      },
    );
  }

  Future<void> updateProduct(int id) async {
    DialogUtils.showLoading("Updating product...");
    final name = nameController.text.trim();
    final code = codeController.text.trim();

    if (name.isEmpty || code.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    final updatedCustomer = ProductModel(
      id: id,
      name: name,
      code: code,
      brandId: 1,
      createdAt: DateTime.now().toIso8601String(),
    );

    final result = await repo.updateProduct(updatedCustomer);
    Get.back();

    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
        print(failure.message);
      },
      (success) {
        Get.snackbar("Success", "Product updated successfully");
        getProduct();
      },
    );
  }
}
