import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_flow/app/routes/app_pages.dart';
import 'package:stock_flow/app/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope?.unfocus(),
      child: GetMaterialApp(
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: appTheme(context, Brightness.light),
        darkTheme: appTheme(context, Brightness.light),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('id')],
      ),
    );
  }
}
