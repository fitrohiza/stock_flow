import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_flow/app/modules/home/controllers/home_controller.dart';
import 'package:stock_flow/app/modules/home/views/home_view.dart';
import 'package:stock_flow/app/modules/master/controllers/master_controller.dart';
import 'package:stock_flow/app/modules/master/views/master_view.dart';
import 'package:stock_flow/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:stock_flow/app/modules/transaction/views/transaction_view.dart';
import '../controllers/bottom_navbar_controller.dart';
import 'package:icons_plus/icons_plus.dart';

class BottomNavbarView extends GetView<BottomNavbarController> {
  const BottomNavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(BottomNavbarController());
    return Obx(
      () => Scaffold(
        extendBody: true,
        body: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            controller.currentIndex.value = index;
          },
          children: const [HomeView(), TransactionView(), MasterView()],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              elevation: 0,
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.grey,
              currentIndex: controller.currentIndex.value,
              onTap: (index) {
                controller.currentIndex.value = index;
                controller.pageController.jumpToPage(index);

                switch (index) {
                  case 0:
                    Get.delete<HomeController>();
                    Get.put(HomeController());
                    break;
                  case 1:
                    Get.delete<TransactionController>();
                    Get.put(TransactionController());
                    break;
                  case 2:
                    Get.delete<MasterController>();
                    Get.put(MasterController());
                    break;
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    controller.currentIndex.value == 0
                        ? MingCute.home_6_fill
                        : MingCute.home_6_line,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    controller.currentIndex.value == 1
                        ? MingCute.bill_fill
                        : MingCute.bill_line,
                  ),
                  label: "Transaction",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    controller.currentIndex.value == 2
                        ? MingCute.box_2_fill
                        : MingCute.box_2_line,
                  ),
                  label: "Master",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
