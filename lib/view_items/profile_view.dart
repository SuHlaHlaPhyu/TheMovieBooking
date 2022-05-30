import 'package:flutter/material.dart';

import '../resources/dimension.dart';
import '../widgets/title_text.dart';

class ProfileView extends StatelessWidget {
  String name;
  ProfileView({required this.name});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: NetworkImage(
            'https://www.whatsappimages.in/wp-content/uploads/2021/02/Beautiful-Girls-Whatsapp-DP-Profile-Images-pics-for-download-300x300.gif',
          ),
        ),
        const SizedBox(
          width: MARGIN_MEDIUM_2,
        ),
        TitleText(
          "Hi $name",
          textSize: TEXT_HEADING_1X,
        ),
      ],
    );
  }
}