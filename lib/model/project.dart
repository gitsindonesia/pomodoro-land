import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pomodoro_land/utils/extension.dart';

class Project {
  Project({
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

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      color: map['color']?.toString().toColor(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Project &&
        other.id == id &&
        other.name == name &&
        other.color == color;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ color.hashCode;
}
