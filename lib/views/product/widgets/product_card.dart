import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopyy/core/utils/fixed.dart';
import 'package:shopyy/models/product.dart';
import 'package:shopyy/views/product/product_detail_view.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: InkWell(
        onTap: () {
          Get.to(() => ProductDetailView(
                product: product,
              ));
        },
        child: Card(
          surfaceTintColor: Colors.black,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.network(
                  product.thumbnail!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                title: Text(product.title ?? ""),
                trailing: Text(
                  '\$${product.price}',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(
                        product.rating.toString(),
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      ...List.generate(
                          product.rating!.round(),
                          (index) => const Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                                size: 15,
                              ))
                    ]),
                    Text(
                      'by ${product.brand}',
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          color: Colors.black54),
                    ),
                    Text(
                      'In ${product.category}',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const VerticalSpace(
                h: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
