class UserModel {
  final String id;
  final String name;
  final String avatarUrl;
  int postCount;
  List<String> badges;

  UserModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.postCount = 0,
    this.badges = const [],
  });

  factory UserModel.mock({
    required String id,
    String? name,
    String? avatarUrl,
    int postCount = 0,
    List<String> badges = const [],
  }) {
    return UserModel(
      id: id,
      name: name ?? 'Observer $id',
      avatarUrl: avatarUrl ?? 'https://i.pravatar.cc/150?u=$id',
      postCount: postCount,
      badges: badges,
    );
  }

  void incrementPostCount() {
    postCount++;
  }

  void addBadge(String badge) {
    if (!badges.contains(badge)) {
      badges.add(badge);
    }
  }
}
