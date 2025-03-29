import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import '../../../controllers/payment_provider.dart';
import '../../shared/appstyle.dart';
import '../../shared/resusableText.dart';
import '../mainscreen.dart';

class Successful extends StatelessWidget {
  const Successful({super.key});

  @override
  Widget build(BuildContext context) {
    var paymentNotifier = Provider.of<PaymentNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            paymentNotifier.setPaymentUrl = '';
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainScreen()));
          },
          child: const Icon(
            AntDesign.closecircleo,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/Checkmark.png"),
            reusableText(
                text: "Payment Successful",
                style: appStyle(28, Colors.black, FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
