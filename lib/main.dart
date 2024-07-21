import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:github_actions_and_firebase_app_distribution_demo/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeApp();

  runApp(const MainApp());
}

Future<void> initializeApp() async {
  final FirebaseOptions options = DefaultFirebaseOptions.currentPlatform;
  await Firebase.initializeApp(options: options);

  return Future<void>.value();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
