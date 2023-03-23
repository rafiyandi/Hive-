import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_bloc_example/home/home.dart';
import 'package:hive_bloc_example/service/authentication_service.dart';
import 'package:hive_bloc_example/service/todo_services.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthenticationService()),
        RepositoryProvider(create: (context) => TodoServices()),
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
