import 'dart:convert';

class WorkspaceClockify {
  WorkspaceClockify({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory WorkspaceClockify.fromMap(Map<String, dynamic> map) {
    return WorkspaceClockify(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkspaceClockify.fromJson(String source) =>
      WorkspaceClockify.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WorkspaceClockify && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
