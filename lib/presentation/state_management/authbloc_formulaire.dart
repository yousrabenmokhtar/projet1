import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase/supabase.dart';

final supabaseClient = SupabaseClient(
  'https://lvfwqxpotolchyjubgrp.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx2ZndxeHBvdG9sY2h5anViZ3JwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM3NzkwNzUsImV4cCI6MjAyOTM1NTA3NX0.HXvkeG2efVzVX7oxYmx6u9ICwZCSidw622UccO6yXz0',
);

class FormulaireEvent {}

class SaveNom extends FormulaireEvent {
  final String nom;
  SaveNom(this.nom);
}

class SaveDate extends FormulaireEvent {
  final String date;
  SaveDate(this.date);
}

class SaveMontant extends FormulaireEvent {
  final String montant;
  SaveMontant(this.montant);
}

class ResetFields extends FormulaireEvent {}

class FormulaireState {}

class FormulaireInitial extends FormulaireState {}

class FormulaireSuccess extends FormulaireState {}

class FormulaireFailure extends FormulaireState {
  final String errorMessage;
  FormulaireFailure(this.errorMessage);
}

class FormulaireBloc extends Bloc<FormulaireEvent, FormulaireState> {
  String? nom;
  String? date;
  String? montant;

  FormulaireBloc() : super(FormulaireInitial());

  @override
  Stream<FormulaireState> mapEventToState(FormulaireEvent event) async* {
    if (event is SaveNom) {
      nom = event.nom;
    } else if (event is SaveDate) {
      date = event.date;
    } else if (event is SaveMontant) {
      montant = event.montant;
      print('Montant sauvegardé: $montant');
    } else if (event is ResetFields) {
      nom = null;
      date = null;
      montant = null;
    }

    yield (nom != null && date != null && montant != null)
        ? FormulaireSuccess()
        : FormulaireFailure('Veuillez remplir tous les champs.');
  }
}