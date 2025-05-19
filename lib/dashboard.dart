import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpenseDashboard extends StatelessWidget {
  const ExpenseDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5EDFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.menu, color: Colors.black),
        actions: [Icon(Icons.notifications_none, color: Colors.black)],
        title: Column(
          children: [
            Text('\$32,500.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
            Text('Total Balance', style: TextStyle(fontSize: 12, color: Colors.black45)),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Toggle Tabs
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _toggleButton('Expenses', true),
                _toggleButton('Income', false),
                _monthDropdown('June'),
              ],
            ),
            const SizedBox(height: 16),

            // Graph Section
            SizedBox(
              height: 150,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 35,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(),
                    rightTitles: AxisTitles(),
                    topTitles: AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) => Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(value.toInt().toString()),
                        ),
                        reservedSize: 30,
                      ),
                    ),
                  ),
                  barGroups: [
                    makeGroupData(1, 12, Colors.orange.shade200),
                    makeGroupData(5, 3, Colors.blue.shade300),
                    makeGroupData(10, 5, Colors.yellow.shade600),
                    makeGroupData(15, 32, Colors.greenAccent.shade400),
                    makeGroupData(20, 21, Colors.purple.shade200),
                    makeGroupData(25, 7, Colors.cyan.shade200),
                    makeGroupData(31, 5, Colors.orange.shade200),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Daily/Weekly/Monthly Summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _summaryCard('Day', '\$52'),
                _summaryCard('Week', '\$403'),
                _summaryCard('Month', '\$1,612'),
              ],
            ),

            const SizedBox(height: 24),

            // Transaction List
            _transactionTile(Icons.shopping_bag, 'Shopping', 'Cash', '\$498.50', '32%', Colors.green.shade100),
            _transactionTile(Icons.card_giftcard, 'Gifts', 'Cash · Card', '\$344.45', '21%', Colors.purple.shade100),
            _transactionTile(Icons.restaurant, 'Food', 'Cash', '\$230.50', '12%', Colors.red.shade100),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }

  Widget _toggleButton(String text, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.black : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(21),
      ),
      child: Text(text, style: TextStyle(color: selected ? Colors.white : Colors.black)),
    );
  }

  Widget _monthDropdown(String month) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(21),
      ),
      child: Row(
        children: [
          Text(month),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  Widget _summaryCard(String title, String amount) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(amount, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 4),
        Text(title, style: TextStyle(color: Colors.black54))
      ],
    );
  }

  Widget _transactionTile(IconData icon, String title, String subtitle, String amount, String percent, Color bgColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: bgColor,
                child: Icon(icon, color: Colors.black),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(percent, style: TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }

  // Create one bar group
  BarChartGroupData makeGroupData(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 14,
          borderRadius: BorderRadius.circular(6),
        ),
      ],
    );
  }
}
