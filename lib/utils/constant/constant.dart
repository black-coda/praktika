import 'package:flutter/material.dart';

class Constant {
  static const String profileTable = 'profiles';
  static const String videoTable = 'videos';
  static const String reviewTable = "reviews";
  static const String favoriteTable = "my_learning";

  // google url
  static const String googleUrl = "https://www.google.com";
  static const scaffoldPadding =
      EdgeInsets.symmetric(vertical: 32, horizontal: 16);

  static const lottieAnimationUrl = "assets/lottie/no_internet.json";

  static const defaultProfileImage =
      "https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671116.jpg?w=826&t=st=1717727695~exp=1717728295~hmac=ec1f2b2f76d8254081ea5a1a2bda88801ec3a11cef9f6282030b5ed61c983c19";

  static Color generateColor(int index) {
    return (index % 3 == 0)
        ? const Color(0xffEC704B)
        : (index % 3 == 1)
            ? const Color(0xffF5F378)
            : const Color(0xffDCC1FF);
  }

  static TextStyle appBarTitleStyle(context, {Color? color}) =>
      Theme.of(context).textTheme.headlineSmall!.copyWith(
          color: color ?? const Color(0xffDCC1FF),
          fontSize: 20,
          fontWeight: FontWeight.w400);

  static TextStyle underlineStyle(context, {Color? color}) => TextStyle(
        decoration: TextDecoration.underline,
        decorationStyle: TextDecorationStyle.solid,
        decorationColor: const Color(0xff6C6C6C),
        color: color ?? const Color(0xff6C6C6C),
      );

  static const backgroundColorDark = Color(0xff1A1A1A);
  static const backgroundColorPurple = Color(0xffDCC1FF);
  static const backgroundColorYellow = Color(0xffF1EF76);
  static const backgroundColorOrange = Color(0xffEC704B);
  static const backgroundColorGrey = Color(0xff2F2F2F);
}

class SpacerConstant {
  static const sizedBox4 = SizedBox(height: 4);
  static const sizedBox8 = SizedBox(height: 8);
  static const sizedBox12 = SizedBox(height: 12);
  static const sizedBox16 = SizedBox(height: 16);
  static const sizedBox20 = SizedBox(height: 20);
  static const sizedBox24 = SizedBox(height: 24);
  static const sizedBox32 = SizedBox(height: 32);
  static const sizedBox40 = SizedBox(height: 40);
  static const sizedBox48 = SizedBox(height: 48);
  static const sizedBox56 = SizedBox(height: 56);
  static const sizedBox64 = SizedBox(height: 64);
}
