import 'package:flutter/material.dart';

import 'dashboard.dart';

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


  @override
  @override
  Widget build(BuildContext context) {
    String amount = "0.00";
    String comment = "";

    void updateAmount(String value) {
      if (value == '⌫') {
        if (amount.isNotEmpty) {
          amount = amount.substring(0, amount.length - 1);
          if (amount.isEmpty) amount = "0.00";
        }
      } else if (value == '✓') {
        print("Submitted: \$${amount}, Comment: $comment");
        // Simulate submission
      } else if (value == '.' && amount.contains('.')) {
        return;
      } else {
        if (amount == "0.00") {
          amount = value;
        } else {
          amount += value;
        }
      }
    }

    return StatefulBuilder(
      builder: (context, setState) => Scaffold(
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
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: "Add comment...",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                        border: InputBorder.none,
                      ),
                      onChanged: (val) {
                        comment = val;
                      },
                    ),
                    const SizedBox(height: 40),

                    // Keypad Layout
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left 3x4 keypad
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
                                        onTap: () => setState(() => updateAmount(label)),
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

                        // Right-side buttons
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Container(
                                height: 75,
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Icon(Icons.calendar_today, size: 30),
                              ),
                              SizedBox(height: 14),
                              GestureDetector(
                                onTap: () => setState(() => updateAmount('✓')),
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
      ),
    );
  }


}
