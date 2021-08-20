import 'package:beautiful_world/model/country_model.dart';
import 'package:beautiful_world/util/database_helper.dart';
import 'package:beautiful_world/util/desktop_database_helper.dart';

///
/// @date: 8/19/21 10:41
/// @author: kevin
/// @description: dart
///
///

class ApiService {
  static final ApiService instance = ApiService._internal();

  factory ApiService() => instance;

  ApiService._internal(); // private constructor

  /// @create at 8/19/21 10:44
  /// @create by kevin
  /// @desc  获取所有国家的数量
  Future<int?> getCountryCounts() async {
    final result = await DesktopDatabaseHelper.instance.db?.query('country', columns: ['COUNT(*)']);
    print(result);
    if ((result ?? []).isEmpty) return 0;
    return result?[0]['COUNT(*)'] as int;
  }

  /// @create at 8/19/21 11:09
  /// @create by kevin
  /// @desc
  updateFlagsByName(String enName, String imageFlag) async {
    final result = await DesktopDatabaseHelper.instance.db?.execute('UPDATE country SET image_flag =\"$imageFlag\"  WHERE en_name = \"$enName\"');
    // print(result);
  }

  /// @create at 8/19/21 11:25
  /// @create by kevin
  /// @desc
  Future<List<CountryModel>> queryAllCountry() async {
    final result = await DesktopDatabaseHelper.instance.db?.query('country');

    print(result?.length);

    List<CountryModel> countryList = [];

    for (var item in result ?? []) {
      // print(item['image_flag']);
      if (item['image_flag'].isNotEmpty) {
        countryList.add(CountryModel.fromJson(item));
      }
    }
    return countryList;
  }
}
