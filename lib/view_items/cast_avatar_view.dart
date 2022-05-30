import 'package:flutter/material.dart';

import '../data/vos/actor_vo.dart';
import '../network/api_constants.dart';
import '../resources/dimension.dart';
class CastAvatarView extends StatelessWidget {
  final ActorVO cast;
  CastAvatarView(this.cast);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        CircleAvatar(
          maxRadius: MARGIN_XLARGE,
          minRadius: MARGIN_XLARGE,
          backgroundImage: NetworkImage(
             "$IMAGE_BASE_URL${cast.profilePath}",
             // "https://1409791524.rsc.cdn77.org/data/images/full/606683/blackpink-jisoo-mesmerizes-fans-in-new-instagram-photos.jpeg?w=900"
          ),
        ),
        const SizedBox(
          width: MARGIN_MEDIUM,
        )
      ],
    );
  }
}