import 'package:flutter/material.dart';

class chartbars extends StatelessWidget {
  // const chartbars({Key? key}) : super(key: key);
  final String label;
  final double spendingamount;
  final double spending_perc_oftotal;

  chartbars(this.label, this.spendingamount, this.spending_perc_oftotal);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        FittedBox(
          child: Text('₹ ${spendingamount.toStringAsFixed(0)}'),
        ),
        SizedBox(
          height: screenSize.height / 100,
        ),
        Container(
          height: screenSize.height / 10,
          width: screenSize.width / 40,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spending_perc_oftotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: screenSize.height / 100,
        ),
        Text(label),
      ],
    );
  }
}
