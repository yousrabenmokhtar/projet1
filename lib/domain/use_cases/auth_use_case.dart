// domain/use_cases/auth_use_case.dart

import 'package:supabase/supabase.dart';
import '../repository/auth_repository_interface.dart';

class AuthUseCase {
  final AuthRepositoryInterface _authRepository;

  AuthUseCase(this._authRepository);

  Future<Session?> signInWithEmailPassword(String email, String password) async {
    return _authRepository.signInWithEmailPassword(email, password);
  }

  // Future<Session?> signUpWithEmailPassword(String email, String password) async {
  //   return _authRepository.signUpWithEmailPassword(email, password);
  // }
}
