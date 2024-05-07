import 'package:flutter/material.dart';
import 'package:flutter_application_3/data/models/trans_model.dart';
import '../screens/formulaire_saisie.dart';
import 'package:flutter_application_3/domain/use_cases/formulaire_usecase.dart';

class Historique extends StatefulWidget {
  final FormulaireUseCase formulaireUseCase;

 Historique({required this.formulaireUseCase});

  @override
  _HistoriqueState createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  late Future<List<Transaction>> _formDataFuture;
  final TextEditingController _newNomController = TextEditingController();
  final TextEditingController _newDateController = TextEditingController();
  final TextEditingController _newMontantController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshFormData();
  }

  void _refreshFormData() {
    setState(() {
      _formDataFuture = widget.formulaireUseCase.getFormData();
    });
  }

  void _deleteTransaction(String nom) async {
    try {
      final isSuccess = await widget.formulaireUseCase.deleteTransaction(nom);
      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Transaction supprimée avec succès.'),
            backgroundColor: Colors.green,
          ),
        );
        _refreshFormData(); // Rafraîchir la liste après la suppression
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de la suppression de la transaction.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print('Erreur lors de la suppression de la transaction: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la suppression de la transaction.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _updateTransaction(Transaction formData) async {
  try {
    final updatedTransaction = Transaction(
      id: formData.id, 
      nom: _newNomController.text,
      date: DateTime.parse(_newDateController.text),
      montant: double.parse(_newMontantController.text),
    );
    final isSuccess = await widget.formulaireUseCase.updateTransaction(updatedTransaction);
    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Transaction mise à jour avec succès.'),
          backgroundColor: Colors.green,
        ),
      );
      _refreshFormData(); // Rafraîchir la liste après la mise à jour
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la mise à jour de la transaction.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (error) {
    print('Erreur lors de la mise à jour de la transaction: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erreur lors de la mise à jour de la transaction.'),
        backgroundColor: Colors.red,
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Color.fromARGB(255, 255, 248, 220),
      body: Container(
        color: Color.fromARGB(255, 255, 248, 220),
        child: FutureBuilder<List<Transaction>>(
          future: _formDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erreur: ${snapshot.error}'));
            } else {
              final formDataList = snapshot.data!;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: formDataList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final formData = formDataList[index];
                        return Card(
                          elevation: 4,
                          margin: EdgeInsets.all(8),
                          color: const Color.fromARGB(255, 181, 236, 182),
                          child: ListTile(
                            title: Text(
                              'Nom: ${formData.nom}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date: ${formData.date}',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  'Montant: ${formData.montant}',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Supprimer la transaction"),
                                          content: Text("Voulez-vous vraiment supprimer cette transaction ?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Annuler"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                _deleteTransaction(formData.id!);
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Supprimer"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Modifier la transaction"),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TextField(
                                                  controller: _newNomController,
                                                  decoration: InputDecoration(labelText: 'Nouveau nom'),
                                                ),
                                                TextField(
                                                  controller: _newDateController,
                                                  decoration: InputDecoration(labelText: 'Nouvelle date'),
                                                  onTap: () async {
                                                    final DateTime? picked = await showDatePicker(
                                                      context: context,
                                                      initialDate: DateTime.now(),
                                                      firstDate: DateTime(2015, 8),
                                                      lastDate: DateTime(2101),
                                                    );
                                                    if (picked != null && picked != DateTime.now()) {
                                                      setState(() {
                                                        _newDateController.text = picked.toString();
                                                      });
                                                    }
                                                  },
                                                ),
                                                TextField(
                                                  controller: _newMontantController,
                                                  decoration: InputDecoration(labelText: 'Nouveau montant'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Annuler"),
                                            ),
                                            TextButton(

                                              onPressed: () {
                                                _updateTransaction(
                                                  formData
                                                );
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Enregistrer"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: EdgeInsets.only(bottom: 16.0),
      //   child: FloatingActionButton(
      //     onPressed: () async {
      //       await Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => FormulaireSaisie(),
      //         ),
      //       );
      //       _refreshFormData(); // Rafraîchir la liste après l'ajout d'une transaction
      //     },
      //     child: Icon(Icons.add),
      //     backgroundColor: Colors.green,
      //   ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
