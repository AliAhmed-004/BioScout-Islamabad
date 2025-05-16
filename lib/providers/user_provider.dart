import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  // All users in the app (mocked)
  final Map<String, UserModel> _users = {
    'u123': UserModel.mock(id: 'u123', name: 'GreenGuardian'),
    'u456': UserModel.mock(id: 'u456', name: 'NatureNerd'),
    'u789': UserModel.mock(id: 'u789', name: 'TrailWatcher'),
  };

  // Current active user (who is posting)
  late UserModel _currentUser;

  UserModel get currentUser => _currentUser;

  Map<String, UserModel> get users => _users;

  UserModel? getUserById(String id) => _users[id];

  void loadMockUser({String userId = 'u123'}) {
    _currentUser = _users[userId]!;
  }

  void incrementPostCountFor(String userId) {
    final user = _users[userId];
    if (user != null) {
      user.incrementPostCount();

      // Example badge logic
      if (user.postCount >= 5 && !user.badges.contains("Top Observer")) {
        user.addBadge("Top Observer");
      }

      // If the updated user is also the current user, notify UI
      if (user.id == _currentUser.id) notifyListeners();
    }
  }

  void addBadgeTo(String userId, String badge) {
    final user = _users[userId];
    if (user != null) {
      user.addBadge(badge);
      if (user.id == _currentUser.id) notifyListeners();
    }
  }

  void switchUser(String userId) {
    if (_users.containsKey(userId)) {
      _currentUser = _users[userId]!;
      notifyListeners();
    }
  }
}
