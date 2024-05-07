import 'package:flutter/material.dart';
import 'package:flutter_application_3/data/models/trans_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_3/data/repository/data_repository.dart';

import 'package:flutter/material.dart';

import 'package:flutter_application_3/data/repository/data_repository.dart';

abstract class FormulaireUseCase {
  Future<bool> saveData(String nom, String date, String montant);
  Future<List<Transaction>> getFormData();
  Future<bool> deleteTransaction(String nom);
  Future<bool>updateTransaction(Transaction transaction);
}

class FormulaireUseCaseImpl implements FormulaireUseCase {
  final DataRepository _dataRepository;

  FormulaireUseCaseImpl(this._dataRepository);

  @override
  Future<bool> saveData(String nom, String date, String montant) async {
    try {
      return await _dataRepository.saveFormData(nom, date, montant);
    } catch (error) {
      print('Erreur lors de l\'enregistrement des données: $error');
      return false;
    }
  }

  @override
  Future<List<Transaction>> getFormData() async {
    try {
      return await _dataRepository.getFormData();
    } catch (error) {
      print('Erreur lors de la récupération des données: $error');
      return [];
    }
  }
@override
  Future<bool> deleteTransaction(String id) async {
       final response = await _dataRepository.deleteTransaction(id);
      return response;
  }
@override
Future<bool> updateTransaction(Transaction transaction) async {
  final response = await _dataRepository.updateTransaction( transaction);
  return response;
}
}
  

