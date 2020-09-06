import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

Future<Map<String, String>> fetchNetflixArticles() async {
  var url = 'https://netflixtechblog.com/';
  final response = await http.Client().get(Uri.parse(url));

  Map<String, String> linkMap = Map();
  if (response.statusCode == 200) {
    var document = parse(response.body);
    var elements = document.querySelectorAll('a');
    for (var element in elements) {
      var href = element.attributes['href'];
      var articleRegex = RegExp(url + r"\w+-\w+.*");
      if (articleRegex.hasMatch(href)) {
        linkMap.putIfAbsent(element.attributes['href'], () => element.text);
      }
    }
  }
  return linkMap;
}