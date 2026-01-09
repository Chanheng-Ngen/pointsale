import '../models/user_model.dart';

class UserService {
  // This is where you would implement actual API calls
  // For now, we'll use mock data

  Future<List<UserModel>> getUsers() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock data
    return [
      UserModel(
        id: '1',
        name: 'John Doe',
        email: 'john@example.com',
        phone: '123-456-7890',
      ),
      UserModel(
        id: '2',
        name: 'Jane Smith',
        email: 'jane@example.com',
        phone: '098-765-4321',
      ),
    ];
  }

  Future<UserModel?> getUserById(String id) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Mock data
    if (id == '1') {
      return UserModel(
        id: '1',
        name: 'John Doe',
        email: 'john@example.com',
        phone: '123-456-7890',
      );
    }
    return null;
  }

  Future<void> createUser(UserModel user) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Here you would typically make a POST request to your API
    // Example: await http.post('your-api-url', body: user.toJson());
  }

  Future<void> updateUser(UserModel user) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Here you would typically make a PUT request to your API
    // Example: await http.put('your-api-url/${user.id}', body: user.toJson());
  }

  Future<void> deleteUser(String id) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Here you would typically make a DELETE request to your API
    // Example: await http.delete('your-api-url/$id');
  }
}
