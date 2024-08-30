import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopyy/core/providers.dart';
import 'package:shopyy/core/utils/fixed.dart';
import 'package:shopyy/models/product.dart';
import 'package:shopyy/views/product/product_detail_view.dart';

class FavouriteView extends ConsumerWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favController = ref.watch(favControllerProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Favourites',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
          ),
        ),
        body: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: favController.searchQuery,
                  onChanged: (v) {
                    if (v.isEmpty) {
                      favController.isSearching(false);
                      favController.searchedFavourites.clear();
                      return;
                    }
                    favController.searchAndUpdate();
                    favController.isSearching(true);
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
                          borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 30,
                      ),
                      isDense: true),
                ),
              ),
              if (favController.isSearching.value)
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                      '${favController.searchedFavourites.length} Results'),
                ),
              !favController.isSearching.value &&
                      favController.favourites.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('No favourites added...'),
                      ),
                    )
                  : favController.isSearching.value &&
                          favController.searchedFavourites.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                                'No favourites found for ${favController.searchQuery.text}...'),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                          itemBuilder: (context, ind) {
                            final Product product =
                                favController.isSearching.value
                                    ? favController.searchedFavourites[ind]
                                    : favController.favourites[ind];
                            bool isFavourite = favController.favourites
                                .where((e) => e.id == product.id)
                                .toList()
                                .isNotEmpty;
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 5),
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
                                      ListTile(
                                        leading: ClipOval(
                                          child: Image.network(
                                            product.thumbnail!,
                                            // height: 100,
                                            width: 60,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        title: Text(product.title!),
                                        trailing: IconButton(
                                            onPressed: () {
                                              favController.toggleFavourite(
                                                  product: product);
                                            },
                                            icon: Icon(
                                              isFavourite
                                                  ? Icons.favorite
                                                  : Icons
                                                      .favorite_outline_rounded,
                                              color: isFavourite
                                                  ? Colors.redAccent
                                                  : Colors.blueGrey,
                                            )),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '\$${product.price}',
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                            Row(children: [
                                              Text(
                                                product.rating.toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                              ),
                                              ...List.generate(
                                                  product.rating!.round(),
                                                  (index) => const Icon(
                                                        Icons.star_rounded,
                                                        color: Colors.amber,
                                                        size: 13,
                                                      ))
                                            ]),
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
                          },
                          itemCount: favController.searchQuery.text.isNotEmpty
                              ? favController.searchedFavourites.length
                              : favController.favourites.length,
                        ))
            ],
          );
        }));
  }
}
