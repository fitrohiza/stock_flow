import 'package:flutter/material.dart';

import 'package:get/get.dart';

class FormPurchaseView extends GetView {
  const FormPurchaseView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FormPurchaseView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FormPurchaseView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
