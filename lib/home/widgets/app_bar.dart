import 'package:flutter/material.dart';

Widget appBar({dynamic title = ''}) {
  return AppBar(
    title: title,
    bottom: TabBar(
      tabs: [
        Tab(
          key: UniqueKey(),
          child: Text('New'),
        ),
        Tab(
          key: UniqueKey(),
          child: Text('Popular'),
        ),
        Tab(
          key: UniqueKey(),
          child: Text('Live'),
        )
      ],
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          //do search
        },
      )
    ],
  );
}
