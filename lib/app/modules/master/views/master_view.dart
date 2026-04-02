import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_flow/app/modules/brands/controllers/brands_controller.dart';
import 'package:stock_flow/app/modules/brands/views/brands_view.dart';
import 'package:stock_flow/app/modules/customers/controllers/customers_controller.dart';
import 'package:stock_flow/app/modules/customers/views/customers_view.dart';
import 'package:stock_flow/app/modules/products/controllers/products_controller.dart';
import 'package:stock_flow/app/modules/products/views/products_view.dart';
import '../controllers/master_controller.dart';

class MasterView extends GetView<MasterController> {
  const MasterView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(BrandsController());
    Get.put(CustomersController());
    Get.put(ProductsController());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: "Brands"),
              Tab(text: "Products"),
              Tab(text: "Customers"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [BrandsView(), ProductsView(), CustomersView()],
        ),
      ),
    );
  }
}
