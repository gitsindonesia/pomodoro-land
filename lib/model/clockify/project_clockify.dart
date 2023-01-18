import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pomodoro_land/utils/extension.dart';

class ProjectClockify {
  ProjectClockify({
    required this.id,
    required this.name,
    this.color,
  });

  final String id;
  final String name;
  final Color? color;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color?.toHex(),
    };
  }

  factory ProjectClockify.fromMap(Map<String, dynamic> map) {
    return ProjectClockify(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      color: map['color']?.toString().toColor(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectClockify.fromJson(String source) =>
      ProjectClockify.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProjectClockify &&
        other.id == id &&
        other.name == name &&
        other.color == color;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ color.hashCode;
}
