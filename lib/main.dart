import 'package:flutter/material.dart';
import 'api_services.dart';
import 'dashboard.dart'; // Make sure the path is correct

void main() => runApp(ExpenseInputApp());

class ExpenseInputApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExpenseDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ExpenseInputScreen extends StatefulWidget {
  @override
  _ExpenseInputScreenState createState() => _ExpenseInputScreenState();
}

class _ExpenseInputScreenState extends State<ExpenseInputScreen> {
  TextEditingController noteController = TextEditingController();
  double salary = 50000;
  String amount = "0.00";
  String selectedDate = "";

  void updateAmount(String value) {
    setState(() {
      if (value == '⌫') {
        if (amount.isNotEmpty) {
          amount = amount.substring(0, amount.length - 1);
          if (amount.isEmpty) amount = "0.00";
        }
      } else if (value == '✓') {
        submitExpense();
      } else if (value == '.' && amount.contains('.')) {
        return;
      } else {
        if (amount == "0.00") {
          amount = value;
        } else {
          amount += value;
        }
      }
    });
  }

  void showDateDialog() {
    TextEditingController dateController = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
        title: Text("Enter Date"),
        content: TextField(
          controller: dateController,
          keyboardType: TextInputType.datetime,
          decoration: InputDecoration(
            hintText: "DD/MM/YYYY",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => selectedDate = dateController.text);
              Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void submitExpense() async {
    double parsedAmount = double.tryParse(amount) ?? 0.0;
    String note = noteController.text.trim();

    if (parsedAmount == 0.0 || selectedDate.isEmpty || note.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final result = await ApiServices().expense_inserter(
      parsedAmount,
      note,
      selectedDate,
      salary,
    );

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Expense inserted successfully")),
      );
      setState(() {
        amount = "0.00";
        noteController.clear();
        selectedDate = "";
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${result['message']}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const SizedBox(height: 30),
            Container(
              height: 700,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(21),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.account_balance_wallet, size: 24, color: Colors.blue),
                                SizedBox(width: 8),
                                Text("Cash", style: TextStyle(fontSize: 18)),
                              ],
                            ),
                          ),
                          SizedBox(width: 80),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(21),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.shopping_bag, size: 24, color: Colors.purple),
                                SizedBox(width: 8),
                                Text("Shopping", style: TextStyle(fontSize: 18)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "\$$amount",
                    style: const TextStyle(fontSize: 46, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: noteController,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      hintText: "Add comment...",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            for (var row in [
                              ['1', '2', '3'],
                              ['4', '5', '6'],
                              ['7', '8', '9'],
                              ['.', '0', '⌫'],
                            ])
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: row.map((label) {
                                    return GestureDetector(
                                      onTap: () => updateAmount(label),
                                      child: Container(
                                        height: 75,
                                        width: 75,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(22),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          label,
                                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: showDateDialog,
                              child: Container(
                                height: 75,
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Icon(Icons.calendar_today, size: 30),
                              ),
                            ),
                            SizedBox(height: 14),
                            GestureDetector(
                              onTap: () => updateAmount('✓'),
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                child: Center(
                                  child: Icon(Icons.check, color: Colors.white, size: 36),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
