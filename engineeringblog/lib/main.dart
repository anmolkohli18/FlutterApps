import 'package:flutter/material.dart';
import 'package:engineeringblog/articles_list_view.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Engineering blog',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Latest Engineering Articles'),
    );
  }
}
