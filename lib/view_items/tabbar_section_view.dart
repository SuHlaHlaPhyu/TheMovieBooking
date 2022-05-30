import 'package:flutter/material.dart';
import 'package:movie_booking/resources/color.dart';

class TabBarSectionView extends StatelessWidget {

  final TabController? tabController;
  final String tabBarOneName;
  final String tabBarTwoName;
  TabBarSectionView({
    required this.tabController,
    required this.tabBarOneName,
    required this.tabBarTwoName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: THE_MOVIE_PRIMARY_COLOR,
        controller: tabController,
        labelColor: THE_MOVIE_PRIMARY_COLOR,
        labelStyle: const TextStyle(
          color: THE_MOVIE_PRIMARY_COLOR,
        ),
        unselectedLabelColor: Colors.black,
        tabs: [
          Tab(
            child: Text(
              tabBarOneName,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
              key: const ValueKey("yourbooks"),
            ),
          ),
          Tab(
            child: Text(
              tabBarTwoName,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
              key: const ValueKey("shelves"),
            ),
          ),
        ],
      ),
    );
  }
}
