abstract class AppStates{}

class AppInitialStates extends AppStates{}

class GetCityLoadingState extends AppStates{}
class GetCitySuccessState extends AppStates{}
class GetCityErrorState extends AppStates{
  final String error;

  GetCityErrorState(this.error);
}

class GetCityDetailsLoadingState extends AppStates{}
class GetCityDetailsSuccessState extends AppStates{}
class GetCityDetailsErrorState extends AppStates{}


class ChangeThemeState extends AppStates{}
class ChangeImageState extends AppStates{}