import 'package:flutter/material.dart';
import 'package:movie_booking/data/models/auth/auth_model.dart';
import 'package:movie_booking/data/models/auth/auth_model_impl.dart';
import 'package:movie_booking/data/vos/user_card_vo.dart';
import 'package:movie_booking/resources/color.dart';
import 'package:movie_booking/resources/string.dart';
import 'package:movie_booking/widgets/app_text_button.dart';

import 'payment_info_page.dart';

class AddNewCardPage extends StatefulWidget {
  const AddNewCardPage({Key? key}) : super(key: key);

  @override
  _AddNewCardPageState createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _expDateController = TextEditingController();
  final TextEditingController _cardTypeController = TextEditingController();

  final FocusNode _cardNumFocus = FocusNode();
  final FocusNode _cardHolderFocus = FocusNode();
  final FocusNode _expDateFocus = FocusNode();
  final FocusNode _cardTypeFocus = FocusNode();
  AuthModel authModel = AuthModelImpl();
  List<UserCardVO>? cardList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              InputTextFormView(
                _cardNumController,
                _cardNumFocus,
                TextInputType.number,
                CARD_NUMBER_TEXT,
                CARD_NUMBER_ERROE_TEXT,
              ),
              const SizedBox(
                height: 15.0,
              ),
              InputTextFormView(
                _cardHolderController,
                _cardHolderFocus,
                TextInputType.text,
                CARD_HOLDER_TEXT,
                CARD_HOLDER_ERROE_TEXT,
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: InputTextFormView(
                      _expDateController,
                      _expDateFocus,
                      TextInputType.text,
                      EXPIRED_DATE_TEXT,
                      EXPIRED_DATE_ERROE_TEXT,
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: InputTextFormView(
                      _cardTypeController,
                      _cardTypeFocus,
                      TextInputType.number,
                      CARD_TYPE_TEXT,
                      CARD_TYPE_ERROE_TEXT,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          left: 30.0,
        ),
        child: InkWell(
          onTap: () {
            if (formKey.currentState!.validate()) {
              int cardNum = int.parse(_cardNumController.text.toString());
              String cardHolder = _cardHolderController.text.toString();
              String expDate = _expDateController.text.toString();
              int cardType = int.parse(_cardTypeController.text.toString());
              authModel.getUserTokenfromDatabase().then((value) {
                authModel
                    .createCard("Bearer " + value, cardNum, cardHolder, expDate,
                        cardType)
                    .then((value) {
                  Navigator.pop(context);
                  //_navigateToAddPaymentPage(context);
                  // Navigator.pop(context);
                });
              });
            }
          },
          child: AppTextButton(
            "Confrim",
          ),
        ),
      ),
    );
  }
}

// void _navigateToAddPaymentPage(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => PaymentInfoPage(),
//     ),
//   );
// }

class InputTextFormView extends StatelessWidget {
  final TextEditingController _textController;
  final FocusNode _textFocus;
  final TextInputType _textInputType;
  final String _labelText;
  final String _errorText;
  final bool obsureText;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
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
      expands: false,
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
