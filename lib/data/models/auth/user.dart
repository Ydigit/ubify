import 'package:ubify/domain/entities/auth/user.dart'; // Certifique-se de importar a definição de UserEntity

class UserModel {
  String? userId; // Adicionei o campo id
  String? fullName;
  String? email;

  UserModel({this.userId, this.fullName, this.email});

  UserModel.fromJson(Map<String, dynamic> data) {
    userId = data['id']; // Inicialize o campo id
    fullName = data['full_name'] ?? 'Unknown Name'; // Valor padrão se for nulo
    email = data['email'] ?? 'Unknown Email';
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      email: email,
      fullName: fullName,
    );
  }
}
