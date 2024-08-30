import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopyy/views/splash/splash_view.dart';

void main() {
  runApp(const Shopyy());
}

class Shopyy extends StatelessWidget {
  const Shopyy({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return ProviderScope(
            child: GetMaterialApp(
              theme: ThemeData(fontFamily: 'PlayFair'),
              debugShowCheckedModeBanner: false,
              home: child,
            ),
          );
        },
        child: const SplashView());
  }
}
