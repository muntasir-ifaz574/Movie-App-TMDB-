import 'package:flutter/material.dart';
import 'package:movie_tmdb/widgets/toprated.dart';
import 'package:movie_tmdb/widgets/trending.dart';
import 'package:movie_tmdb/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];
  final String apikey = '9c6d811fec8d194454be566b70b57a50';
  final readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5YzZkODExZmVjOGQxOTQ0NTRiZTU2NmI3MGI1N2E1MCIsInN1YiI6IjYyMWM4ODI2YzI4MjNhMDA0NGViMDA3YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.60Dhu2D3XXgMY0zYFQ9kX64D7Pe5NgScduosRnL2TRg';

  @override
  void initState() {
    super.initState();
    loadmovies();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPopular();
    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NewGradientAppBar(
          centerTitle: true,
          title: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (rect) => LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.pink, Colors.yellow.shade100],
            ).createShader(rect),
            child: Text(
              "Movie App",
              style: TextStyle(
                color: Colors.blue.shade400,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade200,
              Colors.blue.shade500,
              Colors.blue.shade900,
            ],
          ),
        ),
        body: ListView(
          children: [
            TV(
              tv: tv,
            ),
            TrendingMovies(
              trending: trendingmovies,
            ),
            TopRated(
              toprated: topratedmovies,
            ),
          ],
        ));
  }
}
