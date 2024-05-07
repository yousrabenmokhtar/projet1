// domain/repository/auth_repository_interface.dart

import 'package:supabase/supabase.dart';

abstract class AuthRepositoryInterface {
  Future<Session?> signInWithEmailPassword(String email, String password);
  // Future<Session?> signUpWithEmailPassword(String email, String password);
}
