class LegalNotificationModel {

  final String title;

  final String message;

  final String time;

  final String type;

  bool isRead;

  LegalNotificationModel({

    required this.title,

    required this.message,

    required this.time,

    required this.type,

    this.isRead = false,
  });
}