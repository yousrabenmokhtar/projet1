import 'package:flutter/material.dart';
import 'package:flutter_application_3/data/models/trans_model.dart';
import 'package:flutter_application_3/presentation/screens/totalcalculatorStyle.dart';

class TotalCalculator extends StatefulWidget {
  final Future<List<Transaction>> Function() refreshData;

  const TotalCalculator({required this.refreshData});

  @override
  _TotalCalculatorState createState() => _TotalCalculatorState();
}

class _TotalCalculatorState extends State<TotalCalculator> {
  double _totalMontant = 0;

  @override
  void initState() {
    super.initState();
    _updateTotalMontant();
  }

  Future<void> _updateTotalMontant() async {
    final transactions = await widget.refreshData();
    double total = 0;
    for (var transaction in transactions) {
      total += transaction.montant;
    }
    setState(() {
      _totalMontant = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TotalCalculatorStyle(totalMontant: _totalMontant);
  }
}