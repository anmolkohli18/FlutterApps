import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:engineeringblog/ui/Theme.dart' as Theme;
import 'package:engineeringblog/article.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleRow extends StatelessWidget {

  final Article article;

  ArticleRow(this.article);

  @override
  Widget build(BuildContext context) {
    final blogThumbnail = new Container(
      alignment: new FractionalOffset(0.0, 0.5),
      margin: const EdgeInsets.only(left: 0.0),
      child: new Hero(
        tag: 'blog-icon-${article.title}',
        child: new Image(
          image: new AssetImage(article.image),
          height: Theme.Dimens.blogHeight,
          width: Theme.Dimens.blogWidth,
        ),
      ),
    );

    final blogCard = new Container(
      margin: const EdgeInsets.only(left: 20.0, right: 2.0),
      decoration: BoxDecoration(
        color: Theme.Colors.blogCard,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(color: Colors.black,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0)
          )
        ]
      ),
      child: new Container(
        margin: const EdgeInsets.only(top: 10.0, left: 50.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(article.title.substring(0, min(50, article.title.length)) + '...', style: Theme.TextStyles.blogTitle,),
          ],
        ),
      ),
    );

    return new Container(
      height: 80.0,
      margin: const EdgeInsets.only(top: 12.0, bottom: 8.0),
      child: FlatButton(
        onPressed: () async {
          if (await canLaunch(article.link)) {
            await launch(article.link,
              forceSafariVC: true,
              forceWebView: true,
              enableJavaScript: true);
          } else {
            throw "Could not launch ${article.link}";
          }
        },
        child: new Stack(
          children: <Widget>[
            blogCard,
            blogThumbnail
          ],
        ),
      ),
    );
  }
}