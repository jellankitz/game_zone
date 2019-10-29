import 'package:flutter/material.dart';

import './widgets/app_bar.dart';
import './widgets/app_body.dart';

class VideoScreen extends StatelessWidget {
  final String appBarTitle = 'GZone';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: Text(appBarTitle)),
      body: appBody(context),
    );
  }
}