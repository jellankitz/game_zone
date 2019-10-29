import 'package:flutter/material.dart';

import './video_list.dart';
import './../../app/services/youtube.dart';
import './../../app/dialog.dart';
import './../enum/main_tab.dart';

Widget appBody(BuildContext rootContext, MainTab target) {
  final Youtube youtube = new Youtube();

  Future<YtVideo> _getTargetVideos() {
    switch(target) {
      case MainTab.recent:
        return youtube.getList();
      
      case MainTab.popular:
        return youtube.getList();
      
      case MainTab.live:
        return youtube.getList();
      
      default:
        return youtube.getList();
    }
  }

  Future<YtVideo> videos = _getTargetVideos();

  return FutureBuilder<YtVideo>(
    future: videos,
    builder: (BuildContext context, AsyncSnapshot<YtVideo> snapshot) {

      if(snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasData) {
          return VideoList(videos: snapshot.data,);
        } else if (snapshot.hasError) {
          Future.delayed(Duration.zero, () => popupDialog(rootContext, 'Error','Someting went wrong while fetching data.'));
        }

        return Center(
          child: Text(
            'No Data',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            ),
          ),
        );
      }

      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}