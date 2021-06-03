import 'package:expense_planner/Widgets/chartbars.dart';
import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class chart extends StatelessWidget {
  final List<Transaction> recenttransactions;

  chart(this.recenttransactions);

  List<Map<String, Object>> get groupedtransactionvalues {
    return List.generate(7, (index) {
      //getting the day of the week using the index as index goes from
      // 0 to 6 so we subtract that many no of days from the date time now
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalsum = 0.0;

      for (var i = 0; i < recenttransactions.length; i++) {
        //checking each transaction for which day it occured and if it occured today
        // add it to todays sum and generate the data
        if (recenttransactions[i].date.day == weekday.day &&
            recenttransactions[i].date.month == weekday.month &&
            recenttransactions[i].date.year == weekday.year) {
          totalsum += recenttransactions[i].amount;
        }
      }
      return {'Day': DateFormat.E().format(weekday), 'Amount': totalsum};
    }).reversed.toList();
  }

  double get totalspending {
    return groupedtransactionvalues.fold(0.0, (sum, element) {
      return sum + (element['Amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedtransactionvalues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedtransactionvalues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: chartbars(
                  (data['Day']).toString(),
                  (data['Amount'] as double),
                  totalspending == 0.0
                      ? 0.0
                      : ((data['Amount'] as double) / totalspending)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
