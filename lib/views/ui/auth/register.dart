import 'package:duke_shoes_shop/models/auth/signup_model.dart';
import 'package:duke_shoes_shop/views/shared/appstyle.dart';
import 'package:duke_shoes_shop/views/shared/resusableText.dart';
import 'package:duke_shoes_shop/views/ui/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

import '../../../controllers/login_provider.dart';
import '../../shared/custom_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  bool validation = false;

  void formValidation() {
    if (email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        username.text.isNotEmpty) {
      validation = true;
    } else {
      validation = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50.h,
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              AntDesign.left,
              color: Colors.white,
            )),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
            image: DecorationImage(
                opacity: 0.5,
                image: AssetImage('assets/images/black_bg.png'),
                fit: BoxFit.fill)),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            reusableText(
                text: "Xin chào!",
                style: appStyle(30, Colors.white, FontWeight.w600)),
            reusableText(
                text: "Điền thông tin chi tiết để đăng ký tài khoản mới",
                style: appStyle(14, Colors.white, FontWeight.normal)),
            SizedBox(height: 50.h),
            CustomTextField(
              controller: username,
              hintText: "Username",
              validator: (username) {
                if (username!.isEmpty) {
                  return 'Tên người dùng không được để trống';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              keyboard: TextInputType.emailAddress,
              controller: email,
              hintText: "Email",
              validator: (email) {
                if (email!.isEmpty && !email.contains("@")) {
                  return 'Email không hợp lệ';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              controller: password,
              hintText: "Password",
              obscureText: authNotifier.isObsecure,
              suffixIcon: GestureDetector(
                onTap: () {
                  authNotifier.isObsecure = !authNotifier.isObsecure;
                },
                child: authNotifier.isObsecure
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              ),
              validator: (password) {
                if (password!.isEmpty && password.length < 8) {
                  return 'Mật khẩu yếu';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: reusableText(
                    text: "Đăng nhập",
                    style: appStyle(14, Colors.white, FontWeight.normal)),
              ),
            ),
            SizedBox(height: 40.h),
            GestureDetector(
              onTap: () {
                formValidation();
                if (validation) {
                  SignupModel model = SignupModel(
                      username: username.text,
                      email: email.text,
                      password: password.text);
                  authNotifier.registerUser(model).then((response) {
                    if (response == true) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    } else {
                      debugPrint('Failed sign up');
                    }
                  });
                } else {
                  debugPrint('form not valid');
                }
              },
              child: Container(
                height: 55.h,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Center(
                  child: reusableText(
                      text: "ĐĂNG KÝ",
                      style: appStyle(18, Colors.black, FontWeight.bold)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
