import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_flow/app/data/models/customer_model.dart';
import 'package:stock_flow/app/data/repository/customer_repository.dart';
import 'package:stock_flow/app/utils/dialog_utils.dart';

class CustomersController extends GetxController
    with StateMixin<List<CustomerModel>> {
  final repo = CustomerRepository();

  final dateController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final selectedGender = 0.obs; // 0: Male, 1: Female

  @override
  void onInit() {
    getCustomers();
    super.onInit();
  }

  Future<void> getCustomers() async {
    change(null, status: RxStatus.loading());

    final result = await repo.getCustomers();
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

  Future<void> addCustomer() async {
    final name = nameController.text.trim();
    final address = addressController.text.trim();
    final gender = selectedGender.value == 0 ? "Male" : "Female";
    final dob = dateController.text.trim();

    if (name.isEmpty || address.isEmpty || dob.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    final newCustomer = CustomerModel(
      name: name,
      address: address,
      gender: gender,
      dateOfBirth: dob,
      createdAt: DateTime.now().toIso8601String(),
    );

    final result = await repo.insertCustomer(newCustomer);

    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
      },
      (success) {
        Get.back();
        Get.snackbar("Success", "Customer added successfully");
        nameController.clear();
        addressController.clear();
        dateController.clear();
        selectedGender.value = 0;

        getCustomers();
      },
    );
  }

  Future<void> deleteCustomer(int id) async {
    DialogUtils.showChoose(
      "Do you want to delete this customer?",
      "Yes",
      onClick: () async {
        final result = await repo.deleteCustomer(id);

        Get.back();
        result.fold(
          (failure) {
            Get.snackbar("Error", failure.message);
          },
          (success) {
            Get.snackbar("Success", "Customer deleted successfully");
            getCustomers();
          },
        );
      },
    );
  }

  Future<void> updateCustomer(int id) async {
    DialogUtils.showLoading("Updating customer...");
    final name = nameController.text.trim();
    final address = addressController.text.trim();
    final gender = selectedGender.value == 1 ? "Male" : "Female";
    final dob = dateController.text.trim();

    if (name.isEmpty || address.isEmpty || dob.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    final updatedCustomer = CustomerModel(
      id: id,
      name: name,
      address: address,
      gender: gender,
      dateOfBirth: dob,
    );

    final result = await repo.updateCustomer(updatedCustomer);
    Get.back();

    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
        print(failure.message);
      },
      (success) {
        Get.snackbar("Success", "Customer updated successfully");
        getCustomers();
      },
    );
  }
}
