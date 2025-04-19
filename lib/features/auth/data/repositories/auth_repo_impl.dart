import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_out/features/auth/data/models/user_model.dart';
import 'package:task_out/features/auth/domain/entities/user_entity.dart';
import 'package:task_out/features/auth/domain/repositories/auth_repository.dart';

class AuthRepoImpl implements AuthRepository {
  final SupabaseClient supabase;

  AuthRepoImpl(this.supabase);

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;
    return UserModel.fromMap(user.toJson());
  }

  @override
  Future<UserEntity> signInWithEmail(String email, String password) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final user = response.user;
    if (user == null) throw Exception('Signin failed');
    return UserModel.fromMap(user.toJson());
  }

  @override
  Future<UserEntity> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

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
    if (user == null) throw Exception('Signup failed');
    return UserModel.fromMap(user.toJson());
  }
}
