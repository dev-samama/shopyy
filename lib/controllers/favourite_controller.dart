import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shopyy/models/product.dart';

class FavouriteController extends GetxController {
  RxList<Product> favourites = RxList.empty();
  RxList<Product> searchedFavourites = RxList.empty();

  TextEditingController searchQuery = TextEditingController();
  RxBool isSearching = false.obs;
  void searchAndUpdate() {
    searchedFavourites.value = favourites
        .where((p0) => p0.title!
            .trim()
            .toLowerCase()
            .contains(searchQuery.text.toLowerCase().trim()))
        .toList();
  }

  void clearSearch() {
    searchedFavourites.clear();
  }

  void toggleFavourite({required Product product}) {
    if (favourites
        .where((element) => element.id == product.id)
        .toList()
        .isEmpty) {
      favourites.add(product);
    } else {
      favourites.removeWhere((e) => e.id == product.id);
    }
  }

  void removeFromFavourite({required int productid}) {}
}
