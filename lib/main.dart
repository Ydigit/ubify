import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ubify/core/configs/theme/app_theme.dart';
import 'package:ubify/firebase_options.dart';
import 'package:ubify/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:ubify/presentation/splash/pages/splash.dart';
import 'package:ubify/service_locator.dart';

//ROADMAP
//set the theme on the app in tha main
//we updates the gradlle thingy

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //garate bindings are configured befores using native APIs
  WidgetsFlutterBinding.ensureInitialized();
  //configures the storage used by HydrateBloc
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        //for web uses this webStorageDirectory
        ? HydratedStorage.webStorageDirectory
        //here uses the getApplicationDocumentsDirectory aka local system storage
        : await getApplicationDocumentsDirectory(),
  );
  //executes the app
  //we need to initialize the firebase here
  //async for blocking flow on firebase initialization
  //for current platform selects the configurations for the Firebase
  //option is a file and we select from there
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Inicialize Supabase
  await Supabase.initialize(
    url: 'https://cgkakfyfsmzsheiddmng.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNna2FrZnlmc216c2hlaWRkbW5nIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzU1Nzc4NzUsImV4cCI6MjA1MTE1Mzg3NX0.MSY6-_4UjhP-G9C2MdWJdk_1oM8ZuLVybqRLW8gAtwo',
  );
  await initilizeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //lets register multiple Cubir/Bloc providers
      //this provider lets register the themeCubit
      //creates an instance of ThemeThemeCubit()
      //with providers ThemeCubit isntance is accessible for BuilContext that is what we want
      //-------GLOBAL INJECTION-----------
      //unique instance

      providers: [BlocProvider(create: (_) => ThemeCubit())],
      //listens to the changes generate by ThemeCubit instance
      //BlocBuilder is a widget that listens to Cubit changes
      //listens to the state managed by the ThemeCubit his state is type ThemeMode
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        //BUILDER IS CALLED EVERYTHIME STATE OF THEMECUBIT CHANGES
        //when the state of ThemeVubit changes MAterialApp is rebuilt
        builder: (context, mode) => MaterialApp(
          //if changes the mode is the new themeMode of MAterialApp
          theme: AppTheme.lightTheme, //light
          themeMode: mode, //define here the themeMode
          darkTheme: AppTheme.darkTheme, //darks
          home: const SplashPage(),
          //hide debugging page
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
