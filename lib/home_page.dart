///
/// @date: 8/18/21 13:50
/// @author: kevin
/// @description: dart
///
///
import 'package:beautiful_world/model/country_model.dart';
import 'package:beautiful_world/service/api_service.dart';
import 'package:beautiful_world/util/desktop_database_helper.dart';
import 'package:flutter/material.dart';

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

    initData();
  }

  initData() async {
    await DesktopDatabaseHelper.instance.initialDatabase();
    // final list = await WebScraperUtil.getCountryFlags();

    // WebScraperUtil.getNetData();
    // countryList.addAll(list!);
    // await DatabaseHelper.instance.initialDatabase();
    // WebScraperUtil.getCountryFlags();
    // final count = await ApiService.instance.getCountryCounts();
    // countryList.addAll(await ApiService.instance.queryAllCountry());

    final list = await ApiService.instance.queryAllCountry();

    setState(() {
      countryList.addAll(list);
    });

    // print(count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF5F5F5),
      // appBar: AppBar(title: Text('Beautiful World')),
      body: Container(
        // color: Colors.white,
        child: countryList.isEmpty
            ? SizedBox.shrink()
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 4,
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
                          width: 120,
                          height: 80,
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
