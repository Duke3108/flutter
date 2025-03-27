import 'package:duke_shoes_shop/controllers/login_provider.dart';
import 'package:duke_shoes_shop/services/authhelper.dart';
import 'package:duke_shoes_shop/views/shared/appstyle.dart';
import 'package:duke_shoes_shop/views/shared/resusableText.dart';
import 'package:duke_shoes_shop/views/shared/tile_widget.dart';
import 'package:duke_shoes_shop/views/ui/auth/login.dart';
import 'package:duke_shoes_shop/views/ui/cartpage.dart';
import 'package:duke_shoes_shop/views/ui/favoritepage.dart';
import 'package:duke_shoes_shop/views/ui/nonuser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context);
    return authNotifier.loggeIn == false
        ? NonUser()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFFE2E2E2),
              elevation: 0,
              leading: Icon(
                MaterialCommunityIcons.qrcode_scan,
                size: 18,
                color: Colors.black,
              ),
              actions: [
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/vietnam.svg',
                          width: 15.w,
                          height: 25,
                        ),
                        SizedBox(width: 5.w),
                        Container(
                          height: 15.h,
                          width: 1.w,
                          color: Colors.grey,
                        ),
                        reusableText(
                            text: " Vietnam",
                            style:
                                appStyle(16, Colors.black, FontWeight.normal)),
                        SizedBox(width: 10.w),
                        Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Icon(
                            SimpleLineIcons.settings,
                            color: Colors.black,
                            size: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 60.h,
                    decoration: BoxDecoration(color: Color(0xFFE2E2E2)),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 10, 16, 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 35.h,
                                    width: 35.w,
                                    child: CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/images/avt.jpeg'),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  FutureBuilder(
                                      future: AuthHelper().getProfile(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Center(
                                            child: reusableText(
                                                text: "Không thể lấy dữ liệu",
                                                style: appStyle(
                                                    18,
                                                    Colors.black,
                                                    FontWeight.w600)),
                                          );
                                        } else {
                                          final userData = snapshot.data;
                                          return SizedBox(
                                            height: 35.h,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                reusableText(
                                                    text: userData?.username ??
                                                        "",
                                                    style: appStyle(
                                                        12,
                                                        Colors.black,
                                                        FontWeight.normal)),
                                                reusableText(
                                                    text: userData?.email ?? "",
                                                    style: appStyle(
                                                        12,
                                                        Colors.black,
                                                        FontWeight.normal)),
                                              ],
                                            ),
                                          );
                                        }
                                      }),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Feather.edit,
                                      size: 18,
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 10.h),
                      Container(
                        height: 160.h,
                        color: Colors.grey.shade200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TilesWidget(
                                OnTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                                title: "Đơn hàng",
                                leading:
                                    MaterialCommunityIcons.truck_fast_outline),
                            TilesWidget(
                                OnTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Favorites()));
                                },
                                title: "Yêu thích",
                                leading: MaterialCommunityIcons.heart_outline),
                            TilesWidget(
                                OnTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CartPage()));
                                },
                                title: "Giỏ hàng",
                                leading: Fontisto.shopping_bag_1),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 110.h,
                        color: Colors.grey.shade200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TilesWidget(
                                OnTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Favorites()));
                                },
                                title: "Khuyến mãi",
                                leading: MaterialCommunityIcons.tag_outline),
                            TilesWidget(
                                OnTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Favorites()));
                                },
                                title: "Cửa hàng",
                                leading:
                                    MaterialCommunityIcons.shopping_outline),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 160.h,
                        color: Colors.grey.shade200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TilesWidget(
                                OnTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Favorites()));
                                },
                                title: "Địa chỉ",
                                leading: SimpleLineIcons.location_pin),
                            TilesWidget(
                                OnTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Favorites()));
                                },
                                title: "Cài đặt",
                                leading: AntDesign.setting),
                            TilesWidget(
                                OnTap: () {
                                  authNotifier.logout();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                                title: "Đăng xuất",
                                leading: AntDesign.logout),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
