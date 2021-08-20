///
///
/// @date: 8/18/21 14:30
/// @author: kevin
/// @description: dart
///
///
import 'package:beautiful_world/util/desktop_database_helper.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class WebScraperUtil {
  /// @create at 8/18/21 14:31
  /// @create by kevin
  /// @desc
  static void getNetData() async {

    var url = 'https://www.worldometers.info/geography/flags-of-the-world/';

    final response = await http.get(Uri.parse(url));

    final body = response.body;

    final html = parse(body);

    final liList = html.querySelectorAll('.col-md-4');

    print(liList.length);
    liList.removeLast();

    for (var item in liList) {
      print(item.text);
      var image =
          item.querySelector('a')!.querySelector('img')!.attributes['src'];

      print(image);
      // https://www.worldometers.info/img/flags/small/tn_vm-flag.gif
      DesktopDatabaseHelper.instance.db?.insert('country', <String, Object?>{
        'image_flag': 'https://www.worldometers.info$image',
        'en_name': '${item.text}'
      });
    }

    // var buffer = StringBuffer();

    // for (var i = 0; i < liList.length; i++) {
    //   var element = liList[i];
    //   var lastSeparator = i == liList.length - 1 ? ";" : ",";
    //
    //   buffer
    //     ..write("(")
    //     ..write("\"${element.children[0].text}\",")
    //     ..write("\"${element.children[1].text}\",")
    //     ..write("\"${element.children[2].text}\",")
    //     ..write("\"${element.children[3].text}\")$lastSeparator");
    // }
    //
    // print(buffer);
    //
    // DatabaseHelper.instance.db?.execute(
    //     'INSERT INTO country(short_name,cn_name,en_name,fr_name)VALUES${buffer.toString()}');
  }
}
