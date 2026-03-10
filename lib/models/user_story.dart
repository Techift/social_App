class UserStory {
  final String username;
  final String imageUrl;
  final bool isViewed;

  UserStory({
    required this.username,
    required this.imageUrl,
    this.isViewed = false,
  });
}
