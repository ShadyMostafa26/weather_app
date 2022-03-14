class LocationSearchModel {
  String? title;
  String? locationType;
  int? woeid;
  String? lattLong;

  LocationSearchModel({this.title, this.locationType, this.woeid, this.lattLong});

  LocationSearchModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    locationType = json['location_type'];
    woeid = json['woeid'];
    lattLong = json['latt_long'];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'location_type': locationType,
      'woeid': woeid,
      'latt_long': lattLong,
    };
  }
}
