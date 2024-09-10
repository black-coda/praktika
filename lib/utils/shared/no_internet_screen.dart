import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/utils/constant/constant.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            LottieBuilder.asset(Constant.lottieAnimationUrl),
            const Text(
              'No Internet Connection, Make sure Wi-Fi or mobile data is turned on',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
