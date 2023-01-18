import 'dart:convert';

class ProjectTaigaResponse {
  const ProjectTaigaResponse({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.logoSmallUrl,
  });

  final int? id;
  final String? name;
  final String? slug;
  final String? description;
  final String? logoSmallUrl;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'logo_small_url': logoSmallUrl,
    };
  }

  factory ProjectTaigaResponse.fromMap(Map<String, dynamic> map) {
    return ProjectTaigaResponse(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      slug: map['slug'],
      description: map['description'],
      logoSmallUrl: map['logo_small_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectTaigaResponse.fromJson(String source) =>
      ProjectTaigaResponse.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProjectTaigaResponse &&
        other.id == id &&
        other.name == name &&
        other.slug == slug &&
        other.description == description &&
        other.logoSmallUrl == logoSmallUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        slug.hashCode ^
        description.hashCode ^
        logoSmallUrl.hashCode;
  }
}
