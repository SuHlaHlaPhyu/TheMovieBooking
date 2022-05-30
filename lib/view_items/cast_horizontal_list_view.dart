import 'package:flutter/material.dart';

import '../data/vos/actor_vo.dart';
import '../resources/dimension.dart';
import '../resources/string.dart';
import '../widgets/title_text.dart';
import 'cast_avatar_view.dart';

class CastHorizontalListView extends StatelessWidget {
  const CastHorizontalListView({
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
          height: HORIZONTAL_LISTVIEW_HEIGHT,
          child: ListView.builder(
            padding: const EdgeInsets.only(
              left: MARGIN_MEDIUM,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: castList?.length,
            itemBuilder: (context, index) {
              return CastAvatarView(castList![index]);
            },
          ),
        ),
      ],
    );
  }
}
