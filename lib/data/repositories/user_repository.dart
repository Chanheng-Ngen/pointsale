import '../models/user_model.dart';
import '../services/user_service.dart';

class UserRepository {
  final UserService _service = UserService();

  Future<List<UserModel>> fetchUsers() async {
    try {
      return await _service.getUsers();
    } catch (e) {
      // Handle error and maybe log it
      rethrow;
    }
  }

  Future<UserModel?> fetchUserById(String id) async {
    try {
      return await _service.getUserById(id);
    } catch (e) {
      // Handle error and maybe log it
      rethrow;
    }
  }

  Future<void> createUser(UserModel user) async {
    try {
      await _service.createUser(user);
    } catch (e) {
      // Handle error and maybe log it
      rethrow;
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await _service.updateUser(user);
    } catch (e) {
      // Handle error and maybe log it
      rethrow;
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _service.deleteUser(id);
    } catch (e) {
      // Handle error and maybe log it
      rethrow;
    }
  }
}
