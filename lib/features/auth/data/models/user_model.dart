import 'package:task_out/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.id, required super.name, required super.email});

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(id: data['id'], name: data['name'], email: data['email']);
  }
}
