mixin ApiUrls {
  String productUrlWithLimit({int limit = 100}) =>
      'https://dummyjson.com/products?limit=$limit';
  String getCategoriesUrl = 'https://dummyjson.com/products/categories';
  String getCategorieProductsUrl(String category) =>
      'https://dummyjson.com/products/category/$category';
}
