import 'package:hive/hive.dart';
import 'package:lern_hive_with_johanes/model/transaction.dart';

class Boxes {
  //membuat sebuah method yang dikembalikan kedalam kotak transaction
  static Box<Transaction> getTransactions() =>
      Hive.box<Transaction>('transactions');
}
