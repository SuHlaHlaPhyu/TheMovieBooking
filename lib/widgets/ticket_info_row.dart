import 'package:flutter/material.dart';
import 'package:movie_booking/widgets/ticket_Info_text.dart';

class TicketInfoRow extends StatelessWidget {
  final String text;
  final String subText;
  TicketInfoRow(
    this.text,
    this.subText,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TicketInfoText(
          text,
          color: Colors.grey,
        ),
        TicketInfoText(
          subText,
        ),
      ],
    );
  }
}
