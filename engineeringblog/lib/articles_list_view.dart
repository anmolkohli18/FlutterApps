import 'package:engineeringblog/Article.dart';
import 'package:engineeringblog/parsers/mediumblog_parser.dart';
import 'package:engineeringblog/parsers/netflixblog_parser.dart';
import 'package:engineeringblog/parsers/twitterblog_parser.dart';
import 'package:engineeringblog/parsers/uberblog_parser.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}): super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Article>> _getArticles() async {
    print("Waiting for netflix articles");
    var netflixArticles = await fetchNetflixArticles();
    print("Waiting for twitter articles");
    var twitterArticles = await fetchTwitterArticles();
    print("Waiting for Uber articles");
    var uberArticles = await fetchUberArticles();
    print("Waiting for airbnb articles");
    var airbnbArticles = await fetchMediumArticles('https://medium.com/airbnb-engineering/');
    print("Waiting for criteo articles");
    var criteoArticles = await fetchMediumArticles('https://medium.com/criteo-labs/');

    List<List<Article>> articlesList = List();
    articlesList.add(_makeList(netflixArticles, 'Netflix Eng'));
    articlesList.add(_makeList(twitterArticles, 'Twitter Eng'));
    articlesList.add(_makeList(uberArticles, 'Uber Eng'));
    articlesList.add(_makeList(airbnbArticles, 'Airbnb Eng'));
    articlesList.add(_makeList(criteoArticles, 'Criteo Eng'));
    List<Article> articles = merge(articlesList);

    print(articles.length);
    return articles;
  }

  List merge(List<List<Article>> articlesList) {
    var numOfList = articlesList.length;
    var indexes = List<int>.filled(numOfList, 0);
    List<Article> articles = List();
    while (true) {
      var added = false;
      for (var i = 0; i < numOfList; i++) {
        var index = indexes[i];
        if (index < articlesList[i].length) {
          articles.add(articlesList[i][index]);
          indexes[i] += 1;
          print("adding");
          added = true;
        }
      }
      if (!added) {
        break;
      }
    }
    return articles;
  }

  List<Article> _makeList(Map<String, String> linkTitleMap, String subtitle) {
    List<Article> articles = List();
    for (String link in linkTitleMap.keys) {
      articles.add(Article(linkTitleMap[link], subtitle, link));
    }
    return articles;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: _articlesListView()
    );
  }

  Widget _articlesListView() {
    return Container(
      child: FutureBuilder(
        future: _getArticles(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.data);
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text("Loading..."),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data[index].title),
                  subtitle: Text(snapshot.data[index].subtitle),
                  onTap: () async {
                    var url = snapshot.data[index].link;
                    if (await canLaunch(url)) {
                      await launch(url,
                        forceSafariVC: true,
                        forceWebView: true,
                        enableJavaScript: true);
                    } else {
                      throw "Could not launch $url";
                    }
                  }
                );
              }
            );
          }
        },
      ),
    );
  }
}

