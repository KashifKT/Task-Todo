import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Views/Screens/Splash%20Screen/authwrapper.dart';
import 'package:todo_app/Views/Screens/Splash%20Screen/splash_screen.dart';
import 'package:todo_app/Views/Screens/slider.dart';
import 'package:todo_app/firebase_options.dart';
import 'Controls/task_provider.dart';
import 'Views/Screens/Form Pages/loginform.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize FireBase
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform
    );
    print("Fire_base connected successfully");
  }
  catch(e){
    print("Firebase connection failed: $e");
  }
  runApp(
    ChangeNotifierProvider(create: (_) => TaskProvider(),
    child: const MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO App',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.black,
        ),
        themeMode: taskProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home:  SplashScreen()
    );
  }
}