class CityDetails {
  List<ConsolidatedWeather>? consolidatedWeather;
  String? time;
  String? sunRise;
  String? sunSet;
  String? timezoneName;
  Parent? parent;
  List<Sources>? sources;
  String? title;
  String? locationType;
  int? woeid;
  String? lattLong;
  String? timezone;


  CityDetails.fromJson(Map<String, dynamic> json) {
    if (json['consolidated_weather'] != null) {
      consolidatedWeather = <ConsolidatedWeather>[];
      json['consolidated_weather'].forEach((v) {
        consolidatedWeather!.add( ConsolidatedWeather.fromJson(v));
      });
    }
    time = json['time'];
    sunRise = json['sun_rise'];
    sunSet = json['sun_set'];
    timezoneName = json['timezone_name'];
    parent =
    json['parent'] != null ?  Parent.fromJson(json['parent']) : null;
    if (json['sources'] != null) {
      sources = <Sources>[];
      json['sources'].forEach((v) {
        sources!.add( Sources.fromJson(v));
      });
    }
    title = json['title'];
    locationType = json['location_type'];
    woeid = json['woeid'];
    lattLong = json['latt_long'];
    timezone = json['timezone'];
  }


}

class ConsolidatedWeather {
  int? id;
  String? weatherStateName;
  String? weatherStateAbbr;
  String? windDirectionCompass;
  DateTime? created;
  String? applicableDate;
  double? minTemp;
  double? maxTemp;
  double? theTemp;
  double? windSpeed;
  double? windDirection;
  double? airPressure;
  int? humidity;
  double? visibility;
  int? predictability;



  ConsolidatedWeather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weatherStateName = json['weather_state_name'];
    weatherStateAbbr = json['weather_state_abbr'];
    windDirectionCompass = json['wind_direction_compass'];
    created = DateTime.parse(json['created']);
    applicableDate = json['applicable_date'];
    minTemp = json['min_temp'];
    maxTemp = json['max_temp'];
    theTemp = json['the_temp'];
    windSpeed = json['wind_speed'];
    windDirection = json['wind_direction'];
    airPressure = json['air_pressure'];
    humidity = json['humidity'];
    visibility = json['visibility'];
    predictability = json['predictability'];
  }

}

class Parent {
  String? title;
  String? locationType;
  int? woeid;
  String? lattLong;

  Parent({this.title, this.locationType, this.woeid, this.lattLong});

  Parent.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    locationType = json['location_type'];
    woeid = json['woeid'];
    lattLong = json['latt_long'];
  }

}

class Sources {
  String? title;
  String? slug;
  String? url;
  int? crawlRate;

  Sources({this.title, this.slug, this.url, this.crawlRate});

  Sources.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    url = json['url'];
    crawlRate = json['crawl_rate'];
  }


}