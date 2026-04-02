import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stock_flow/app/data/models/customer_model.dart';
import 'package:stock_flow/app/data/models/product_model.dart';
import 'package:stock_flow/app/routes/app_pages.dart';
import 'package:stock_flow/app/theme/app_color_theme.dart';
import 'package:stock_flow/app/theme/app_text_theme.dart';
import 'package:stock_flow/widgets/summary_card.dart';
import 'package:stock_flow/widgets/transactions_card.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello, There!",
          style: appTextStyle(
            context,
          ).titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: controller.obx(
        (value) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              Text(
                "Statistics",
                style: appTextStyle(
                  context,
                ).titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 3 / 2,

                physics: const NeverScrollableScrollPhysics(),

                children: [
                  SummaryCard(
                    title: "Brands",
                    value:
                        controller.brandController.state?.length.toString() ??
                        '0',
                    icon: MingCute.palette_fill,
                    colors: Colors.deepPurple,
                  ),
                  SummaryCard(
                    title: "Product",
                    value:
                        controller.productController.state?.length.toString() ??
                        '0',
                    icon: Icons.inventory_2,
                    colors: Colors.deepPurple,
                  ),

                  SummaryCard(
                    title: "Customer",
                    value:
                        controller.customerController.state?.length
                            .toString() ??
                        '0',
                    icon: Icons.people,
                    colors: Colors.purple,
                  ),

                  SummaryCard(
                    title: "Transaction",
                    value:
                        controller.transactionController.state?.length
                            .toString() ??
                        '0',
                    icon: MingCute.bill_fill,
                    colors: Colors.blue,
                  ),
                ],
              ),

              const SizedBox(height: 24),
              Text(
                "Recent Transactions",
                style: appTextStyle(
                  context,
                ).titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: min(
                  controller.transactionController.state?.length ?? 0,
                  5,
                ),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final data = controller.transactionController.state?[index];
                  return Card(
                    color: appColorTheme(context).onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TransactionsCard(
                      name: controller.customerController.state!
                          .firstWhere(
                            (c) => c.id == data?.customerId,
                            orElse: () => CustomerModel(
                              id: 0,
                              name: "-",
                              address: '',
                              gender: '',
                              dateOfBirth: '',
                            ),
                          )
                          .name,
                      dateString: data?.orderDate ?? '',
                      product: controller.productController.state!
                          .firstWhere(
                            (p) => p.id == data?.productId,
                            orElse: () => ProductModel(
                              id: 0,
                              name: "-",
                              code: '',
                              brandId: 0,
                              createdAt: '',
                            ),
                          )
                          .name,
                      qty: data?.qty.toString() ?? '0',
                      onTap: () {
                        Get.toNamed(Routes.FORM_PURCHASE, arguments: data);
                      },
                      onDelete: () {
                        controller.transactionController.deletePurchase(
                          data?.id ?? 0,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
