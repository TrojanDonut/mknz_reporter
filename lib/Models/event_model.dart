class EventModel{
  final String eventId;
  final String cover;
  final String title;
  final String description;
  final String startTime;

  EventModel({
    required this.eventId,
    required this.cover,
    required this.title,
    required this.description,
    required this.startTime,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventId: json['id'],
      cover: json['cover']['source'],
      title: json['name'],
      description: json['description'],
      startTime: json['start_time']
    );
  }
}