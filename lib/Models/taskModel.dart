
class TaskModel {
  String? id;
  String title;
  String description;
  String? imageUrl;
  DateTime? createdAt;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    this.createdAt,
  });

  //  Convert TaskModel to Map (for Firestore if needed)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  //  Create TaskModel from Map (if loading from Firestore)
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'],
      createdAt:
      map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
    );
  }
}


