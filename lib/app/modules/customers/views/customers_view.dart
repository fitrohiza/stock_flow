import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stock_flow/app/data/models/customer_model.dart';
import 'package:stock_flow/app/theme/app_color_theme.dart';
import 'package:stock_flow/app/theme/app_text_theme.dart';
import 'package:stock_flow/widgets/custom_form_field_widget.dart';
import 'package:stock_flow/widgets/empty_page.dart';
import '../controllers/customers_controller.dart';

class CustomersView extends GetView<CustomersController> {
  const CustomersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (customer) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: customer?.length ?? 0,
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
                      color: appColorTheme(context).primaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      MingCute.user_2_fill,
                      color: appColorTheme(context).primary,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customer?[index].name ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          customer?[index].address ?? "",
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
                          _showForm(context, customer: customer?[index]);
                        },
                        icon: const Icon(Icons.edit, color: Colors.orange),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.deleteCustomer(customer?[index].id ?? 0);
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
            message: "No customers available",
            icon: MingCute.group_fill,
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

  void _showForm(BuildContext context, {CustomerModel? customer}) {
    // Jika edit, isi form dengan data existing
    if (customer != null) {
      controller.nameController.text = customer.name;
      controller.addressController.text = customer.address;
      controller.dateController.text = customer.dateOfBirth;
      controller.selectedGender.value = customer.gender.toLowerCase() == "male"
          ? 1
          : 2;
    } else {
      // Jika add, clear form
      controller.nameController.clear();
      controller.addressController.clear();
      controller.dateController.clear();
      controller.selectedGender.value = 1; // default Male
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
                customer == null ? "Add New Customer" : "Edit Customer",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Customer Name",
                style: appTextStyle(
                  context,
                ).titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              CustomeFormField(
                hint: "Enter customer name",
                controller: controller.nameController,
              ),
              const SizedBox(height: 16),
              Text(
                "Customer Address",
                style: appTextStyle(
                  context,
                ).titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              CustomeFormField(
                hint: "Enter customer address",
                controller: controller.addressController,
              ),
              const SizedBox(height: 16),
              Text(
                "Date of Birth",
                style: appTextStyle(
                  context,
                ).titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              CustomeFormField(
                hint: "Select date of birth",
                isReadOnly: true,
                controller: controller.dateController,
                onTap: () async {
                  final now = DateTime.now();
                  final earliestDate = DateTime(
                    now.year - 100,
                    now.month,
                    now.day,
                  );
                  final latestDate = now;
                  final initialDate = customer != null
                      ? DateTime.parse(customer.dateOfBirth)
                      : DateTime(now.year - 20, now.month, now.day);

                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: earliestDate,
                    lastDate: latestDate,
                    builder: (context, child) => Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: appColorTheme(context).primary,
                          onPrimary: appColorTheme(context).onPrimary,
                          onSurface: appColorTheme(context).outline,
                        ),
                      ),
                      child: child!,
                    ),
                  );

                  if (pickedDate != null) {
                    controller.dateController.text =
                        '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
                  }
                },
              ),
              const SizedBox(height: 16),
              Text(
                "Gender",
                style: appTextStyle(
                  context,
                ).titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              Obx(() {
                return Row(
                  children: [
                    Expanded(
                      child: RadioListTile<int>(
                        title: const Text("Male"),
                        value: 1,
                        groupValue: controller.selectedGender.value,
                        onChanged: (value) =>
                            controller.selectedGender.value = value!,
                        activeColor: appColorTheme(context).primary,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<int>(
                        title: const Text("Female"),
                        value: 2,
                        groupValue: controller.selectedGender.value,
                        onChanged: (value) =>
                            controller.selectedGender.value = value!,
                        activeColor: appColorTheme(context).primary,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 16),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: appColorTheme(context).primary,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 48),
                ),
                onPressed: () {
                  if (customer == null) {
                    controller.addCustomer();
                  } else {
                    controller.updateCustomer(customer.id!);
                  }
                  Get.back();
                },
                child: Text(
                  customer == null ? "Add Customer" : "Update Customer",
                ),
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
