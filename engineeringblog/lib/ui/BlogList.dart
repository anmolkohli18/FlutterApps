import 'package:flutter/material.dart';
import 'package:engineeringblog/ui/BlogRow.dart';
import 'package:engineeringblog/ui/Theme.dart' as Theme;
import 'package:engineeringblog/article.dart';
import 'package:engineeringblog/parsers/mediumblog_parser.dart';
import 'package:engineeringblog/parsers/netflixblog_parser.dart';
import 'package:engineeringblog/parsers/twitterblog_parser.dart';
import 'package:engineeringblog/parsers/uberblog_parser.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class BlogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Flexible(
      child: new Container(
        color: Theme.Colors.blogPageBackground,
        child: FutureBuilder(
          future: _getArticles(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Loading(indicator: BallPulseIndicator(), size: 100.0, color: Colors.pink),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return new ArticleRow(snapshot.data[index]);
                }
              );
            }
          },
        ),
      )
    );
  }

  Future<List<Article>> _getArticles() async {
    var responseList = await Future.wait([fetchNetflixArticles(), fetchTwitterArticles(), fetchUberArticles(), fetchMediumArticles('https://medium.com/airbnb-engineering/'), fetchMediumArticles('https://medium.com/criteo-labs/')]);
    var netflixArticles = responseList.elementAt(0);
    var twitterArticles = responseList.elementAt(1);
    var uberArticles = responseList.elementAt(2);
    var airbnbArticles = responseList.elementAt(3);
    var criteoArticles = responseList.elementAt(4);

    List<List<Article>> articlesList = List();
    articlesList.add(_makeList(netflixArticles, 'Netflix Eng', 'assets/img/netflix.png'));
    articlesList.add(_makeList(twitterArticles, 'Twitter Eng', 'assets/img/twitter.png'));
    articlesList.add(_makeList(uberArticles, 'Uber Eng', 'assets/img/uber.png'));
    articlesList.add(_makeList(airbnbArticles, 'Airbnb Eng', 'assets/img/airbnb.png'));
    articlesList.add(_makeList(criteoArticles, 'Criteo Eng', 'assets/img/criteo.png'));
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
          added = true;
        }
      }
      if (!added) {
        break;
      }
    }
    return articles;
  }

  List<Article> _makeList(Map<String, String> linkTitleMap, String subtitle, String image) {
    List<Article> articles = List();
    for (String link in linkTitleMap.keys) {
      articles.add(Article(linkTitleMap[link], subtitle, link, image));
    }
    return articles;
  }
}