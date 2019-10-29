import 'package:flutter/material.dart';

import './home/home.dart';
import './video/video.dart';

MaterialApp routes() {
  final String appName = 'Game Tube';

  return MaterialApp(
    theme: ThemeData.dark(),
    title: appName,
    initialRoute: '/',
    routes: {
      '/': (BuildContext context) => HomeScreen(),
      '/video': (BuildContext context) => VideoScreen(),
    },
  );
}