import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_flow/app/data/models/purchase_model.dart';
import 'package:stock_flow/app/theme/app_color_theme.dart';
import 'package:stock_flow/app/theme/app_text_theme.dart';
import 'package:stock_flow/widgets/button_qty_widget.dart';
import 'package:stock_flow/widgets/custom_form_field_widget.dart';
import '../controllers/form_purchase_controller.dart';

class FormPurchaseView extends GetView<FormPurchaseController> {
  const FormPurchaseView({super.key});

  @override
  Widget build(BuildContext context) {
    final PurchaseModel? purchase = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(purchase == null ? 'Add New Purchase' : 'Edit Purchase'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel(context, "Select Customer"),
            const SizedBox(height: 10),
            CustomDropdown(
              hintText: "Select Customer",
              controller: controller.customerName,
              decoration: _dropdownDecoration(context),
              items: controller.customerController.state
                  ?.map((b) => b.name)
                  .toList(),
              onChanged: (val) => controller.onCustomerChanged(val),
            ),

            const SizedBox(height: 16),
            _buildLabel(context, "Select Product"),
            const SizedBox(height: 10),
            CustomDropdown(
              hintText: "Select Product",
              controller: controller.productName,
              decoration: _dropdownDecoration(context),
              items: controller.productController.state
                  ?.map((b) => b.name)
                  .toList(),
              onChanged: (val) => controller.onProductChanged(val),
            ),

            const SizedBox(height: 16),
            _buildLabel(context, "Select Order Date"),
            const SizedBox(height: 10),
            CustomeFormField(
              hint: "Select order date",
              isReadOnly: true,
              controller: controller.dateController,
              onTap: () => controller.pickDate(context),
            ),

            const SizedBox(height: 16),
            // --- Quantity ---
            _buildLabel(context, "Qty Product"),
            const SizedBox(height: 10),
            Obx(
              () => ButtonQtyWidget(
                funLessQty: controller.lessQty,
                qty: controller.qty.value,
                funAddQty: controller.addQty,
                controller: controller.qtyController,
              ),
            ),

            const SizedBox(height: 32),
            // --- Action Button ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColorTheme(context).primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  if (purchase == null) {
                    controller.addPurchase();
                  } else {
                    controller.updatePurchase(purchase.id!);
                  }
                },
                child: Text(
                  purchase == null ? "Save Transaction" : "Update Transaction",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Text(
      text,
      style: appTextStyle(
        context,
      ).titleSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  CustomDropdownDecoration _dropdownDecoration(BuildContext context) {
    return CustomDropdownDecoration(
      closedFillColor: appColorTheme(context).onPrimary,
      closedBorder: BoxBorder.all(color: appColorTheme(context).outlineVariant),
      closedBorderRadius: BorderRadius.circular(30),
      expandedSuffixIcon: const Icon(Icons.keyboard_arrow_up),
    );
  }
}
