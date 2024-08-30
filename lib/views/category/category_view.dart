import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopyy/core/providers.dart';
import 'package:shopyy/views/product/product_view.dart';

class CategoryView extends ConsumerWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productController = ref.watch(productControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Category',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${productController.categories.length} categories found."),
            Expanded(
              child: GridView.builder(
                  itemCount: productController.categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      crossAxisCount: 2),
                  itemBuilder: (context, ind) {
                    return InkWell(
                      onTap: () {
                        productController.fetchProducts(
                            category:
                                productController.categories[ind].name.trim());
                        productController.openedFromCategories(true);
                        Get.to(() => ProductView(
                              categoryName:
                                  productController.categories[ind].name.trim(),
                            ));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                'https://images.pexels.com/photos/2536965/pexels-photo-2536965.jpeg',
                                fit: BoxFit.cover,
                                height: double.infinity,
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.black87,
                                  ])),
                            ),
                            Positioned(
                                bottom: 10,
                                left: 10,
                                child: SizedBox(
                                  width: 150,
                                  child: Text(
                                    productController.categories[ind].name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
