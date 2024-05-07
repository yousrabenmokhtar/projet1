import 'package:flutter_application_3/data/models/trans_model.dart';
import 'package:supabase/supabase.dart';

class DataRepository {
  final SupabaseClient _supabaseClient;

  DataRepository(this._supabaseClient);

  Future<bool> saveFormData(String nom, String date, String montant) async {
    try {
      final response = await _supabaseClient.from('transaction').insert([
        {'nom': nom, 'date': date, 'montant': montant},
      ]).execute();

      return response.status == 201;
    } catch (error) {
      print('Erreur lors de l\'enregistrement des données: $error');
      return false;
    }
  }


Future<List<Transaction>> getFormData() async {
  try {
    final response = await _supabaseClient.from('transaction').select();
    
   
      final List<dynamic> dataList = response as List<dynamic>;
      final List<Transaction> formDataList = [];

      for (final dynamic data in dataList) {
         
        formDataList.add( Transaction.fromMap(data));
      }

      return formDataList;

  } catch (error) {
    print('Error while retrieving form data: $error');
    throw Exception('Failed to retrieve form data');
  }
}


Future<bool> deleteTransaction(String id) async {
  try {
    await _supabaseClient.from('transaction').delete().eq('id_transaction', id);
    return true;
  } catch (error) {
    print('Error deleting transaction: $error');
    return false;
  }
}


Future<bool> updateTransaction(Transaction transaction) async {
  try {
    await _supabaseClient.from('transaction')
        .update(transaction.toMap())
        .eq('id_transaction', transaction.id);
    return true;
  } catch (error) {
    print('Error updating transaction: $error');
    throw Exception('erreur  to update transaction');
  }
}

}
