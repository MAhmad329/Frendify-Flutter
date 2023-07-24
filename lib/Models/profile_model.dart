class ProfileInfo {
  const ProfileInfo({
    required this.name,
    required this.following,
    required this.followers,
  });

  final String name;
  final String following;
  final String followers;
}

ProfileInfo profileUser = const ProfileInfo(
  name: 'Ahmad',
  following: '1200',
  followers: '800',
);
