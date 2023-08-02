import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'screens/home_page.dart'; // Import the HomePage
import 'state.dart'; // Import the AppState class from state.dart


final _formKey = GlobalKey<FormState>();




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Ideal time to initialize
  await FirebaseAuth.instance.useAuthEmulator('localhost', 56664);
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'RaidTrain TV',
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          colorScheme: ColorScheme.dark().copyWith(
            primary: Color.fromARGB(255, 49, 14, 108),
          ),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

