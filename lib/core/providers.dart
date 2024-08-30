import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopyy/controllers/favourite_controller.dart';
import 'package:shopyy/controllers/product_controller.dart';
import 'package:shopyy/services/product_service.dart';

final productServiceProvider =
    Provider<ProductService>((ref) => ProductService());
final productControllerProvider = Provider<ProductsController>((ref) =>
    ProductsController(productService: ref.read(productServiceProvider)));
final favControllerProvider =
    Provider<FavouriteController>((ref) => FavouriteController());
