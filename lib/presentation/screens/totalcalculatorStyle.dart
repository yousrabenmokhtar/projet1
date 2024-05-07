import 'package:flutter/material.dart';

class TotalCalculatorStyle extends StatelessWidget {
  final double totalMontant;

  const TotalCalculatorStyle({required this.totalMontant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Total Calculator', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            
             Navigator.pushNamed(context, '/home1');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.sports_soccer, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[200]!, Colors.green[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Somme totale des montants:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.green[900],
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(height: 12),
            Text(
              '$totalMontant',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.green[900],
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sports_soccer, size: 40, color: Colors.green[900]),
                SizedBox(width: 16),
                Icon(Icons.emoji_events, size: 40, color: Colors.green[900]),
                SizedBox(width: 16),
                Icon(Icons.sports_football, size: 40, color: Colors.green[900]),
              ],
            ),
            SizedBox(height: 40), 
          ],
        ),
      ),
    );
  }
}