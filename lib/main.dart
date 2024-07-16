import 'package:browser/provider/Connection_provider.dart';
import 'package:browser/view/homepage/android/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/bookmark.dart';
import 'provider/brower.dart';
import 'view/homepage/android/bookmarklist.dart';
import 'view/homepage/android/openmark.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DeleteProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchEngineProvider(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, routes: {
      '/': (context) => HomePage(),
      'bookmark': (context) => BookmarkPage(),
      'links': (context) => Mark(),
    });
  }
}
