import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_out/features/auth/data/models/user_model.dart';
import 'package:task_out/features/auth/domain/entities/user_entity.dart';
import 'package:task_out/features/auth/domain/repositories/auth_repository.dart';

class AuthRepoImpl implements AuthRepository {
  final SupabaseClient supabase;

  AuthRepoImpl(this.supabase);

  /// Get the currently signed-in user
  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;
    return UserModel.fromMap(user.toJson());
  }

  /// Sign in using email and password
  @override
  Future<UserEntity> signInWithEmail(String email, String password) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final user = response.user;
    if (user == null) throw Exception('Sign-in failed');
    return UserModel.fromMap(user.toJson());
  }

  /// Placeholder for Facebook sign-in (not implemented)
  @override
  Future<UserEntity> signInWithFacebook() {
    throw UnimplementedError('Sign in with Facebook is not implemented');
  }

  /// Placeholder for Google sign-in (not implemented)
  @override
  Future<UserEntity> signInWithGoogle() {
    throw UnimplementedError('Sign in with Google is not implemented');
  }

  /// Sign out the currently signed-in user
  @override
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  /// Sign up using email, password, and a custom name field
  /// Sends a confirmation email with a confirmation link
  @override
  Future<UserEntity> signUpWithEmail(
    String name,
    String email,
    String password,
  ) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {'name': name},
    );
    final user = response.user;
    if (user == null) throw Exception('Sign-up failed');
    return UserModel.fromMap(user.toJson());
  }

  /// Send a password reset email with a reset link
  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await supabase.auth.resetPasswordForEmail(email);
  }
}
