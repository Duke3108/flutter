import 'package:duke_shoes_shop/views/shared/appstyle.dart';
import 'package:duke_shoes_shop/views/shared/resusableText.dart';
import 'package:duke_shoes_shop/views/ui/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class NonUser extends StatelessWidget {
  const NonUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      style: appStyle(16, Colors.black, FontWeight.normal)),
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
              height: 750.h,
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
                            reusableText(
                                text: "Vui lòng đăng nhập Tài khoản của bạn",
                                style: appStyle(12, Colors.grey.shade600,
                                    FontWeight.normal)),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 5),
                            width: 70.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Center(
                              child: reusableText(
                                  text: "Đăng nhập",
                                  style: appStyle(
                                      12, Colors.white, FontWeight.normal)),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
