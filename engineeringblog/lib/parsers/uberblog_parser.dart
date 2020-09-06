import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

Future<Map<String, String>> fetchUberArticles() async {
  var url = 'https://eng.uber.com/';
  final response = await http.Client().get(Uri.parse(url));

  Map<String, String> linkMap = Map();
  if (response.statusCode == 200) {
    var document = parse(response.body);
    var elements = document.querySelectorAll('h3.td-module-title > a');
    for (var element in elements) {
      var href = element.attributes['href'];
      var articleRegex = RegExp(url + r".*");
      if (articleRegex.hasMatch(href)) {
        linkMap.putIfAbsent(element.attributes['href'], () => element.text);
      }
    }
  }
  return linkMap;
}