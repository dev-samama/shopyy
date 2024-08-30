import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopyy/core/providers.dart';
import 'package:shopyy/core/utils/fixed.dart';
import 'package:shopyy/views/bottom_nav.dart';

class SplashView extends StatefulHookConsumerWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1)).then((value) {
      Get.offAll(() => const Base());
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scheduleMicrotask(() {
        ref.read(productControllerProvider).fetchProducts();
        ref.read(productControllerProvider).fetchCategories();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size s = getSize(context);
    return Material(
      child: Stack(
        children: [
          Image.asset(
            'lib/assets/images/splash-bg.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.black26,
                Colors.black26,
                Colors.black87,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),
          Center(
            child: SizedBox(
              height: s.height * 0.8,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'My Store',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  const Text(
                    'Valkommen',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  const VerticalSpace(
                    h: 10,
                  ),
                  SizedBox(
                    width: s.width * 0.7,
                    child: const Text(
                      'Hos ass kan du baka tid has nastan alla Sveriges salonger och motagningar. Baka frisor, massage, skonhetsbehandingar, friskvard och mycket mer.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
