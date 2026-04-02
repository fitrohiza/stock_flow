import 'package:get/get.dart';

import '../controllers/form_purchase_controller.dart';

class FormPurchaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormPurchaseController>(
      () => FormPurchaseController(),
    );
  }
}
