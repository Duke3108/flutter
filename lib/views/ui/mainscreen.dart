import 'package:duke_shoes_shop/controllers/mainscreen_provider.dart';
import 'package:duke_shoes_shop/views/shared/bottom_navbar.dart';
import 'package:duke_shoes_shop/views/ui/favoritepage.dart';
import 'package:duke_shoes_shop/views/ui/homepage.dart';
import 'package:duke_shoes_shop/views/ui/profile.dart';
import 'package:duke_shoes_shop/views/ui/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List<Widget> pageList = [
    HomePage(),
    SearchPage(),
    Favorites(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
        builder: (context, mainScreenNotifier, child) {
      return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: pageList[mainScreenNotifier.pageIndex],
        bottomNavigationBar: const BottomNavBarr(),
      );
    });
  }
}
