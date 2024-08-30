import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:shopyy/core/providers.dart';
import 'package:shopyy/views/product/widgets/product_card.dart';

class ProductView extends ConsumerWidget {
  const ProductView({super.key, this.categoryName = ''});

  final String categoryName;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productController = ref.watch(productControllerProvider);
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            productController.openedFromCategories.value
                ? categoryName
                : 'Products',
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
          ),
          leading: productController.openedFromCategories.value
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    productController.searchQuery.clear();
                    productController.searchedProducts.clear();
                    productController.searching(false);
                    productController.openedFromCategories(false);
                    Get.back();
                  },
                )
              : null,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: productController.searchQuery,
                onChanged: (v) {
                  if (v.isEmpty) {
                    productController.searching(false);
                    return;
                  }
                  productController.searching(true);
                  Logger().i(productController.openedFromCategories.value);
                  productController.searchProducts();
                },
                decoration: InputDecoration(
                    hintText: 'Search...',
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(12)),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 30,
                    ),
                    isDense: true),
              ),
            ),
            productController.fetchingProducts.value
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : productController.fetchingProducts.isFalse &&
                        productController.products.isEmpty &&
                        productController.searchQuery.text.isEmpty
                    ? const Center(
                        child: Text('No products to show...'),
                      )
                    : productController.productsOfACategory.isEmpty &&
                            productController.openedFromCategories.value
                        ? const Center(
                            child: Text('No products for this category...'),
                          )
                        : Expanded(
                            child: ListView.builder(
                            itemBuilder: (context, ind) {
                              final product = productController.searching.value
                                  ? productController.searchedProducts[ind]
                                  : productController.openedFromCategories.value
                                      ? productController
                                          .productsOfACategory[ind]
                                      : productController.products[ind];
                              return ProductCard(product: product);
                            },
                            itemCount: productController.searching.value
                                ? productController.searchedProducts.length
                                : productController.openedFromCategories.value
                                    ? productController
                                        .productsOfACategory.length
                                    : productController.products.length,
                          ))
          ],
        ),
      );
    });
  }
}
