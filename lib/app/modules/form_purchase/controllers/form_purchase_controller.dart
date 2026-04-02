import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_flow/app/data/models/purchase_model.dart';
import 'package:stock_flow/app/data/repository/purchase_repository.dart';
import 'package:stock_flow/app/modules/brands/controllers/brands_controller.dart';
import 'package:stock_flow/app/modules/customers/controllers/customers_controller.dart';
import 'package:stock_flow/app/modules/products/controllers/products_controller.dart';
import 'package:stock_flow/app/modules/transaction/controllers/transaction_controller.dart';

class FormPurchaseController extends GetxController {
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
  final transactionController = Get.find<TransactionController>();

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is PurchaseModel) {
      _fillFormData(Get.arguments);
    }
  }

  void _fillFormData(PurchaseModel purchase) {
    customerId.value = purchase.customerId;
    productsId.value = purchase.productId;
    dateController.text = purchase.orderDate;
    qty.value = purchase.qty;
    qtyController.text = purchase.qty.toString();

    customerName.value = customerController.state
        ?.firstWhereOrNull((c) => c.id == purchase.customerId)
        ?.name;
    productName.value = productController.state
        ?.firstWhereOrNull((p) => p.id == purchase.productId)
        ?.name;
  }

  Future<void> addPurchase() async {
    if (dateController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    final newPurchase = PurchaseModel(
      customerId: customerId.value,
      productId: productsId.value,
      orderDate: dateController.text.trim(),
      qty: qty.value,
    );

    final result = await repo.insertPurchase(newPurchase);

    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
      },
      (success) async {
        Get.back();
        dateController.clear();
        productsId.value = 0;
        customerId.value = 0;
        qty.value = 0;
        await transactionController.getTransactions();
        Get.snackbar("Success", "Transaction added successfully");
      },
    );
  }

  Future<void> updatePurchase(int id) async {
    if (dateController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    final updatedCustomer = PurchaseModel(
      id: id,
      customerId: customerId.value,
      productId: productsId.value,
      orderDate: dateController.text.trim(),
      qty: qty.value,
    );

    final result = await repo.updateProduct(updatedCustomer);
    Get.back();

    result.fold(
      (failure) {
        Get.back();
        Get.snackbar("Error", failure.message);
        print(failure.message);
      },
      (success) async {
        Get.back();
        Get.snackbar("Success", "Transaction updated successfully");
        Get.back();
        await transactionController.getTransactions();
      },
    );
  }

  void onCustomerChanged(String? name) {
    final res = customerController.state?.firstWhereOrNull(
      (c) => c.name == name,
    );
    if (res != null) customerId.value = res.id ?? 0;
  }

  void onProductChanged(String? name) {
    final res = productController.state?.firstWhereOrNull(
      (p) => p.name == name,
    );
    if (res != null) productsId.value = res.id ?? 0;
  }

  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dateController.text = picked.toString().split(' ')[0];
    }
  }

  void addQty() {
    qty.value++;
    qtyController.text = qty.value.toString();
  }

  void lessQty() {
    if (qty.value > 1) {
      qty.value--;
      qtyController.text = qty.value.toString();
    }
  }

  void clearFields() {
    dateController.clear();
    qtyController.text = '1';
    qty.value = 1;
    productsId.value = 0;
    customerId.value = 0;
  }
}
