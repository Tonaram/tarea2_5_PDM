import 'package:flutter/material.dart';

void main() => runApp(const TipTimeApp());

class TipTimeApp extends StatelessWidget {
  const TipTimeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Time App',
      theme: ThemeData(
        primaryColor: Colors.green,
        textTheme: TextTheme(

          headline6: TextStyle(
            color: Colors.green,
            fontSize: 24.0,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
        ),
      ),
      home: const TipCalculator(),
    );
  }
}

class TipCalculator extends StatefulWidget {
  const TipCalculator({Key? key}) : super(key: key);

  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  TextEditingController amountController = TextEditingController();
  double tipAmount = 0.0;
  bool roundTotal = false;
  int selectedRadio = 0;

  void calculateTip() {
    double amount = double.tryParse(amountController.text) ?? 0.0;
    double tipPercentage = 0.0;

    if (selectedRadio == 0) {
      tipPercentage = 0.10;
    } else if (selectedRadio == 1) {
      tipPercentage = 0.15;
    } else if (selectedRadio == 2) {
      tipPercentage = 0.20;
    }

    double tip = amount * tipPercentage;

    if (roundTotal) {
      tipAmount = tip.ceil().toDouble();
    } else {
      tipAmount = tip;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Time'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  Icons.restaurant_menu,
                  size: 24.0,
                  color: Theme.of(context).primaryColor, 
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: amountController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Total Amount',
                      border: OutlineInputBorder(),

                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text('Select Tip Percentage:'), 
            Row(
              children: [
                Radio(
                  value: 0,
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      selectedRadio = value as int;
                    });
                  },
                ),
                const Text('10%'),
                Radio(
                  value: 1,
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      selectedRadio = value as int;
                    });
                  },
                ),
                const Text('15%'),
                Radio(
                  value: 2,
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      selectedRadio = value as int;
                    });
                  },
                ),
                const Text('20%'),
              ],
            ),
            SwitchListTile(
              title: const Text('Round Total'),
              value: roundTotal,
              onChanged: (value) {
                setState(() {
                  roundTotal = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (amountController.text.isNotEmpty) {
                    calculateTip();
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Warning'),
                          content: const Text('Please enter a total amount.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Calculate Tip'),
              ),
            ),
            const SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Tip Amount: \$${tipAmount.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 15.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
