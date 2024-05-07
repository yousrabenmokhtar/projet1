import 'package:flutter/material.dart';
import 'package:flutter_application_3/presentation/pages/login_screen.dart';
import 'package:flutter_application_3/data/repository/data_repository.dart'; 
import 'presentation/pages/historique.dart';
import '../presentation/pages/home1.dart';
import 'package:flutter_application_3/domain/use_cases/formulaire_usecase.dart'; 
import 'package:flutter_application_3/presentation/screens/formulaire_saisie.dart'; 
import 'package:flutter_application_3/presentation/state_management/authbloc_formulaire.dart';
import 'package:flutter_application_3/presentation/state_management/total_calculator.dart';



var customRoutes = <String, WidgetBuilder>{
        '/formulaire': (context) => FormulaireSaisie(), 
  '/': (context) => Historique(formulaireUseCase: FormulaireUseCaseImpl(DataRepository(supabaseClient))),
  '/login': (context) => LoginScreen(),
  '/home1': (context) => Home1(
    formulaireUseCase: FormulaireUseCaseImpl(DataRepository(supabaseClient)),
    refreshData: FormulaireUseCaseImpl(DataRepository(supabaseClient)).getFormData,
    
  ),
  '/total_calculator': (context) => TotalCalculator(refreshData: FormulaireUseCaseImpl(DataRepository(supabaseClient)).getFormData),
  
};
