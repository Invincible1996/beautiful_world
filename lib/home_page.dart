///
/// @date: 8/18/21 13:50
/// @author: kevin
/// @description: dart
///
///
import 'package:beautiful_world/model/country_model.dart';
import 'package:beautiful_world/util/database_helper.dart';
import 'package:beautiful_world/util/web_scraper_util.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CountryModel> countryList = [];

  @override
  initState() {
    super.initState();
    // getData();

    DatabaseHelper.instance.initialDatabase();
    WebScraperUtil.getNetData();
  }

  /// @create at 8/18/21 13:58
  /// @create by kevin
  /// @desc
  getData() async {
    var url = 'https://www.worldometers.info/geography/flags-of-the-world/';

    final response = await http.get(Uri.parse(url));

    final body = response.body;

    final html = parse(body);

    final liList = html.querySelectorAll('.col-md-4');

    print(liList.length);

    for (var item in liList) {
      var image = item
          .querySelector('div')!
          .querySelector('a')!
          .querySelector('img')!
          .attributes['src'];
      var name = item.querySelector('div')!.querySelector('div')!.text;
      CountryModel model = CountryModel();
      model.enName = name;
      model.imageFlag = 'https://www.worldometers.info$image';
      model.nativeLanguage = 'english';
      model.cnName = '暂无';
      print(name + image!);
      countryList.add(model);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Beautiful World')),
      body: Container(
        // color: Colors.white,
        child: countryList.isEmpty
            ? SizedBox.shrink()
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 5 / 1,
                ),
                itemBuilder: (_, index) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Color(0XFFEEEEEE),
                        ),
                      ),
                    ),
                    // height: 120,
                    child: Row(
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Color(0XFFEEEEEE),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                countryList[index].imageFlag!,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${countryList[index].enName!}',
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${countryList[index].cnName!}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: countryList.length,
              ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
