import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stock_flow/app/data/models/customer_model.dart';
import 'package:stock_flow/app/data/models/product_model.dart';
import 'package:stock_flow/app/routes/app_pages.dart';
import 'package:stock_flow/app/theme/app_color_theme.dart';
import 'package:stock_flow/app/theme/app_text_theme.dart';
import 'package:stock_flow/widgets/empty_page.dart';
import 'package:stock_flow/widgets/transactions_card.dart';
import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transactions',
          style: appTextStyle(
            context,
          ).titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: controller.obx(
        (purchase) => Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, Get.height * 0.1),
          child: RefreshIndicator(
            onRefresh: () => controller.getTransactions(),
            child: ListView.builder(
              itemCount: purchase?.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  color: appColorTheme(context).onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TransactionsCard(
                    name: controller.customerController.state!
                        .firstWhere(
                          (c) => c.id == purchase?[index].customerId,
                          orElse: () => CustomerModel(
                            id: 0,
                            name: "-",
                            address: '',
                            gender: '',
                            dateOfBirth: '',
                          ),
                        )
                        .name,
                    dateString: purchase?[index].orderDate ?? '',
                    product: controller.productController.state!
                        .firstWhere(
                          (p) => p.id == purchase?[index].productId,
                          orElse: () => ProductModel(
                            id: 0,
                            name: "-",
                            code: '',
                            brandId: 0,
                            createdAt: '',
                          ),
                        )
                        .name,
                    qty: purchase?[index].qty.toString() ?? '0',
                    onTap: () {
                      Get.toNamed(
                        Routes.FORM_PURCHASE,
                        arguments: purchase?[index],
                      );
                    },
                    onDelete: () {
                      controller.deletePurchase(purchase?[index].id ?? 0);
                    },
                  ),
                );
              },
            ),
          ),
        ),
        onEmpty: Center(
          child: EmptyPage(
            message: "Transactions not available",
            icon: MingCute.shopping_bag_1_fill,
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: Get.height * 0.1),
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.FORM_PURCHASE);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
