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
import 'package:flutter_dotenv/flutter_dotenv.dart';

//ROADMAP
//set the theme on the app in tha main
//we updates the gradlle thingy

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure HydratedBloc storage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Firebase initialization with error handling for duplicate app issue
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    if (e.toString().contains('duplicate-app')) {
      // If the Firebase app is already initialized, just log the error and continue
      print('Firebase app already initialized.');
    } else {
      rethrow; // Rethrow any other initialization errors
    }
  }

  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  // Initialize service locator (dependencies)
  await initilizeDependencies();

  // Start the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // Register Bloc providers (ThemeCubit)
      providers: [BlocProvider(create: (_) => ThemeCubit())],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) => MaterialApp(
          theme: AppTheme.lightTheme, // Light theme
          themeMode: mode, // Switches based on ThemeCubit state
          darkTheme: AppTheme.darkTheme, // Dark theme
          home: const SplashPage(),
          debugShowCheckedModeBanner: false, // Hide debug banner
        ),
      ),
    );
  }
}
