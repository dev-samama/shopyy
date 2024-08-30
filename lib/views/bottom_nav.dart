import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopyy/views/category/category_view.dart';
import 'package:shopyy/views/favourite/favourite_view.dart';
import 'package:shopyy/views/product/product_view.dart';
import 'package:shopyy/views/profile/profile_view.dart';

class BaseController extends GetxController {}

class Base extends StatefulWidget {
  static const routeName = '/base';

  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const [
        ProductView(),
        CategoryView(),
        FavouriteView(),
        ProfileView()
      ][_currentTab],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black,
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.black87,
          useLegacyColorScheme: true,
          currentIndex: _currentTab,
          selectedItemColor: Colors.white,
          onTap: (i) {
            setState(() {
              _currentTab = i;
            });
          },
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset('lib/assets/icons/Product.png'),
                label: 'Products'),
            BottomNavigationBarItem(
                icon: Image.asset('lib/assets/icons/menu.png'),
                label: 'Categories'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favourites'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.account_box), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
