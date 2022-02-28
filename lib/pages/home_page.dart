import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_booking/data/models/auth/auth_model.dart';
import 'package:movie_booking/data/models/auth/auth_model_impl.dart';
import 'package:movie_booking/data/models/movie/movie_model.dart';
import 'package:movie_booking/data/models/movie/movie_model_impl.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';
import 'package:movie_booking/data/vos/user_data_vo.dart';
import 'package:movie_booking/listItems/menu_item.dart';
import 'package:movie_booking/network/api_constants.dart';
import 'package:movie_booking/pages/welcome_page.dart';
import 'package:movie_booking/resources/color.dart';
import 'package:movie_booking/resources/dimension.dart';
import 'package:movie_booking/resources/string.dart';
import 'package:movie_booking/widgets/sub_text.dart';
import 'package:movie_booking/widgets/title_text.dart';

import '../data/vos/snack_vo.dart';
import 'movie_detail_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MovieModel movieModel = MovieModelImpl();
  AuthModel authModel = AuthModelImpl();
  List<MovieVO>? nowShowingMovies;
  List<MovieVO>? comingSoonMovies;
  List<SnackVO> snackList = [];

  UserDataVO? userData;
  String? token;

  final googleSignIn = GoogleSignIn();

  @override
  void initState() {
    /// get now playing movie
    authModel.getUserTokenfromDatabase().then((value) {
      token = value;
      if (token != null || token == "") {
        authModel.getUserDatafromDatabase().then((user) {
          userData = user;
          print("${userData?.userToken}");
        }).catchError((error) {
          debugPrint(error.toString());
        });
      }
      print("$token");
    }).catchError((error) {
      debugPrint("error from db" + error.toString());
    });

    authModel.getUserTokenfromDatabase().then((value) {
      authModel.getSnackList("Bearer " + value).then((value) {
        setState(() {
          snackList = value ?? [];
        });
      }).catchError((error) {
        debugPrint(error.toString());
      });
    });
    // movieModel.getNowPlayingMovies(1).then((movieList) {
    //   setState(() {
    //     nowShowingMovies = movieList;
    //   });
    // }).catchError((error) {
    //   debugPrint(error.toString());
    // });

    /// get now playing movie from db
    movieModel.getNowPlayingMoviesFromDatabase(1).listen((movieList) {
      setState(() {
        nowShowingMovies = movieList;
      });
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// get coming soon movie
    // movieModel.getComingSoonMovies(1).then((movieList) {
    //   setState(() {
    //     comingSoonMovies = movieList;
    //   });
    // }).catchError((error) {
    //   debugPrint(error.toString());
    // });

    /// get coming soon movie from db
    movieModel.getComingSoonMoviesFromDatabase(1).listen((movieList) {
      setState(() {
        comingSoonMovies = movieList;
      });
    }).onError((error) {
      debugPrint(error.toString());
    });
    super.initState();
  }

  final List<MenuItem> menuItem = [
    MenuItem(
      'Promotion Code',
      Icons.code,
    ),
    MenuItem(
      'Select a language',
      Icons.language_sharp,
    ),
    MenuItem(
      'Term of services',
      Icons.list,
    ),
    MenuItem(
      'Help',
      Icons.help,
    ),
    MenuItem(
      'Rate us',
      Icons.star_rate,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerView(
        menuItem: menuItem,
        userDataVO: userData,
        onTap: () {
          // await googleSignIn.disconnect();
          showLogoutConfirm();
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
      body: Padding(
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
              NowShowingSectionView(
                COMING_SOON_MOVIE_LIST_TEXT,
                movieList: nowShowingMovies,
                onTapMovie: (movieId) => _navigateToMovieDetailsScreen(
                  context,
                  movieId,
                ),
              ),
              const SizedBox(
                height: MARGIN_XLARGE,
              ),
              ComingSoonSectionView(
                COMING_SOON_MOVIE_LIST_TEXT,
                movieList: comingSoonMovies,
                onTapMovie: (movieId) => _navigateToMovieDetailsScreen(
                  context,
                  movieId,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLogoutConfirm() {
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
                authModel.getUserTokenfromDatabase().then((value) {
                  authModel.logout("Bearer " + value).then((value) {
                    _navigateToWelcomeScreen(context);
                  });
                });
              },
            ),
          ],
        );
      },
    );
  }
}

class DrawerView extends StatelessWidget {
  const DrawerView({
    Key? key,
    required this.menuItem,
    required this.userDataVO,
    required this.onTap,
  }) : super(key: key);

  final List<MenuItem> menuItem;
  final UserDataVO? userDataVO;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: Container(
          color: PRIMARY_COLOR,
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

class NowShowingSectionView extends StatelessWidget {
  final String title;
  final List<MovieVO>? movieList;
  final Function(int?) onTapMovie;
  NowShowingSectionView(
    this.title, {
    required this.movieList,
    required this.onTapMovie,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(
              left: MARGIN_MEDIUM,
            ),
            child: TitleText(title)),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        HorizontalMovieListView(
          movieList: movieList,
          onTapMovie: (movieId) => onTapMovie(movieId),
        ),
      ],
    );
  }
}

class ComingSoonSectionView extends StatelessWidget {
  final String title;
  final List<MovieVO>? movieList;
  final Function onTapMovie;
  ComingSoonSectionView(
    this.title, {
    required this.movieList,
    required this.onTapMovie,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(
              left: MARGIN_MEDIUM,
            ),
            child: TitleText(title)),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        HorizontalMovieListView(
          movieList: movieList,
          onTapMovie: (movieId) => onTapMovie(movieId),
        ),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final List<MovieVO>? movieList;
  final Function(int?) onTapMovie;
  HorizontalMovieListView({
    required this.movieList,
    required this.onTapMovie,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
      height: HORIZONTAL_LISTVIEW_HEIGHT,
      child: ListView.builder(
        padding: const EdgeInsets.only(
          left: MARGIN_MEDIUM,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: movieList?.length,
        itemBuilder: (context, index) {
          return MovieView(
              movie: movieList?[index],
              onTapMovie: () {
                onTapMovie(movieList?[index].id);
              });
        },
      ),
    );
  }
}

class MovieView extends StatelessWidget {
  final MovieVO? movie;
  final Function onTapMovie;
  MovieView({
    required this.movie,
    required this.onTapMovie,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => onTapMovie(),
          child: Container(
            margin: const EdgeInsets.only(
              right: MARGIN_MEDIUM,
            ),
            height: HOME_SCREEN_MOVIE_HEIGHT,
            width: HOME_SCREEN_MOVIE_WIDTH,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                MARGIN_MEDIUM,
              ),
              image: DecorationImage(
                image: NetworkImage(
                  "$IMAGE_BASE_URL${movie?.posterPath}",
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          movie?.title ?? "",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: MARGIN_SMALL,
        ),
        SubText(
          movie?.releaseDate ?? "",
          textSize: TEXT_SMALL,
        ),
      ],
    );
  }
}

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
