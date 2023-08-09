class ProfileModel {
  const ProfileModel({
    required this.name,
    required this.following,
    required this.followers,
  });

  final String name;
  final String following;
  final String followers;
}

ProfileModel profileUser = const ProfileModel(
  name: 'Ahmad',
  following: '1200',
  followers: '800',
);
