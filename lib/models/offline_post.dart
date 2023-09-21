class OfflinePost {
  final int id;
  final int userId;
  final String title;
  final String body;

  OfflinePost({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

// Add methods to convert to/from JSON
  factory OfflinePost.fromJson(Map<String, dynamic> json) {
    return OfflinePost(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }
}
