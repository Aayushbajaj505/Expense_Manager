import 'package:expense_planner/Widgets/NewTrasaction.dart';
import 'package:expense_planner/Widgets/chart.dart';
import 'package:expense_planner/Widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //list of dummy or user transactions
  final List<Transaction> _usertransaction = [];
  //Triming the list to only givce transactions from the last seven days
  List<Transaction> get _recenttransactions {
    return _usertransaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  // main method tot add a transaction
  void _addtransation(String txtitile, double txamount, DateTime chosendate) {
    final newtx = Transaction(
        id: DateTime.now().toString(),
        titile: txtitile,
        amount: txamount,
        date: chosendate);
    setState(() {
      _usertransaction.add(newtx);
    });
  }

  // shows the window to adda new transaction
  void _startaddnewtransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTrasaction(_addtransation);
      },
    );
  }

  void _deletetransaction(String id) {
    setState(() {
      _usertransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _startaddnewtransaction(context),
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
        title: Text('Expense Manager'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            chart(_recenttransactions),
            TransactionList(_usertransaction, _deletetransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startaddnewtransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
