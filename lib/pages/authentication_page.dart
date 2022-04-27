import 'package:flutter/material.dart';
import 'package:movie_booking/blocs/authentication_bloc.dart';
import 'package:movie_booking/data/vos/user_data_vo.dart';
import 'package:movie_booking/resources/color.dart';
import 'package:movie_booking/resources/dimension.dart';
import 'package:movie_booking/resources/string.dart';
import 'package:movie_booking/widgets/app_icon_text_button.dart';
import 'package:movie_booking/widgets/app_text_button.dart';
import 'package:movie_booking/widgets/sub_text.dart';
import 'package:movie_booking/widgets/title_text.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: "");
  final TextEditingController _passwordController =
      TextEditingController(text: "");
  TextEditingController _nameController = TextEditingController(text: "");
  TextEditingController _phoneController = TextEditingController(text: "");

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationBloc(),
      child: Selector<AuthenticationBloc, UserDataVO?>(
          selector: (BuildContext context, bloc) => bloc.userData,
          builder: (BuildContext context, value, Widget? child) {
            return Scaffold(
              key: const ValueKey("home"),
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.only(
                  top: MARGIN_XXXLARGE,
                  left: MARGIN_MEDIUM_3,
                  right: MARGIN_MEDIUM_3,
                ),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleText(
                            WELCOME_SCREEN_TITLE_TEXT,
                          ),
                          const SizedBox(
                            height: MARGIN_MEDIUM_2,
                          ),
                          SubText(
                            AUTH_SCREEN_WELCOME_SUB_TEXT,
                          ),
                          const SizedBox(
                            height: MARGIN_MEDIUM_4,
                          ),
                          Container(
                            height: MARGIN_XXLARGE,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TabBar(
                              indicatorColor: PRIMARY_COLOR,
                              controller: _tabController,
                              labelColor: PRIMARY_COLOR,
                              labelStyle: const TextStyle(
                                color: PRIMARY_COLOR,
                              ),
                              unselectedLabelColor: Colors.black,
                              tabs: [
                                Tab(
                                  child: SubText(
                                    LOGIN_TEXT,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Tab(
                                  child: SubText(
                                    SIGNIN_TEXT,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            AuthFormView(
                              loginFormKey,
                              _nameController,
                              _nameFocus,
                              _phoneController,
                              _phoneFocus,
                              _emailController,
                              _emailFocus,
                              _passwordController,
                              _passwordFocus,
                              false,
                              onTap: () {
                                ///
                                loginWithEmail(context);
                              },
                              onTapGoogle: () {
                                googleLogin(context);
                              },
                              onTapFacebook: () {
                                facebookLogin(context);
                              },
                            ),
                            Selector<AuthenticationBloc, String?>(
                                selector: (BuildContext context, bloc) =>
                                    bloc.name,
                                builder: (BuildContext context, name,
                                    Widget? child) {
                                  return Selector<AuthenticationBloc, String?>(
                                      selector: (BuildContext context, bloc) =>
                                          bloc.email,
                                      builder: (BuildContext context, email,
                                          Widget? child) {
                                        return AuthFormView(
                                          signupFormKey,
                                          _nameController =
                                              TextEditingController(
                                            text: name,
                                          ),
                                          _nameFocus,
                                          _phoneController =
                                              TextEditingController(
                                            text: email,
                                          ),
                                          _phoneFocus,
                                          _emailController,
                                          _emailFocus,
                                          _passwordController,
                                          _passwordFocus,
                                          true,
                                          onTap: () {
                                            accountRegister(context);
                                          },
                                          onTapGoogle: () {
                                            AuthenticationBloc bloc =
                                                Provider.of<AuthenticationBloc>(
                                                    context,
                                                    listen: false);
                                            bloc.googleSignIn();
                                          },
                                          onTapFacebook: () {
                                            AuthenticationBloc bloc =
                                                Provider.of<AuthenticationBloc>(
                                                    context,
                                                    listen: false);
                                            bloc.facebookSignIn();
                                          },
                                        );
                                      });
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  void loginWithEmail(BuildContext context) {
    AuthenticationBloc bloc =
        Provider.of<AuthenticationBloc>(context, listen: false);
    if (loginFormKey.currentState!.validate()) {
      bloc
          .onTapEmailLogin(_phoneController.text.toString(),
              _emailController.text.toString())
          .then(
            (value) => _navigateToHomeScreen(
              context,
            ),
          );
    }
  }

  void googleLogin(BuildContext context) {
    AuthenticationBloc bloc =
        Provider.of<AuthenticationBloc>(context, listen: false);
    bloc.googleLogin().then((value) {
      _navigateToHomeScreen(
        context,
      );
    });
  }

  void facebookLogin(BuildContext context) {
    AuthenticationBloc bloc =
        Provider.of<AuthenticationBloc>(context, listen: false);
    bloc.facebookLogin().then((value) {
      _navigateToHomeScreen(
        context,
      );
    });
  }

  void facebookSignIn() {
    AuthenticationBloc bloc =
        Provider.of<AuthenticationBloc>(context, listen: false);
    bloc.facebookSignIn();
  }

  void googleSignIn() {
    AuthenticationBloc bloc =
        Provider.of<AuthenticationBloc>(context, listen: false);
    bloc.googleSignIn();
  }

  void accountRegister(BuildContext context) {
    AuthenticationBloc bloc =
        Provider.of<AuthenticationBloc>(context, listen: false);
    if (signupFormKey.currentState!.validate()) {
      bloc
          .registerWithEmail(
              _nameController.text.toString(),
              _phoneController.text.toString(),
              _passwordController.text.toString(),
              _emailController.text.toString(),
              bloc.googleToken,
              bloc.facebookToken)
          .then((value) {
        _navigateToHomeScreen(
          context,
        );
      });
    }
  }
}

void _navigateToHomeScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => HomePage(),
    ),
  );
}

class AuthFormView extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController _nameController;
  final FocusNode _nameFocus;
  final TextEditingController _phoneController;
  final FocusNode _phoneFocus;
  final TextEditingController _emailController;
  final FocusNode _emailFocus;
  final TextEditingController _passwordController;
  final FocusNode _passwordFocus;
  final bool _isSignIn;
  Function onTap;
  Function onTapGoogle;
  Function onTapFacebook;

  AuthFormView(
    this.formKey,
    this._nameController,
    this._nameFocus,
    this._emailController,
    this._emailFocus,
    this._passwordController,
    this._passwordFocus,
    this._phoneController,
    this._phoneFocus,
    this._isSignIn, {
    Key? key,
    required this.onTap,
    required this.onTapGoogle,
    required this.onTapFacebook,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              height: MARGIN_MEDIUM_4,
            ),
            Visibility(
              visible: _isSignIn,
              child: InputTextFormView(
                _nameController,
                _nameFocus,
                TextInputType.text,
                NAME_CONTROLLER_LABEL_TEXT,
                NAME_CONTROLLER_ERROR_TEXT,
                const ValueKey('input.name'),
              ),
            ),
            const SizedBox(
              height: MARGIN_MEDIUM_4,
            ),
            Visibility(
              visible: _isSignIn,
              child: InputTextFormView(
                _phoneController,
                _phoneFocus,
                TextInputType.phone,
                PHONE_CONTROLLER_LABEL_TEXT,
                PHONE_CONTROLLER_ERROR_TEXT,
                const ValueKey('input.phone'),
              ),
            ),
            const SizedBox(
              height: MARGIN_MEDIUM_4,
            ),
            InputTextFormView(
              _emailController,
              _emailFocus,
              TextInputType.emailAddress,
              EMAIL_CONTROLLER_LABEL_TEXT,
              EMAIL_CONTROLLER_ERROR_TEXT,
              const ValueKey('input.email'),
            ),
            const SizedBox(
              height: MARGIN_MEDIUM_4,
            ),
            InputTextFormView(
              _passwordController,
              _passwordFocus,
              TextInputType.visiblePassword,
              PASSWORD_CONTROLLER_LABEL_TEXT,
              PASSWORD_CONTROLLER_ERROR_TEXT,
              const ValueKey('input.password'),
              obsureText: true,
            ),
            const SizedBox(
              height: MARGIN_MEDIUM_4,
            ),
            // SubText(
            //   FORGOR_PASSWORD_TEXT,
            // ),
            // const SizedBox(
            //   height: MARGIN_MEDIUM_4,
            // ),
            AuthButtonView(
              onTap: () => onTap(),
              onTapGoogle: () => onTapGoogle(),
              onTapFacebook: () => onTapFacebook(),
            ),
            const SizedBox(
              height: MARGIN_MEDIUM_4,
            ),
          ],
        ),
      ),
    );
  }
}

class AuthButtonView extends StatelessWidget {
  Function onTap;
  Function onTapGoogle;
  Function onTapFacebook;
  AuthButtonView({
    required this.onTap,
    required this.onTapGoogle,
    required this.onTapFacebook,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: false,
          child: GestureDetector(
            onTap: () => onTapFacebook(),
            child: AppIconTextButton(
              SIGNIN_WITH_FACEBOOK_BUTTON_TEXT,
              'assets/facebook.png',
              btnColor: Colors.transparent,
            ),
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_4,
        ),
        Visibility(
          visible: false,
          child: GestureDetector(
            onTap: () => onTapGoogle(),
            child: AppIconTextButton(
              SIGNIN_WITH_GOOGLE_BUTTON_TEXT,
              'assets/google.png',
              btnColor: Colors.transparent,
            ),
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_4,
        ),
        GestureDetector(
          key: const ValueKey("confirm"),
          onTap: () => onTap(),
          child: AppTextButton(
            CONFIRM_BUTTON_TEXT,
          ),
        ),
      ],
    );
  }
}

class InputTextFormView extends StatelessWidget {
  final TextEditingController _textController;
  final FocusNode _textFocus;
  final TextInputType _textInputType;
  final String _labelText;
  final String _errorText;
  final bool obsureText;
  final Key keyName;
  const InputTextFormView(
    this._textController,
    this._textFocus,
    this._textInputType,
    this._labelText,
    this._errorText,
    this.keyName, {
    Key? key,
    this.obsureText = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: keyName,
      controller: _textController,
      focusNode: _textFocus,
      keyboardType: _textInputType,
      obscureText: obsureText,
      cursorColor: PRIMARY_COLOR,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _textFocus.unfocus(),
      onFieldSubmitted: (_) => _textFocus.unfocus(),
      decoration: InputDecoration(
          labelText: _labelText,
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black12,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black12,
            ),
          )),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return _errorText;
        }
        return null;
      },
    );
  }
}

// print(
//   "info ====> \n name : ${_nameController.text} \n email : ${_phoneController.text} \n password : ${_emailController.text} \n phone : ${_passwordController.text} \n");
