import 'package:flutter/material.dart';
import 'package:movie_booking/data/models/auth/auth_model.dart';
import 'package:movie_booking/data/models/auth/auth_model_impl.dart';
import 'package:movie_booking/data/vos/user_data_vo.dart';
import 'package:movie_booking/pages/home_page.dart';
import 'package:movie_booking/resources/color.dart';
import 'package:movie_booking/resources/dimension.dart';
import 'package:movie_booking/resources/string.dart';
import 'package:movie_booking/widgets/app_text_button.dart';
import 'package:movie_booking/widgets/sub_text.dart';
import 'package:movie_booking/widgets/title_text.dart';

import '../data/vos/snack_vo.dart';
import 'authentication_page.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  AuthModel authModel = AuthModelImpl();
  String? message;
  UserDataVO? userData;
  String? token;
  @override
  void initState() {
    authModel.getUserTokenfromDatabase().then((value) {
      token = value;
      if (token != null || token == "") {
        authModel.getUserDatafromDatabase().then((user) {
          userData = user;
          print("userData database $userData");
          print("userData database ${userData?.userToken}");
        }).catchError((error) {
          debugPrint("error from db" + error.toString());
        });
      }
      print("usertoken database ====> $token");
    }).catchError((error) {
      debugPrint("error from db" + error.toString());
    });

    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM_2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: MARGIN_SUPER_LARGE,
            ),
            Container(
              height: WELCOME_SCREEN_LOGO_HEIGHT,
              width: WELCOME_SCREEN_LOGO_WIDTH,
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.cover,
              ),
            ),
            const Spacer(),
            TitleText(
              WELCOME_SCREEN_TITLE_TEXT,
              textColor: Colors.white,
            ),
            const SizedBox(
              height: MARGIN_MEDIUM_2,
            ),
            SubText(
              WELCOME_SCREEN_SUB_TEXT,
              textColor: Colors.white,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                if (userData == null) {
                  _navigateToAuthScreen(context);
                } else {
                  _navigateToHomeScreen(context);
                }
              },
              child: AppTextButton(
                WELCOME_SCREEN_BUTTON_TEXT,
                isBorder: true,
              ),
            ),
            const SizedBox(
              height: MARGIN_XLARGE,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToAuthScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthenticationPage(),
      ),
    );
  }

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }
}
