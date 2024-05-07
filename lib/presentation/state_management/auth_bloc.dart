import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase/supabase.dart';

final supabase = SupabaseClient(
  'https://lvfwqxpotolchyjubgrp.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx2ZndxeHBvdG9sY2h5anViZ3JwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM3NzkwNzUsImV4cCI6MjAyOTM1NTA3NX0.HXvkeG2efVzVX7oxYmx6u9ICwZCSidw622UccO6yXz0',
);
// Événements
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
 

  const SignUpEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

// États
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure({required this.error});

  @override
  List<Object> get props => [error];
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      yield AuthLoading();

      try {
        // Sign in using Supabase Auth
        final response = await supabase.auth.signInWithPassword(
          email: event.email,
          password: event.password,
        );
         
       var session = supabase.auth.currentSession;
        var userId = session?.user?.id;

       if (session != null && session.user.emailConfirmedAt != null) {
          // L'email est confirmé
          yield AuthAuthenticated();
        } else {
          // L'email n'est pas confirmé
          yield AuthFailure(error: "Email not confirmed");
        }
       
      // yield AuthAuthenticated();
        
      } catch (error) {
      
        yield AuthFailure(error: error.toString());
      }

//     } else if (event is SignUpEvent) {
//   yield AuthLoading();

//   try {
//     // Tentative d'inscription
//     final response = await supabase.auth.signUp(
//       email: event.email,
//       password: event.password,
//     );

//     // Si aucune exception n'est levée, considérez l'inscription réussie
//     yield AuthAuthenticated();
    
//     // Naviguer vers la page de connexion après une inscription réussie
//     // Navigator.of(event.context).pushReplacementNamed('/login');
    
//   } catch (error) {
//     // En cas d'erreur, émettez l'état de défaillance
//     yield AuthFailure(error: error.toString());
//   }
}
}}
    





