
import 'package:flutter/material.dart';
import 'package:movie_booking/configs/config_values.dart';
import 'package:movie_booking/configs/environment_config.dart';

import '../data/vos/user_data_vo.dart';
import '../listItems/menu_item.dart';
import '../resources/color.dart';
import '../resources/dimension.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({
    Key? key,
    required this.menuItem,
    required this.userDataVO,
    required this.onTap,
  }) : super(key: key);

  final List<MenuItems> menuItem;
  final UserDataVO? userDataVO;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: Container(
          color: THEME_COLOR[EnvironmentConfig.CONFIG_THEME_COLOR],
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 96.0,
              ),
              DrawerHeaderSectionView(
                userDataVo: userDataVO,
              ),
              const SizedBox(
                height: MARGIN_XXLARGE,
              ),
              Column(
                children: menuItem
                    .map(
                      (menu) => Container(
                    margin: const EdgeInsets.only(
                      top: MARGIN_MEDIUM_2,
                    ),
                    child: ListTile(
                      leading: Icon(
                        menu.icon,
                        color: Colors.white,
                        size: MARGIN_MEDIUM_4,
                      ),
                      title: Text(
                        menu.text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: TEXT_REGULAR_2X,
                        ),
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  onTap();
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: MARGIN_MEDIUM_4,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: TEXT_REGULAR_2X,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: MARGIN_XLARGE,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class DrawerHeaderSectionView extends StatelessWidget {
  final UserDataVO? userDataVo;
  const DrawerHeaderSectionView({Key? key, required this.userDataVo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56.0,
          height: 56.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                'https://www.whatsappimages.in/wp-content/uploads/2021/02/Beautiful-Girls-Whatsapp-DP-Profile-Images-pics-for-download-300x300.gif',
              ),
            ),
          ),
        ),
        const SizedBox(
          width: MARGIN_MEDIUM_2,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userDataVo?.name ?? " ",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR_2X,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: MARGIN_MEDIUM,
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      userDataVo?.email ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: MARGIN_LARGE,
                  ),
                  const Text(
                    'Edit',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}