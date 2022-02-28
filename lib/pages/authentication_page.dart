//
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_booking/data/models/auth/auth_model.dart';
import 'package:movie_booking/data/models/auth/auth_model_impl.dart';
import 'package:movie_booking/data/models/movie/movie_model.dart';
import 'package:movie_booking/data/models/movie/movie_model_impl.dart';
import 'package:movie_booking/data/vos/user_data_vo.dart';
import 'package:movie_booking/resources/color.dart';
import 'package:movie_booking/resources/dimension.dart';
import 'package:movie_booking/resources/string.dart';
import 'package:movie_booking/widgets/app_icon_text_button.dart';
import 'package:movie_booking/widgets/app_text_button.dart';
import 'package:movie_booking/widgets/sub_text.dart';
import 'package:movie_booking/widgets/title_text.dart';

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

  MovieModel movieModel = MovieModelImpl();
  AuthModel authModel = AuthModelImpl();
  String? message;
  UserDataVO? userData;
  String? token;
  int? code;
  String googleToken = "";
  String facebookToken = "";
  Map _userObj = {};

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
          top: MARGIN_XXXLARGE,
          left: MARGIN_MEDIUM_3,
          right: MARGIN_MEDIUM_3,
        ),
        child: Container(
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
                        if (loginFormKey.currentState!.validate()) {
                          authModel
                              .loginWithEmail(_phoneController.text.toString(),
                                  _emailController.text.toString())
                              .then((user) {
                            code = user[0];
                            message = user[1];
                            userData = user[2];
                            token = user[3];
                            print(" login user =========> $user");
                            _navigateToHomeScreen(
                              context,
                            );
                          }).catchError((error) {
                            debugPrint("error from network" + error.toString());
                          });
                        }
                      },
                      onTapGoogle: () {
                        GoogleSignIn _googleSignIn = GoogleSignIn(
                          scopes: [
                            'email',
                            'https://www.googleapis.com/auth/contacts.readonly',
                          ],
                        );
                        _googleSignIn.signIn().then((googleAccount) {
                          googleAccount?.authentication.then((authentication) {
                            authModel
                                .loginWithGoogle(
                                    authentication.accessToken ?? "")
                                .then((user) {
                              code = user[0];
                              message = user[1];
                              userData = user[2];
                              token = user[3];
                              print(" login google user =========> $user");
                              _navigateToHomeScreen(
                                context,
                              );
                            });
                            print(
                                "authentication accessToken ${authentication.accessToken}");
                          });
                        });
                      },
                      onTapFacebook: () {
                        FacebookAuth.instance.login(permissions: [
                          "public_profile",
                          "email"
                        ]).then((value) {
                          print(
                              "accessToken =======> ${value.accessToken?.token}");
                          authModel
                              .loginWithFacebook(
                                  value.accessToken?.userId ?? "")
                              .then((user) {
                            code = user[0];
                            message = user[1];
                            userData = user[2];
                            token = user[3];
                            print(" login facebook user =========> $user");
                            _navigateToHomeScreen(
                              context,
                            );
                          });
                        });
                      },
                    ),
                    AuthFormView(
                      signupFormKey,
                      _nameController,
                      _nameFocus,
                      _phoneController,
                      _phoneFocus,
                      _emailController,
                      _emailFocus,
                      _passwordController,
                      _passwordFocus,
                      true,
                      onTap: () {
                        if (signupFormKey.currentState!.validate()) {
                          print(
                              "info ====> \n name : ${_nameController.text} \n email : ${_phoneController.text} \n password : ${_emailController.text} \n phone : ${_passwordController.text} \n");
                          authModel
                              .registerWithEmail(
                                  _nameController.text.toString(),
                                  _phoneController.text.toString(),
                                  _passwordController.text.toString(),
                                  _emailController.text.toString(),
                                  googleToken,
                                  facebookToken)
                              .then((user) {
                            code = user[0];
                            message = user[1];
                            userData = user[2];
                            token = user[3];
                            print(" register user =========> $user");
                            _navigateToHomeScreen(
                              context,
                            );
                          }).catchError((error) {
                            debugPrint(error.toString());
                          });
                        }
                      },
                      onTapGoogle: () {
                        // google register
                        GoogleSignIn _googleSignIn = GoogleSignIn(
                          scopes: [
                            'email',
                            'https://www.googleapis.com/auth/contacts.readonly',
                          ],
                        );
                        _googleSignIn.signIn().then((googleAccount) {
                          googleAccount?.authentication.then((authentication) {
                            setState(() {
                              _nameController = TextEditingController(
                                text: googleAccount.displayName,
                              );
                              _phoneController = TextEditingController(
                                text: googleAccount.email,
                              );
                              googleToken = authentication.accessToken ?? "";
                              //  googleToken = googleAccount.id;
                            });
                            print(
                                "authentication id Token =======> ${googleAccount.id}");
                            print(
                                "authentication access Token =======> ${authentication.accessToken}");
                          });
                        });
                      },
                      onTapFacebook: () async {
                        //final LoginResult result =
                        //     await FacebookAuth.instance.login(
                        //   permissions: [
                        //     'public_profile',
                        //     'email',
                        //   ],
                        // );
                        // if (result.status == LoginStatus.success) {
                        //   final AccessToken accessToken = result.accessToken!;
                        //   print("accessToken =======> $accessToken");
                        // } else {
                        //   print("result status ===> ${result.status}");
                        //   print("result message ====> ${result.message}");
                        // }
                        FacebookAuth.instance.login(permissions: [
                          "public_profile",
                          "email"
                        ]).then((value) {
                          FacebookAuth.instance.getUserData().then((userData) {
                            setState(() {
                              _userObj = userData;
                              _nameController =
                                  TextEditingController(text: _userObj["name"]);
                              _phoneController = TextEditingController(
                                  text: _userObj["email"]);
                              // facebookToken = value.accessToken?.token ?? "";
                              facebookToken = value.accessToken?.userId ?? "";
                            });
                            print(
                                "facebook user obj =======> ${_userObj["name"]} ${_userObj["email"]}");
                            print(
                                "facebook user id =======> ${value.accessToken?.userId}");
                            print(
                                "facebook access token =======> ${value.accessToken?.token}");
                          });
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
    required this.onTap,
    required this.onTapGoogle,
    required this.onTapFacebook,
  });

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
              obsureText: true,
            ),
            const SizedBox(
              height: MARGIN_MEDIUM_4,
            ),
            SubText(
              FORGOR_PASSWORD_TEXT,
            ),
            const SizedBox(
              height: MARGIN_MEDIUM_4,
            ),
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
        GestureDetector(
          onTap: () => onTapFacebook(),
          child: AppIconTextButton(
            SIGNIN_WITH_FACEBOOK_BUTTON_TEXT,
            'assets/facebook.png',
            btnColor: Colors.transparent,
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_4,
        ),
        GestureDetector(
          onTap: () => onTapGoogle(),
          child: AppIconTextButton(
            SIGNIN_WITH_GOOGLE_BUTTON_TEXT,
            'assets/google.png',
            btnColor: Colors.transparent,
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_4,
        ),
        GestureDetector(
          onTap: () => onTap(),
          // onTap: () async {
          //   if (formKey.currentState!.validate()) {
          //     if (isSinup) {
          //       // register
          //       authModel
          //           .registerWithEmail(
          //               name.text.toString(),
          //               email.text.toString(),
          //               phone.text.toString(),
          //               password.text.toString())
          //           .then((user) {
          //         code = user[0];
          //         message = user[1];
          //         userData = user[2];
          //         token = user[3];
          //         if (code == 200) {
          //           _navigateToHomeScreen(
          //             context,
          //             userData!,
          //           );
          //         } else {
          //           Fluttertoast.showToast(
          //             msg: message ?? "Register Error",
          //             toastLength: Toast.LENGTH_LONG,
          //             gravity: ToastGravity.CENTER,
          //           );
          //         }
          //       }).catchError((error) {
          //         debugPrint(error.toString());
          //       });
          //     } else {
          //       await authModel
          //           .loginWithEmail(
          //               email.text.toString(), password.text.toString())
          //           .then((user) {
          //         code = user[0];
          //         message = user[1];
          //         userData = user[2];
          //         token = user[3];
          //         if (code == 200) {
          //           _navigateToHomeScreen(
          //             context,
          //             userData!,
          //           );
          //         } else {
          //           Fluttertoast.showToast(
          //             msg: message ?? "Login Error",
          //             toastLength: Toast.LENGTH_LONG,
          //             gravity: ToastGravity.CENTER,
          //           );
          //         }
          //       }).catchError((error) {
          //         debugPrint("error from network" + error.toString());
          //       });
          //     }
          //   }
          //},
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
  InputTextFormView(
    this._textController,
    this._textFocus,
    this._textInputType,
    this._labelText,
    this._errorText, {
    this.obsureText = false,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
