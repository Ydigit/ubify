import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

//HydratedCubit state is themeMode
//ThemeCubit its a part of bloc and is responsible for managing the theme state
//extends do hydratedcubit suports state persistance
//defines the state
class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit()
      : super(ThemeMode //default is system choice
            .system); //by omission we initial state is the systems preference
  //takes the theme mode that is pssed and change to light or dark with "emit"
  //we receive the (light||dark), TheeData defines on the class is for styling
  void updateTheme(ThemeMode themeMode) => emit(themeMode);
  //emit notifies listener that theme as changed to themeMode

  //converts data to obj ThemeMode
  //maps string or number to ThemeNumer
  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return ThemeMode.values[json['themeMode'] as int];
  }

  //converts the actual state to a Json
  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    // TODO: implement toJson
    return {'themeMode': state.index};
  }
}
