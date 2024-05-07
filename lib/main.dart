import 'package:flutter/material.dart';
import 'package:flutter_application_3/presentation/state_management/auth_bloc.dart';
import 'package:flutter_application_3/presentation/state_management/authbloc_formulaire.dart';
import 'package:flutter_application_3/custom_routes.dart';
import 'package:flutter_application_3/App.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() => runApp(MultiBlocProvider(
  providers: [
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
    ),
    BlocProvider<FormulaireBloc>(
      create: (context) => FormulaireBloc(),
    ),
    
  ],
  child: MyApp(),
));
