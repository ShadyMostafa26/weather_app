import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/shared/cubit/cubit.dart';
import 'package:weather_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  final searchController = TextEditingController();

  SearchScreen({Key? key}) : super(key: key);
  String? cityName;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
        /*if(state is GetCitySuccessState ){
        Future.delayed(const Duration(microseconds: 100), ()=>   Navigator.pop(context));
        }*/
        if(state is GetCityErrorState || state is GetCityDetailsErrorState){
          Fluttertoast.showToast(
              msg: "Please Enter a Correct City Name",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red[700],
              textColor: Colors.white,
              fontSize: 20.0,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Search for city"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: TextField(
                controller: searchController,
                onSubmitted: (value) {
                  AppCubit.get(context).getCityId(value.split(" ").join("").toLowerCase()).then((value) {

                    AppCubit.get(context).getCityDetails().then((value) {
                      AppCubit.get(context).getImage();
                      AppCubit.get(context).getThemeColor();

                      if(AppCubit.get(context).image != null && AppCubit.get(context).color != null && AppCubit.get(context).isError != false ){
        Future.delayed(const Duration(microseconds: 100), ()=>   Navigator.pop(context));
        }

                    });
                  });

                },
                decoration: const InputDecoration(
                  border:  OutlineInputBorder(),
                  contentPadding:  EdgeInsets.symmetric(vertical: 25,horizontal: 5),
                  hintText: 'Enter City Name',

                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
