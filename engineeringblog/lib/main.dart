import 'package:engineeringblog/ui/BlogList.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Eng Blogs',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('The Engineering Blogs'),
        ),
        body: Center(
          child: new BlogList(),
        ),
      ),
      //new BlogList(),
    );
  }
}
