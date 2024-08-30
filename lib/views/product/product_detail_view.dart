import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopyy/core/providers.dart';
import 'package:shopyy/core/utils/fixed.dart';
import 'package:shopyy/models/product.dart';

class ProductDetailView extends ConsumerWidget {
  const ProductDetailView({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favController = ref.watch(favControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Image.network(
              product.thumbnail!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Product Details:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Obx(() {
                      bool isFavourite = favController.favourites
                          .where((e) => e.id == product.id)
                          .toList()
                          .isNotEmpty;
                      return IconButton(
                          onPressed: () {
                            favController.toggleFavourite(product: product);
                          },
                          icon: Icon(
                            isFavourite
                                ? Icons.favorite
                                : Icons.favorite_outline_rounded,
                            color: isFavourite
                                ? Colors.redAccent
                                : Colors.blueGrey,
                          ));
                    })
                  ],
                ),
                const VerticalSpace(
                  h: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Name:   ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      product.title ?? '',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                const VerticalSpace(
                  h: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Price:   ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${product.price ?? ''}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                const VerticalSpace(
                  h: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Category:   ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      product.category ?? '',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                const VerticalSpace(
                  h: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Brand:   ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      product.brand ?? '',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                const VerticalSpace(
                  h: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Rating:   ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${product.rating ?? ''} ',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                    ...List.generate(
                        product.rating!.round(),
                        (index) => const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                              size: 15,
                            ))
                  ],
                ),
                const VerticalSpace(
                  h: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Stock:   ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      product.stock.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                const VerticalSpace(
                  h: 5,
                ),
                const Text(
                  'Description:   ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  product.description ?? '',
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w400),
                ),
                const VerticalSpace(
                  h: 5,
                ),
                const Text(
                  'Product Gallery:   ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                product.images == null
                    ? const Center(
                        child: Text('No images in gallery for this product...'),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        itemCount: product.images?.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                // mainAxisExtent: 2,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                crossAxisCount: 2),
                        itemBuilder: (context, ind) {
                          return Image.network(
                            product.images![ind],
                            fit: BoxFit.cover,
                            height: 50,
                          );
                        })
              ],
            ),
          )
        ]),
      ),
    );
  }
}
