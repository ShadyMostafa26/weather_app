import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/city_details_model.dart';
import 'package:weather_app/models/location_search_model.dart';
import 'package:weather_app/shared/cubit/states.dart';
import 'package:weather_app/shared/network/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);


  List<LocationSearchModel>? locationSearch;
  int? cityId;
  bool isError = false;
  Future getCityId(String city) async{
    emit(GetCityLoadingState());
  await  DioHelper.getData(
      url: 'location/search?query=$city',
    ).then((value) {
      locationSearch = (value.data as List).map((e) => LocationSearchModel.fromJson(e)).toList();
      cityId = locationSearch![0].woeid!;
      isError = true;
      emit(GetCitySuccessState());
    }).catchError((error) {
      print(error.toString());
      isError = false;
      emit(GetCityErrorState(error.toString()));
    });
  }

  dynamic temp;
  String? weatherStateName;
  DateTime? date;
  CityDetails? cityDetails;
  Future<void> getCityDetails()async{
    emit(GetCityDetailsLoadingState());
   await DioHelper.getData(
      url: 'https://www.metaweather.com/api/location/$cityId/'
    ).then((value) {
      cityDetails = CityDetails.fromJson(value.data);

      temp = cityDetails!.consolidatedWeather![0].theTemp!.round();
      date = cityDetails!.consolidatedWeather![0].created;
      weatherStateName = cityDetails!.consolidatedWeather![0].weatherStateName;
      getImage();
      emit(GetCityDetailsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetCityDetailsErrorState());
    });
  }


  String? image;
  void getImage() {
    if (weatherStateName == 'Light Cloud') {
      image =  'assets/images/cloudy.png';
      emit(ChangeImageState());
    } else if (weatherStateName == 'Sleet' ||
        weatherStateName == 'Snow' ||
        weatherStateName == 'Hail') {
      image =  'assets/images/snow.png';
      emit(ChangeImageState());
    } else if (weatherStateName == 'Heavy Cloud') {
      image =  'assets/images/cloudy.png';
      emit(ChangeImageState());
    } else if (weatherStateName == 'Light Rain' ||
        weatherStateName == 'Heavy Rain' ||
        weatherStateName == 'Showers	') {
      image =  'assets/images/rainy.png';
      emit(ChangeImageState());
    } else if (weatherStateName == 'Thunderstorm' || weatherStateName == 'Thunder') {
      image =  'assets/images/thunderstorm.png';
      emit(ChangeImageState());
    } else {
      image =  'assets/images/clear.png';
      emit(ChangeImageState());
    }
  }

  MaterialColor? color;
  void getThemeColor() {
    if (weatherStateName == 'Clear' ) {
      color =  Colors.orange;
      emit(ChangeThemeState());
    } else if (weatherStateName == 'Sleet' ||
        weatherStateName == 'Snow' ||
        weatherStateName == 'Hail' || weatherStateName == 'Light Cloud') {
      color =  Colors.blue;
      emit(ChangeThemeState());
    } else if (weatherStateName == 'Heavy Cloud') {
      color =  Colors.blueGrey;
      emit(ChangeThemeState());
    } else if (weatherStateName == 'Light Rain' ||
        weatherStateName == 'Heavy Rain' ||
        weatherStateName == 'Showers	') {
      color =  Colors.blue;
      emit(ChangeThemeState());
    } else if (weatherStateName == 'Thunderstorm' || weatherStateName == 'Thunder' ){
      color =  Colors.deepPurple;
      emit(ChangeThemeState());
    } else {
      color =  Colors.orange;
      emit(ChangeThemeState());
    }
  }
}
