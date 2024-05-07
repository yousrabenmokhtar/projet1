import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase/supabase.dart';
import 'package:flutter_application_3/domain/use_cases/formulaire_usecase.dart';
import 'package:flutter_application_3/data/repository/data_repository.dart';
import 'package:flutter_application_3/presentation/state_management/authbloc_formulaire.dart';

class FormulaireSaisie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormulaireBloc>(
      create: (context) => FormulaireBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Formulaire de saisie'),
         backgroundColor: Colors.green[900],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Nouvelle Transaction',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                BlocBuilder<FormulaireBloc, FormulaireState>(
                  builder: (context, state) {
                    return Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            style: TextStyle(color: Colors.black), 
                            decoration: InputDecoration(
                              labelText: 'Nom',
                              labelStyle: TextStyle(color: Colors.green),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              BlocProvider.of<FormulaireBloc>(context).add(SaveNom(value));
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Date',
                              labelStyle: TextStyle(color: Colors.green),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2015, 8),
                                lastDate: DateTime(2101),
                              );
                              if (picked != null) {
                                BlocProvider.of<FormulaireBloc>(context).add(SaveDate(picked.toString()));
                              }
                            },
                            onChanged: (value) {
                              BlocProvider.of<FormulaireBloc>(context).add(SaveDate(value));
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Montant',
                              labelStyle: TextStyle(color: Colors.green),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              BlocProvider.of<FormulaireBloc>(context).add(SaveMontant(value));
                            },
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20.0, right: 20.0),
                              child: IconButton(
                                icon: Icon(Icons.check_circle, color: const Color.fromARGB(255, 168, 255, 171),),
                                onPressed: () async {
                                  final formulaireBloc = BlocProvider.of<FormulaireBloc>(context);
                                  final state = formulaireBloc.state;

                                  if (state is FormulaireSuccess) {
                                    final nom = formulaireBloc.nom!;
                                    final date = formulaireBloc.date!;
                                    final montant = formulaireBloc.montant!;

                                    try {
                                      final formulaireUseCase = FormulaireUseCaseImpl(DataRepository(supabaseClient));
                                      final isSuccess = await formulaireUseCase.saveData(nom, date, montant);

                                      if (isSuccess) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Données enregistrées avec succès.'),
                                            backgroundColor: Color.fromARGB(255, 66, 244, 49),
                                          ),
                                        );
                                        formulaireBloc.add(ResetFields());
                                        Navigator.pop(context);
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Erreur lors de l\'enregistrement des données.'),
                                            backgroundColor: Color.fromARGB(255, 196, 9, 6),
                                          ),
                                        );
                                      }
                                    } catch (error) {
                                      print(error);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Erreur lors de l\'enregistrement des données.'),
                                          backgroundColor: Color.fromARGB(255, 196, 9, 6),
                                        ),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Veuillez remplir tous les champs.'),
                                         backgroundColor: Color.fromARGB(255, 66, 244, 49),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
