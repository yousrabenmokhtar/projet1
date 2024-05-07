import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/use_cases/formulaire_usecase.dart';
import 'package:flutter_application_3/data/models/trans_model.dart';
import 'package:flutter_application_3/presentation/pages/historique.dart';
import 'package:flutter_application_3/presentation/state_management/total_calculator.dart';
import '../screens/formulaire_saisie.dart';

class Home1 extends StatefulWidget {
  final FormulaireUseCase formulaireUseCase;
  final Future<List<Transaction>> Function() refreshData;

  Home1({required this.formulaireUseCase, required this.refreshData});

  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  late Future<List<Transaction>> _dataFuture;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _dataFuture = widget.refreshData();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
      
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FutureBuilder<List<Transaction>>(
                    future: _dataFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Erreur: ${snapshot.error}');
                      } else {
                        double totalMontant = 0;
                        final transactions = snapshot.data!;
                        for (var transaction in transactions) {
                          totalMontant += transaction.montant;
                        }
                        return Row(
                          children: [
                            Icon(Icons.monetization_on), 
                            SizedBox(width: 10),
                            Text(
                              'Montant Total: $totalMontant',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  FutureBuilder<List<Transaction>>(
                    future: _dataFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Erreur: ${snapshot.error}');
                      } else {
                        final transactions = snapshot.data!;
                        if (transactions.isEmpty) {
                          return Text(
                            'Aucune transaction ajoutée',
                            style: TextStyle(fontSize: 18),
                          );
                        } else {
                          final lastTransaction = transactions.last;
                          return Card(
                            elevation: 4,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Dernière Transaction:',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.account_balance_wallet), 
                                      SizedBox(width: 10),
                                      Text(
                                        'Nom: ${lastTransaction.nom}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today),
                                      SizedBox(width: 10),
                                      Text(
                                        'Date: ${lastTransaction.date}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.attach_money), 
                                      SizedBox(width: 10),
                                      Text(
                                        'Montant: ${lastTransaction.montant}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      case 1:
      return TotalCalculator(
        refreshData: widget.refreshData,
      );
    case 2:
      return FormulaireSaisie();
    case 3:
      return Historique(formulaireUseCase: widget.formulaireUseCase);
    default:
      return SizedBox.shrink(); // Retour par défaut pour éviter l'avertissement
  }
  }

  Widget _buildNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.monetization_on),
          label: 'Calculatrice',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Ajouter',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Historique',
        ),
      ],
      currentIndex: _selectedIndex ?? 0, 
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
      onTap: _onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          _selectedIndex = 0; 
        });
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Bienvenue dans votre application sportive',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
          centerTitle: true,
          automaticallyImplyLeading: false, 
        ),
        backgroundColor: Colors.white,
        body: _buildBody(),
        bottomNavigationBar: _buildNavigationBar(),
      ),
    );
  }
}
