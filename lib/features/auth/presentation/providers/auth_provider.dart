import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_out/core/di.dart';
import 'package:task_out/core/errors_and_exceptions/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

final authStateProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<UserEntity?>>((ref) {
      final authRepo = ref.watch(authRepositoryProvider);
      return AuthNotifier(authRepo);
    });

class AuthNotifier extends StateNotifier<AsyncValue<UserEntity?>> {
  final AuthRepository repository;

  AuthNotifier(this.repository) : super(const AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    try {
      final user = await repository.getCurrentUser();
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(ServerFailure('Failed to get current user'), st);
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    try {
      state = const AsyncValue.loading();
      final user = await repository.signUpWithEmail(name, email, password);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(ServerFailure(e.toString()), st);
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      state = const AsyncValue.loading();
      final user = await repository.signInWithEmail(email, password);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(ServerFailure(e.toString()), st);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      state = const AsyncValue.loading();
      final user = await repository.signInWithGoogle();
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(
        ServerFailure('Google sign-in failed: ${e.toString()}'),
        st,
      );
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      state = const AsyncValue.loading();
      final user = await repository.signInWithFacebook();
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(
        ServerFailure('Facebook sign-in failed: ${e.toString()}'),
        st,
      );
    }
  }

  Future<void> signOut() async {
    try {
      state = const AsyncValue.loading();
      await repository.signOut();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(
        ServerFailure('Logout failed: ${e.toString()}'),
        st,
      );
    }
  }

  /// Send password reset email
  Future<void> resetPassword(String email) async {
    try {
      state = const AsyncValue.loading();
      await repository.sendPasswordResetEmail(email);
      state =
          state = AsyncValue.data(state.value); // keep the user state unchanged
    } catch (e, st) {
      state = AsyncValue.error(
        ServerFailure('Password reset failed: ${e.toString()}'),
        st,
      );
    }
  }
}
