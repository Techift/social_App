import 'package:social_app/models/user_model.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  
  late User? _currentUser;
  final List<User> _registeredUsers = [];

  AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  // Register a new user
  bool register(String username, String email, String phoneNumber, String password) {
    // Validate input
    if (username.isEmpty || email.isEmpty || phoneNumber.isEmpty || password.isEmpty) {
      return false;
    }
    
    if (password.length < 6) {
      return false;
    }

    // Check if user already exists
    if (_registeredUsers.any((user) => user.email == email)) {
      return false;
    }

    // Register new user
    final newUser = User(
      username: username,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
    );
    _registeredUsers.add(newUser);
    _currentUser = newUser;
    return true;
  }

  // Login
  bool login(String email, String password) {
    // Validate input
    if (email.isEmpty || password.isEmpty) {
      return false;
    }

    // Find user with matching credentials
    final user = _registeredUsers.firstWhere(
      (u) => u.email == email && u.password == password,
      orElse: () => throw Exception('User not found'),
    );

    if (user.email == email && user.password == password) {
      _currentUser = user;
      return true;
    }
    return false;
  }

  // Forgot password - reset password for user with matching email
  bool resetPassword(String emailOrPhone, String newPassword) {
    if (emailOrPhone.isEmpty || newPassword.isEmpty) {
      return false;
    }

    if (newPassword.length < 6) {
      return false;
    }

    try {
      final userIndex = _registeredUsers.indexWhere(
        (u) => u.email == emailOrPhone || u.phoneNumber == emailOrPhone,
      );

      if (userIndex != -1) {
        _registeredUsers[userIndex] = User(
          username: _registeredUsers[userIndex].username,
          email: _registeredUsers[userIndex].email,
          phoneNumber: _registeredUsers[userIndex].phoneNumber,
          password: newPassword,
        );
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Logout
  void logout() {
    _currentUser = null;
  }
}
