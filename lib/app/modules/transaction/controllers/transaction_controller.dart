import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_flow/app/data/models/purchase_model.dart';
import 'package:stock_flow/app/data/repository/purchase_repository.dart';
import 'package:stock_flow/app/modules/brands/controllers/brands_controller.dart';
import 'package:stock_flow/app/modules/customers/controllers/customers_controller.dart';
import 'package:stock_flow/app/modules/products/controllers/products_controller.dart';
import 'package:stock_flow/app/utils/dialog_utils.dart';

class TransactionController extends GetxController
    with StateMixin<List<PurchaseModel>> {
  final repo = PurchaseRepository();

  final nameController = TextEditingController();
  final productName = SingleSelectController<String>(null);
  final customerName = SingleSelectController<String>(null);

  final dateController = TextEditingController();
  final qtyController = TextEditingController(text: '1');

  final productsId = 0.obs;
  final customerId = 0.obs;
  final qty = 1.obs;

  final brandController = Get.find<BrandsController>();
  final productController = Get.find<ProductsController>();
  final customerController = Get.find<CustomersController>();

  @override
  void onInit() {
    getTransactions();
    super.onInit();
    qtyController.addListener(() {
      final text = qtyController.text;

      if (text.isEmpty) return;

      final value = int.tryParse(text);
      if (value != null && value > 0) {
        qty.value = value;
      }
    });
  }

  Future<void> getTransactions() async {
    print("GETGETGET");
    change(null, status: RxStatus.loading());

    final result = await repo.getPurchases();
    result.fold(
      (failure) {
        change(null, status: RxStatus.error(failure.message));
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

  Future<void> deletePurchase(int id) async {
    DialogUtils.showChoose(
      "Do you want to delete this transaction?",
      "Yes",
      onClick: () async {
        Get.back();
        final result = await repo.deletePurchase(id);

        result.fold(
          (failure) {
            Get.snackbar("Error", failure.message);
          },
          (success) {
            Get.snackbar("Success", "Transaction deleted successfully");
            getTransactions();
          },
        );
      },
    );
  }
}
