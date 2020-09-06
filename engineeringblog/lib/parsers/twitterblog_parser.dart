import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

Future<Map<String, String>> fetchTwitterArticles() async {
  var url = 'https://blog.twitter.com/engineering/en_us.html';
  final response = await http.Client().get(Uri.parse(url));

  Map<String, String> linkMap = Map();
  if (response.statusCode == 200) {
    var document = parse(response.body);
    var elements = document.querySelectorAll('a');
    for (var element in elements) {
      var href = element.attributes['href'];
      var articleRegex = RegExp(r"/engineering/en_us/topics/\w+/\d{4}/");
      if (href != null && articleRegex.hasMatch(href)) {
        linkMap.putIfAbsent('https://blog.twitter.com' + href, () => element.text);
      }
    }
  }
  return linkMap;
}