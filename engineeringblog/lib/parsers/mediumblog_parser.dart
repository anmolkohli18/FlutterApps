import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

Map<String, String> main() {
  Future<Map<String, String>> airbnb = fetchMediumArticles('https://medium.com/airbnb-engineering/');
  Future<Map<String, String>> criteo = fetchMediumArticles('https://medium.com/criteo-labs/');
}

Future<Map<String, String>> fetchMediumArticles(url) async {
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