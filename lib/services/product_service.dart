import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shopyy/core/extensions/string_ext.dart';
import 'package:shopyy/core/mixins/api_urls.dart';
import 'package:shopyy/models/category.dart';
import 'package:shopyy/models/product.dart';

class ProductService with ApiUrls {
  final String baseUrl = 'https://dummyjson.com';
  final Logger _logger = Logger();

  Future<Either<Exception, List<Category>>> getCategories() async {
    try {
      final response = await http.get(getCategoriesUrl.toUri());

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final List<Category> categories =
            jsonList.map((json) => Category.fromJson(json)).toList();
        _logger.i('Categories Returned: ${categories[0].name}');
        return Right(categories);
      } else {
        return Left(Exception('Failed to load categories'));
      }
    } catch (e) {
      _logger.e('Error fetching categories: $e');
      return Left(Exception('Error fetching categories'));
    }
  }

  Future<Either<Exception, List<Product>>> getProducts(
      {int limit = 10, int skip = 0, String? category}) async {
    try {
      final response = await http.get(category != null
          ? getCategorieProductsUrl(category).toUri()
          : productUrlWithLimit().toUri());

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = json.decode(response.body);
        final List<dynamic> jsonList = jsonMap['products'];
        final List<Product> products =
            jsonList.map((json) => Product.fromJson(json)).toList();
        _logger.i('Products Returned: ${products.length}');
        return Right(products);
      } else {
        return Left(Exception('Failed to load products'));
      }
    } catch (e) {
      _logger.e('Error fetching products: $e');
      return Left(Exception('Error fetching products'));
    }
  }
}
