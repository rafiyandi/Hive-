import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lern_hive_with_johanes/model/transaction.dart';
import 'package:lern_hive_with_johanes/page/transaction_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); //initialisasi hive
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Transaction>(
      'transactions'); //open box dan inisilisasi nama box, setelah membuka jangan lupa menutup
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Hive Expense App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: TransactionPage(),
    );
  }
}
