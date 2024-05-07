// data/data_sources/supabase_data_source.dart

import 'package:supabase/supabase.dart';

class SupabaseDataSource {
  final SupabaseClient _supabaseClient;

  SupabaseDataSource(this._supabaseClient);

  Future<Session?> signInWithEmailPassword(String email, String password) async {
    // Logique pour s'authentifier avec Supabase
  }

 
}
