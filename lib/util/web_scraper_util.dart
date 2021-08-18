///
///
/// @date: 8/18/21 14:30
/// @author: kevin
/// @description: dart
///
///
import 'package:beautiful_world/util/database_helper.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class WebScraperUtil {
  /// @create at 8/18/21 14:31
  /// @create by kevin
  /// @desc
  static void getNetData() async {
    print('object');

    var url = 'http://www.fltacn.com/article_392.html';

    final response = await http.get(Uri.parse(url));

    final body = response.body;

    final html = parse(body);

    final liList = html.querySelectorAll('tr');

    print(liList.length);
    liList.removeAt(0);

    var buffer = StringBuffer();

    for (var item in liList) {
      print(item.children[0].text.trim());
      print(item.children[1].text.trim());
      print(item.children[2].text.trim());
      print(item.children[3].text.trim());
      // print(item.querySelector('td')!.text);
      // print(item.querySelector('td')!.text);
    }

    for (var i = 0; i < liList.length; i++) {
      var element = liList[i];
      var lastSeparator = i == liList.length - 1 ? ";" : ",";

      buffer
        ..write("(")
        ..write("\"${element.children[0].text}\",")
        ..write("\"${element.children[1].text}\",")
        ..write("\"${element.children[2].text}\",")
        ..write("\"${element.children[3].text}\")$lastSeparator");
    }

    print(buffer);

    DatabaseHelper.instance.db?.execute(
        'INSERT INTO country(short_name,cn_name,en_name,fr_name)VALUES${buffer.toString()}');
  }
}
