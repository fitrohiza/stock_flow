import 'package:get/get.dart';
import 'package:stock_flow/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  final idUser = 0.obs;
  @override
  void onInit() {
    super.onInit();
    funcInit();
  }

  Future<void> funcInit() async {
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAllNamed(Routes.BOTTOM_NAVBAR);
    });
  }
}
