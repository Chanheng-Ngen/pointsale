import '../../data/repositories/user_repository.dart';
import '../../data/models/user_model.dart';

class UserViewModel {
  final UserRepository _repository = UserRepository();

  Future<List<UserModel>> getUsers() async {
    return await _repository.fetchUsers();
  }

  Future<UserModel?> getUserById(String id) async {
    return await _repository.fetchUserById(id);
  }

  Future<void> createUser(UserModel user) async {
    await _repository.createUser(user);
  }

  Future<void> updateUser(UserModel user) async {
    await _repository.updateUser(user);
  }

  Future<void> deleteUser(String id) async {
    await _repository.deleteUser(id);
  }
}
