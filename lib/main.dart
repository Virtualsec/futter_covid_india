import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:covid_india/providers/stats_providers.dart';
import 'package:covid_india/theme/app_theme.dart';
import './screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => StatsProviders(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "COVID India",
        theme: themeData(),
        home: HomeScreen(),
      ),
    );
  }
}
