import 'package:flutter/material.dart';
import 'package:movie_booking/blocs/home_bloc.dart';
import 'package:movie_booking/configs/config_values.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';
import 'package:movie_booking/data/vos/user_data_vo.dart';
import 'package:movie_booking/listItems/menu_item.dart';
import 'package:movie_booking/view_items/coming_soon_tabbar_section_view.dart';
import 'package:movie_booking/view_items/now_showing_tabbar_section_view.dart';
import 'package:movie_booking/view_items/tabbar_section_view.dart';
import 'package:movie_booking/pages/welcome_page.dart';
import 'package:movie_booking/resources/color.dart';
import 'package:movie_booking/resources/dimension.dart';
import 'package:movie_booking/resources/string.dart';
import 'package:provider/provider.dart';

import '../configs/environment_config.dart';
import '../view_items/coming_soon_section_view.dart';
import '../view_items/drawer_view.dart';
import '../view_items/now_showing_section_view.dart';
import '../view_items/profile_view.dart';
import 'movie_detail_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<MenuItems> menuItem = [
    MenuItems(
      'Promotion Code',
      Icons.code,
    ),
    MenuItems(
      'Select a language',
      Icons.language_sharp,
    ),
    MenuItems(
      'Term of services',
      Icons.list,
    ),
    MenuItems(
      'Help',
      Icons.help,
    ),
    MenuItems(
      'Rate us',
      Icons.star_rate,
    ),
  ];

  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController?.addListener(_handleTabIndex);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.removeListener(_handleTabIndex);
    _tabController!.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: Selector<HomeBloc, UserDataVO?>(
        selector: (BuildContext context, bloc) => bloc.userData,
        builder: (BuildContext context, userData, Widget? child) {
          return Scaffold(
            backgroundColor: Colors.white,
            drawer: DrawerView(
              menuItem: menuItem,
              userDataVO: userData,
              onTap: () {
                HomeBloc bloc = Provider.of(context, listen: false);
                showLogoutConfirm(bloc);
              },
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              elevation: 0.0,
              actions: const [
                Padding(
                  padding: EdgeInsets.only(
                    right: MARGIN_MEDIUM_2,
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: MARGIN_XLARGE,
                  ),
                ),
              ],
            ),
            body: HOME_PAGE[EnvironmentConfig.CONFIG_HOME_PAGE] ==
                    "Horizontal list"
                ? MovieHorizontalListView(
                    tabController: _tabController,
                    userData: userData,
                  )
                : MovieTabBarView(
                    tabController: _tabController,
                    userData: userData,
                  ),
          );
        },
      ),
    );
  }

  void showLogoutConfirm(HomeBloc bloc) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Alert"),
          content: const Text("Are you sure to logout?"),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: PRIMARY_COLOR,
                ),
              ),
              onPressed: () {
                bloc.logout().then((value) {
                  _navigateToWelcomeScreen(context);
                });
              },
            ),
          ],
        );
      },
    );
  }
}

class MovieTabBarView extends StatelessWidget {
  TabController? tabController;
  UserDataVO? userData;
  MovieTabBarView({required this.tabController, required this.userData});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, value) {
        return [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: MARGIN_MEDIUM,
                  ),
                  child: ProfileView(
                    name: userData?.name ?? "",
                  ),
                ),
                const SizedBox(
                  height: MARGIN_MEDIUM_3,
                ),
                TabBarSectionView(
                  tabController: tabController,
                  tabBarOneName: "Now Showing",
                  tabBarTwoName: "Coming Soon",
                ),
              ],
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: tabController,
        children: [
          Selector<HomeBloc, List<MovieVO>?>(
            selector: (BuildContext context, bloc) => bloc.nowShowingMovies,
            builder: (BuildContext context, nowShowingMovies, Widget? child) {
              return Padding(
                padding: const EdgeInsets.only(top: MARGIN_LARGE),
                child: NowShowingTabBarSectionView(
                  NOW_SHOWING_MOVIE_LIST_TEXT,
                  movieList: nowShowingMovies,
                  onTapMovie: (movieId) => _navigateToMovieDetailsScreen(
                    context,
                    movieId,
                  ),
                ),
              );
            },
          ),
          Selector<HomeBloc, List<MovieVO>?>(
            selector: (BuildContext context, bloc) => bloc.comingSoonMovies,
            builder: (BuildContext context, comingSoonMovies, Widget? child) {
              return Padding(
                padding: const EdgeInsets.only(top: MARGIN_LARGE),
                child: ComingSoonTabBarSectionView(
                  COMING_SOON_MOVIE_LIST_TEXT,
                  movieList: comingSoonMovies,
                  onTapMovie: (movieId) => _navigateToMovieDetailsScreen(
                    context,
                    movieId,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MovieHorizontalListView extends StatelessWidget {
  UserDataVO? userData;
  TabController? tabController;
  MovieHorizontalListView(
      {required this.userData, required this.tabController});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileView(
              name: userData?.name ?? "",
            ),
            const SizedBox(
              height: MARGIN_MEDIUM_3,
            ),
            Selector<HomeBloc, List<MovieVO>?>(
              selector: (BuildContext context, bloc) => bloc.nowShowingMovies,
              builder: (BuildContext context, nowShowingMovies, Widget? child) {
                return NowShowingSectionView(
                  NOW_SHOWING_MOVIE_LIST_TEXT,
                  movieList: nowShowingMovies,
                  onTapMovie: (movieId) => _navigateToMovieDetailsScreen(
                    context,
                    movieId,
                  ),
                );
              },
            ),
            const SizedBox(
              height: MARGIN_XLARGE,
            ),
            Selector<HomeBloc, List<MovieVO>?>(
              selector: (BuildContext context, bloc) => bloc.comingSoonMovies,
              builder: (BuildContext context, comingSoonMovies, Widget? child) {
                return ComingSoonSectionView(
                  COMING_SOON_MOVIE_LIST_TEXT,
                  movieList: comingSoonMovies,
                  onTapMovie: (movieId) => _navigateToMovieDetailsScreen(
                    context,
                    movieId,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _navigateToMovieDetailsScreen(BuildContext context, int? id) {
  if (id != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailPage(
          movieId: id,
        ),
      ),
    );
  }
}

void _navigateToWelcomeScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => WelcomePage(),
    ),
  );
}
