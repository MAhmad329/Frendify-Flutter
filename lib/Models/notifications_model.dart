class NotificationItem {
  String name;
  String notificationText;
  String imageURL;
  String time;
  String day;

  NotificationItem({
    required this.name,
    required this.notificationText,
    required this.imageURL,
    required this.time,
    required this.day,
  });
}

final List<NotificationItem> notifications = [
  NotificationItem(
    day: 'Today',
    name: 'John Doe',
    notificationText:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    imageURL: 'assets/profile.jpeg',
    time: '10:00 AM',
  ),
  NotificationItem(
    day: 'Today',
    name: 'Jane Smith',
    notificationText:
        'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    imageURL: 'assets/profile.jpeg',
    time: '12:30 PM',
  ),
  NotificationItem(
    day: 'Yesterday',
    name: 'Alice Johnson',
    notificationText:
        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
    imageURL: 'assets/profile.jpeg',
    time: '9:45 AM',
  ),
  NotificationItem(
    day: 'This Weekend',
    name: 'Alice Johnson',
    notificationText:
        'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore.',
    imageURL: 'assets/profile.jpeg',
    time: '3:00 PM',
  ),
  // Add more notifications here...
];
