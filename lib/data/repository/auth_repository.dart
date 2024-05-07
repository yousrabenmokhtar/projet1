

import 'package:supabase/supabase.dart';

class AuthRepository {
  final SupabaseClient _supabaseClient;

  AuthRepository(this._supabaseClient);

  Future<Session?> signInWithEmailPassword(String email, String password) async {
    // Logique pour s'authentifier avec email et mot de passe
  }

  Future<Session?> signUpWithEmailPassword(String email, String password) async {
    // Logique pour s'inscrire avec email et mot de passe
  }
}
