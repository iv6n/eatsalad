//BottomNavigationBar with tabs
import 'package:eatsalad/home/tabs/tabs.dart';
import 'package:eatsalad/theme.dart';
import 'package:flutter/material.dart';

var currentTab = [
  const Home(
    key: PageStorageKey('pag0'),
  ),
  const Locations(
    key: PageStorageKey('Page1'),
  ),
  const CatalogPage(
    key: PageStorageKey('Page2'),
  ),
  const CartPage(
    key: PageStorageKey('Page3'),
  ),
  const Profile(
    key: PageStorageKey('Page4'),
  ),
];

///ISA BottomNavigationBar
class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.provider,
    required this.scaffoldkey,
  });

  final BottomNavigationBarProvider provider;
  final GlobalKey<ScaffoldState> scaffoldkey;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme,
      child: BottomNavigationBar(
        showSelectedLabels: false,
        iconSize: 30.0,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        type: BottomNavigationBarType.fixed,
        currentIndex: provider.currentIndex,
        onTap: (index) {
          index == 4
              ? scaffoldkey.currentState?.openEndDrawer()
              : provider.currentIndex = index;
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "map"),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "menu"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: "cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
        ],
      ),
    );
  }
}

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 2;
  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
