import 'package:flutter/material.dart';

import './../../app/services/youtube.dart';

class VideoList extends StatelessWidget {
  final YtVideo videos;
  
  const VideoList({this.videos});

  List<Widget> _getVideoCards() {
    final List<dynamic> items = videos.items;
    List<Widget> cards = [];

    for(int index = 0; index < items.length; index++) {
      cards.add(_VideoCard(
        key: UniqueKey(),
        item: YtItem.fromJson(items[index]),
      ));

      cards.add(Divider());
      cards.add(_spacer());
    }

    return cards;
  }

  Widget _spacer() {
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        padding: const EdgeInsets.only(bottom: 5.0, top: 16.0),
        children: _getVideoCards(),
      ),
    );
  }
}

class _VideoCard extends StatelessWidget {
  final YtItem item;
  
  const _VideoCard({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center, 
      padding: const EdgeInsets.only(bottom: 0.0),
      child: _cardBody(item, context)
    );
  }

  Widget _cardBody(YtItem item, BuildContext context) {
    final Future<YtChannel> channel = Youtube().getChannel(item.channelId);

    return Container(
        height: 260.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                ),
                alignment: AlignmentDirectional.center,
                height: 230.0,
                child: Image.network(
                    item.image,
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            Container(
              child: _buildChannel(channel),
            ),
          ],
        ),
      );
  }

  FutureBuilder<YtChannel> _buildChannel(channel) {
    return FutureBuilder<YtChannel>(
      future: channel,
      builder: (context, snapshot) {
        final YtChannel channelDetails = snapshot.data;

        if (snapshot.hasData) {
          return ListTile(
            leading: ClipOval(
              child: Image.network(
                channelDetails.image,
                fit: BoxFit.fill,
                width: 88.0
              ),
            ),
            title: Text(channelDetails.title),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return Center(
          child: LinearProgressIndicator(),
        );
      },
    );
  }

}
