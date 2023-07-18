class Notifications {
  String day;
  String name;
  String notificationText;
  String imageURL;
  String time;
  Notifications(
      {required this.name,
      required this.notificationText,
      required this.imageURL,
      required this.time,
      required this.day});
}

class ChatUsers {
  String name;
  String messageText;
  String imageURL;
  String time;
  ChatUsers(
      {required this.name,
      required this.messageText,
      required this.imageURL,
      required this.time});
}
