import 'dart:convert';
import 'package:http/http.dart' as http;

class Youtube {
  
  final String url = 'https://www.googleapis.com/youtube/v3/search';
  final String apiKey = 'AIzaSyB44U1JG6-rglh9E8qAx_G9r4KNJYj_hPE';

  Future<YtVideo> getList() async {
    
    final List<YtParameter> parameters = [
      YtParameter('part','snippet'),
      YtParameter('q','overwatch'),
      YtParameter('maxResults',3),
      YtParameter('type','video'),
      YtParameter('order','date'),
      YtParameter('relevanceLanguage','en'),
    ];

    return YtVideo.fromJson(json.decode(await _getResponse(parameters)));
  }

  Future<YtChannel> getChannel(String channelId) async {

    final List<YtParameter> parameters = [
      YtParameter('part', 'snippet'),
      YtParameter('id', channelId),
      YtParameter('maxResults',1),
    ];

    return YtChannel.fromJson(json.decode(await _getResponse(parameters)));
  }

  Future<String> _getResponse(List<YtParameter> parameters) async {
    final String params = _getParameters(parameters);
    final http.Response response = await http.get(url + params);
    
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Request failed with status: ${response.statusCode}. $url | $params");
    }

  }

  String _getParameters(List<YtParameter> params) {
    String result = '?key=$apiKey';

    for(int index = 0; index < params.length; index++) {
      final YtParameter currentParam = params[index];
      final String field = currentParam.field;
      final dynamic value = currentParam.value;

      result += '&$field=$value';
    }

    return result;
  }
}

class YtParameter {
  final String field;
  final dynamic value;

  const YtParameter(this.field, this.value);
}

class YtVideo {
  final int totalResults;
  final int resultsPerPage;
  final List<dynamic> items;

  const YtVideo({this.items, this.totalResults = 0, this.resultsPerPage = 0});

  factory YtVideo.fromJson(Map<String, dynamic> json) {
    return YtVideo(
      items: json['items'],
      totalResults: json['pageInfo']['totalResults'],
      resultsPerPage: json['pageInfo']['resultsPerPage'],
    );
  }
}

class YtItem {
  final String image;
  final String title;
  final String channelId;

  const YtItem(this.image, this.title, this.channelId);

  YtItem.fromJson(Map<String, dynamic> json) 
    : image = json['snippet']['thumbnails']['high']['url'],
      title = json['snippet']['title'],
      channelId = json['snippet']['channelId'];
  
}

class YtChannel {
  final String title;
  final String image;

  const YtChannel({this.title, this.image});

  factory YtChannel.fromJson(Map<String, dynamic> json) {
    return YtChannel(
      title: json['items'][0]['snippet']['title'],
      image: json['items'][0]['snippet']['thumbnails']['default']['url'],
    );
  }
}