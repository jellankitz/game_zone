import 'package:flutter/material.dart';

import './widgets/app_bar.dart';
import './widgets/app_body.dart';
import './enum/main_tab.dart';

class HomeScreen extends StatelessWidget {
  final String appBarTitle = 'GZone';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: appBar(title: Text(appBarTitle)),
        body: TabBarView(
          children: [
            appBody(context, MainTab.recent),
            appBody(context, MainTab.popular),
            appBody(context, MainTab.live),
          ],
        ),
      ),
    );
  }
}
