import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/screens/search_screen.dart';
import 'package:weather_app/shared/cubit/cubit.dart';
import 'package:weather_app/shared/cubit/states.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppCubit.get(context).color,
          appBar: AppBar(
            title: const Text('Weather App'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return SearchScreen();
                    },
                  ));
                },
                icon: const Icon(
                  Icons.search,
                  size: 30,
                ),
              )
            ],
          ),
          body: ConditionalBuilder(
            condition: AppCubit.get(context).cityDetails != null && AppCubit.get(context).cityId != null,
            builder: (context) =>  Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children:  [
                        Text('${AppCubit.get(context).cityDetails?.title}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                         Text('Updated at  ${AppCubit.get(context).date!.hour}:${AppCubit.get(context).date!.minute}  '
                             ),
                      ],
                    ),
                    const  SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                         Image.asset(AppCubit.get(context).image!),
                        Text('${AppCubit.get(context).cityDetails!.consolidatedWeather![0].theTemp!.round()}',style:const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        Column(
                          children:  [
                            Text('MAX: ${AppCubit.get(context).cityDetails!.consolidatedWeather![0].maxTemp!.round()} C',style:const TextStyle(fontSize: 20),),
                            Text('MIN: ${AppCubit.get(context).cityDetails!.consolidatedWeather![0].minTemp!.round()} C',style: const TextStyle(fontSize: 20),),
                          ],
                        ),
                      ],
                    ),
                    const  SizedBox(height: 25),
                    Text('${AppCubit.get(context).cityDetails!.consolidatedWeather![0].weatherStateName}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)
                  ],
                ),
              ),
            ),
            fallback: (context) => const Center(child: Text('Please Search for a City')),
          ),
        );
      },
    );
  }
}
