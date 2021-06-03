import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTrasaction extends StatefulWidget {
  // const NewTrasaction({Key key}) : super(key: key);

  // the function addnew tex is passed down
  final Function newtx;
  //text editing controllers
  NewTrasaction(this.newtx);

  @override
  _NewTrasactionState createState() => _NewTrasactionState();
}

class _NewTrasactionState extends State<NewTrasaction> {
  final titleinput = TextEditingController();

  final amountinput = TextEditingController();

  DateTime _selecteddate = DateTime.now();

  void _submitdata() {
    String _enteredtitile = titleinput.text;
    double _enteredAmount = double.parse(amountinput.text);
    if (_enteredtitile.isEmpty || _enteredAmount <= 0) {
      return;
    }
    widget.newtx(_enteredtitile, _enteredAmount, _selecteddate);
    Navigator.of(context).pop();
    // calling the addtransaction function from usertrasactions
  }

  void _showdatepicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((_pickeddate) {
      if (_pickeddate == null) {
        return;
      }
      setState(() {
        _selecteddate = _pickeddate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(screenSize.height / 30),
        // margin: EdgeInsets.all(screenSize.height / 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: titleinput,
              decoration: InputDecoration(labelText: 'Title'),
              onSubmitted: (_) => _submitdata(),
            ),
            TextField(
              controller: amountinput,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.numberWithOptions(),
              onSubmitted: (_) => _submitdata(),
            ),
            Row(
              children: <Widget>[
                Text("Date: ${DateFormat.yMd().format(_selecteddate)}"),
                TextButton(
                    onPressed: _showdatepicker, child: Text('Choose a Date'))
              ],
            ),
            ElevatedButton(
              child: Text(
                'Add Transaction',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: _submitdata,
            )
          ],
        ),
      ),
    );
  }
}
