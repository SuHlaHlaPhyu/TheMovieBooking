import 'package:flutter/material.dart';

import '../data/vos/actor_vo.dart';
import '../resources/dimension.dart';
import '../resources/string.dart';
import '../widgets/title_text.dart';
import 'cast_avatar_view.dart';
class CastView extends StatelessWidget {
  const CastView({
    Key? key,
    required this.castList,
  }) : super(key: key);

  final List<ActorVO>? castList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(CAST_BUTTON_TEXT),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Wrap(
          children: [
            ...castList
                ?.map(
                  (cast) => CastAvatarView(cast),
            )
                .toList() ?? [],
          ],
        ),
      ],
    );
  }
}