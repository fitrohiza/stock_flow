import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_flow/app/data/models/brand_model.dart';
import 'package:stock_flow/app/data/repository/brand_repository.dart';
import 'package:stock_flow/app/utils/dialog_utils.dart';

class BrandsController extends GetxController
    with StateMixin<List<BrandModel>> {
  final repo = BrandRepository();

  final nameController = TextEditingController();
  final codeController = TextEditingController();

  @override
  void onInit() {
    getBrands();
    super.onInit();
  }

  Future<void> getBrands() async {
    change(null, status: RxStatus.loading());

    final result = await repo.getBrands();
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

    if (name.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    final newProduct = BrandModel(
      name: name,
      createdAt: DateTime.now().toIso8601String(),
    );

    final result = await repo.insertBrand(newProduct);

    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
      },
      (success) {
        Get.back();
        Get.snackbar("Success", "Product added successfully");
        nameController.clear();
        codeController.clear();

        getBrands();
      },
    );
  }

  Future<void> deleteProduct(int id) async {
    DialogUtils.showChoose(
      "Do you want to delete this product?",
      "Yes",
      onClick: () async {
        DialogUtils.closeDialog();
        final result = await repo.deleteBrand(id);

        result.fold(
          (failure) {
            Get.snackbar("Error", failure.message);
          },
          (success) {
            Get.snackbar("Success", "Product deleted successfully");
            getBrands();
          },
        );
      },
    );
  }

  Future<void> updateProduct(int id) async {
    DialogUtils.showLoading("Updating product...");
    final name = nameController.text.trim();

    if (name.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    final updatedBrand = BrandModel(id: id, name: name);

    final result = await repo.updateBrand(id, updatedBrand);
    Get.back();

    result.fold(
      (failure) {
        Get.back();
        Get.snackbar("Error", failure.message);
        print(failure.message);
      },
      (success) {
        Get.back();
        Get.snackbar("Success", "Product updated successfully");
        getBrands();
      },
    );
  }
}
