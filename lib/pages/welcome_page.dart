import 'package:flutter/material.dart';
import 'package:movie_booking/blocs/welcome_bloc.dart';
import 'package:movie_booking/configs/environment_config.dart';
import 'package:movie_booking/data/vos/user_data_vo.dart';
import 'package:movie_booking/pages/home_page.dart';
import 'package:movie_booking/resources/color.dart';
import 'package:movie_booking/resources/dimension.dart';
import 'package:movie_booking/resources/string.dart';
import 'package:movie_booking/widgets/app_text_button.dart';
import 'package:movie_booking/widgets/sub_text.dart';
import 'package:movie_booking/widgets/title_text.dart';
import 'package:provider/provider.dart';

import '../configs/config_values.dart';
import 'authentication_page.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WelcomeBloc(),
      child: Scaffold(
        backgroundColor: THEME_COLOR[EnvironmentConfig.CONFIG_THEME_COLOR],
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
                "Welcome to ${APP_TITLE[EnvironmentConfig.CONFIG_APP_TITLE]} App.",
                textColor: Colors.white,
              ),
              const Spacer(),
              Selector<WelcomeBloc, UserDataVO?>(
                  selector: (BuildContext context, bloc) => bloc.userData,
                  builder: (BuildContext context, userData, Widget? child) {
                    return GestureDetector(
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
                        btnColor: THEME_COLOR[EnvironmentConfig.CONFIG_THEME_COLOR],
                      ),
                    );
                  }),
              const SizedBox(
                height: MARGIN_XLARGE,
              ),
            ],
          ),
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
