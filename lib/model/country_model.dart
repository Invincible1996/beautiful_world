///
/// @date: 8/18/21 14:06
/// @author: kevin
/// @description: dart
///
///

class CountryModel {
  String? enName;
  String? cnName;
  String? imageFlag;
  String? nativeLanguage;
  String? shortName;

  CountryModel({this.enName, this.cnName, this.imageFlag, this.nativeLanguage, this.shortName});

  CountryModel.fromJson(Map<String, dynamic> json) {
    enName = json['en_name'];
    cnName = json['cn_name'];
    imageFlag = json['image_flag'];
    nativeLanguage = json['native_language'];
    shortName = json['shortName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en_name'] = this.enName;
    data['cn_name'] = this.cnName;
    data['image_flag'] = this.imageFlag;
    data['native_language'] = this.nativeLanguage;
    data['shortName'] = this.shortName;
    return data;
  }
}
