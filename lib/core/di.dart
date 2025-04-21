import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_out/features/auth/data/repositories/auth_repo_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepoImpl();
});
