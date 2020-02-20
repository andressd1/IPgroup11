import 'package:flutter/material.dart';
import 'package:template/CheckRecomendations.dart';
import 'package:template/RecommendMovie.dart';
import 'package:template/homepage.dart';
import 'package:template/searchpage.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      initialRoute: Routes.bottomRoutes[0],
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        Routes.bottomRoutes[0]: (BuildContext context) => new Homepage(),
        Routes.bottomRoutes[1]: (BuildContext context) => new MovieSearchPage(),
        Routes.bottomRoutes[2]: (BuildContext context) => new CheckRecomendations(),
        '/friendsearchpage': (BuildContext context) => new FriendSearchPage(),
      },
    );
  }
}

class Routes {
  static final bottomRoutes = ['/', '/moviesearchpage', '/checkrecomendations'];
}
