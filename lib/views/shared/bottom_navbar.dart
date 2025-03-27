import 'package:duke_shoes_shop/controllers/mainscreen_provider.dart';
import 'package:duke_shoes_shop/views/shared/bottomnavwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class BottomNavBarr extends StatelessWidget {
  const BottomNavBarr({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
        builder: (context, mainScreenNotifier, child) {
      return SafeArea(
          child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottomNavWidget(
                onTap: () {
                  mainScreenNotifier.pageIndex = 0;
                },
                icon: mainScreenNotifier.pageIndex == 0
                    ? MaterialCommunityIcons.home
                    : MaterialCommunityIcons.home_outline,
              ),
              BottomNavWidget(
                onTap: () {
                  mainScreenNotifier.pageIndex = 1;
                },
                icon: mainScreenNotifier.pageIndex == 1
                    ? Ionicons.search
                    : Ionicons.search,
              ),
              BottomNavWidget(
                onTap: () {
                  mainScreenNotifier.pageIndex = 2;
                },
                icon: mainScreenNotifier.pageIndex == 2
                    ? Ionicons.heart
                    : Ionicons.heart_circle_outline,
              ),
              BottomNavWidget(
                onTap: () {
                  mainScreenNotifier.pageIndex = 3;
                },
                icon: mainScreenNotifier.pageIndex == 3
                    ? Ionicons.person
                    : Ionicons.person_outline,
              ),
            ],
          ),
        ),
      ));
    });
  }
}
