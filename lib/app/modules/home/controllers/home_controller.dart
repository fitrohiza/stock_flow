import 'package:get/get.dart';
import 'package:stock_flow/app/modules/brands/controllers/brands_controller.dart';
import 'package:stock_flow/app/modules/customers/controllers/customers_controller.dart';
import 'package:stock_flow/app/modules/products/controllers/products_controller.dart';
import 'package:stock_flow/app/modules/transaction/controllers/transaction_controller.dart';

class HomeController extends GetxController with StateMixin<void> {
  final brandController = Get.put(BrandsController());
  final productController = Get.put(ProductsController());
  final customerController = Get.put(CustomersController());
  final transactionController = Get.put(TransactionController());

  @override
  void onInit() {
    super.onInit();
    loadAllData();
  }

  Future<void> loadAllData() async {
    change(null, status: RxStatus.loading());

    try {
      await Future.wait([
        brandController.getBrands(),
        productController.getProduct(),
        customerController.getCustomers(),
        transactionController.getTransactions(),
      ]);

      change(null, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
