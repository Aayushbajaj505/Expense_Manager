import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  // const TransactionList({Key key}) : super(key: key);
  final List<Transaction> transaction;
  final Function delete_tx;
  TransactionList(this.transaction, this.delete_tx);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height / 1.75,
      child: transaction.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No Transactions',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: screenSize.height / 10,
                ),
                Container(
                  height: screenSize.height / 3,
                  child: Image.asset(
                    'image/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (cxt, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                            child: Text('₹ ${transaction[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transaction[index].titile,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transaction[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: () => delete_tx(transaction[index].id),
                    ),
                  ),
                );
              },
              itemCount: transaction.length,
            ),
    );
  }
}
