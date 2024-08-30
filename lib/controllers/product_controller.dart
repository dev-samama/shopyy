import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shopyy/models/category.dart';
import 'package:shopyy/models/product.dart';
import 'package:shopyy/services/product_service.dart';

class ProductsController extends GetxController {
  ProductsController({required ProductService productService})
      : _productService = productService;
  final ProductService _productService;
  final Logger _logger = Logger();
  RxBool fetchingProducts = false.obs;
  RxBool fetchingCategories = false.obs;
  RxList<Category> categories = <Category>[].obs;
  RxList<Product> products = <Product>[].obs;
  RxList<Product> productsOfACategory = <Product>[].obs;
  RxList<Product> searchedProducts = <Product>[].obs;
  RxBool searching = false.obs;
  TextEditingController searchQuery = TextEditingController();
  RxBool openedFromCategories = false.obs;
  // @override
  // void onInit() {
  //   super.onInit();e
  //   fetchCategories();
  //   fetchProducts();
  // }
  // @override
  // void onReady() {
  //   // TODO: implement onReady
  //   super.onReady();
  //   searchQuery.addListener(() {
  //     searchQuery.
  //   });
  // }

  void searchProducts() {
    if (openedFromCategories.value) {
      _logger.i('searching for category');
      searchedProducts.value = productsOfACategory
          .where((p0) => p0.title!
              .toLowerCase()
              .trim()
              .contains(searchQuery.text.toLowerCase()))
          .toList();
    } else {
      searchedProducts.value = products
          .where((p0) => p0.title!
              .toLowerCase()
              .trim()
              .contains(searchQuery.text.toLowerCase()))
          .toList();
    }
  }

  Future<void> fetchCategories() async {
    fetchingCategories(true);
    final result = await _productService.getCategories();
    result.fold(
      (exception) {
        _logger.e('Error loading categories: $exception');
      },
      (data) {
        categories.assignAll(data);
      },
    );
    fetchingCategories(false);
  }

  Future<void> fetchProducts(
      {int limit = 10, int skip = 0, String? category}) async {
    fetchingProducts(true);
    final result = await _productService.getProducts(
        limit: limit, skip: skip, category: category);
    result.fold(
      (exception) {
        _logger.e('Error loading products: $exception');
      },
      (data) {
        if (category == null) {
          products.assignAll(data);
        } else {
          productsOfACategory.assignAll(data);
        }
      },
    );
    fetchingProducts(false);
  }
}
