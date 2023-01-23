import 'dart:convert';

import 'package:flutter/foundation.dart';

class FilterIssueResponse {
  const FilterIssueResponse({
    required this.types,
    required this.statuses,
    required this.priorities,
    required this.severities,
    required this.assignedTo,
    required this.owners,
    required this.tags,
    required this.roles,
  });

  final List<TypesFilterIssue>? types;
  final List<StatusesFilterIssue>? statuses;
  final List<PrioritiesFilterIssue>? priorities;
  final List<SeveritiesFilterIssue>? severities;
  final List<AssignedToFilterIssue>? assignedTo;
  final List<OwnersFilterIssue>? owners;
  final List<TagsFilterIssue>? tags;
  final List<RolesFilterIssue>? roles;

  Map<String, dynamic> toMap() {
    return {
      'types': types?.map((e) => e.toMap()).toList(),
      'statuses': statuses?.map((e) => e.toMap()).toList(),
      'priorities': priorities?.map((e) => e.toMap()).toList(),
      'severities': severities?.map((e) => e.toMap()).toList(),
      'assigned_to': assignedTo?.map((e) => e.toMap()).toList(),
      'owners': owners?.map((e) => e.toMap()).toList(),
      'tags': tags?.map((e) => e.toMap()).toList(),
      'roles': roles?.map((e) => e.toMap()).toList(),
    };
  }

  factory FilterIssueResponse.fromMap(Map<String, dynamic> map) {
    return FilterIssueResponse(
      types: map['types'] == null
          ? null
          : List.from(
              (map['types'] as List).map((e) => TypesFilterIssue.fromMap(e))),
      statuses: map['statuses'] == null
          ? null
          : List.from((map['statuses'] as List)
              .map((e) => StatusesFilterIssue.fromMap(e))),
      priorities: map['priorities'] == null
          ? null
          : List.from((map['priorities'] as List)
              .map((e) => PrioritiesFilterIssue.fromMap(e))),
      severities: map['severities'] == null
          ? null
          : List.from((map['severities'] as List)
              .map((e) => SeveritiesFilterIssue.fromMap(e))),
      assignedTo: map['assigned_to'] == null
          ? null
          : List.from((map['assigned_to'] as List)
              .map((e) => AssignedToFilterIssue.fromMap(e))),
      owners: map['owners'] == null
          ? null
          : List.from(
              (map['owners'] as List).map((e) => OwnersFilterIssue.fromMap(e))),
      tags: map['tags'] == null
          ? null
          : List.from(
              (map['tags'] as List).map((e) => TagsFilterIssue.fromMap(e))),
      roles: map['roles'] == null
          ? null
          : List.from(
              (map['roles'] as List).map((e) => RolesFilterIssue.fromMap(e))),
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterIssueResponse.fromJson(String source) =>
      FilterIssueResponse.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FilterIssueResponse &&
        listEquals(other.types, types) &&
        listEquals(other.statuses, statuses) &&
        listEquals(other.priorities, priorities) &&
        listEquals(other.severities, severities) &&
        listEquals(other.assignedTo, assignedTo) &&
        listEquals(other.owners, owners) &&
        listEquals(other.tags, tags) &&
        listEquals(other.roles, roles);
  }

  @override
  int get hashCode {
    return types.hashCode ^
        statuses.hashCode ^
        priorities.hashCode ^
        severities.hashCode ^
        assignedTo.hashCode ^
        owners.hashCode ^
        tags.hashCode ^
        roles.hashCode;
  }

  FilterIssueResponse copyWith({
    List<TypesFilterIssue>? types,
    List<StatusesFilterIssue>? statuses,
    List<PrioritiesFilterIssue>? priorities,
    List<SeveritiesFilterIssue>? severities,
    List<AssignedToFilterIssue>? assignedTo,
    List<OwnersFilterIssue>? owners,
    List<TagsFilterIssue>? tags,
    List<RolesFilterIssue>? roles,
  }) {
    return FilterIssueResponse(
      types: types ?? this.types,
      statuses: statuses ?? this.statuses,
      priorities: priorities ?? this.priorities,
      severities: severities ?? this.severities,
      assignedTo: assignedTo ?? this.assignedTo,
      owners: owners ?? this.owners,
      tags: tags ?? this.tags,
      roles: roles ?? this.roles,
    );
  }
}

class TypesFilterIssue {
  const TypesFilterIssue({
    required this.id,
    required this.name,
    required this.color,
    required this.order,
    required this.count,
  });

  final int? id;
  final String? name;
  final String? color;
  final int? order;
  final int? count;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'order': order,
      'count': count,
    };
  }

  factory TypesFilterIssue.fromMap(Map<String, dynamic> map) {
    return TypesFilterIssue(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      color: map['color'],
      order: int.tryParse(map['order']?.toString() ?? ''),
      count: int.tryParse(map['count']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory TypesFilterIssue.fromJson(String source) =>
      TypesFilterIssue.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TypesFilterIssue &&
        other.id == id &&
        other.name == name &&
        other.color == color &&
        other.order == order &&
        other.count == count;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        color.hashCode ^
        order.hashCode ^
        count.hashCode;
  }
}

class StatusesFilterIssue {
  const StatusesFilterIssue({
    required this.id,
    required this.name,
    required this.color,
    required this.order,
    required this.count,
  });

  final int? id;
  final String? name;
  final String? color;
  final int? order;
  final int? count;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'order': order,
      'count': count,
    };
  }

  factory StatusesFilterIssue.fromMap(Map<String, dynamic> map) {
    return StatusesFilterIssue(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      color: map['color'],
      order: int.tryParse(map['order']?.toString() ?? ''),
      count: int.tryParse(map['count']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusesFilterIssue.fromJson(String source) =>
      StatusesFilterIssue.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatusesFilterIssue &&
        other.id == id &&
        other.name == name &&
        other.color == color &&
        other.order == order &&
        other.count == count;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        color.hashCode ^
        order.hashCode ^
        count.hashCode;
  }
}

class PrioritiesFilterIssue {
  const PrioritiesFilterIssue({
    required this.id,
    required this.name,
    required this.color,
    required this.order,
    required this.count,
  });

  final int? id;
  final String? name;
  final String? color;
  final int? order;
  final int? count;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'order': order,
      'count': count,
    };
  }

  factory PrioritiesFilterIssue.fromMap(Map<String, dynamic> map) {
    return PrioritiesFilterIssue(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      color: map['color'],
      order: int.tryParse(map['order']?.toString() ?? ''),
      count: int.tryParse(map['count']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory PrioritiesFilterIssue.fromJson(String source) =>
      PrioritiesFilterIssue.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PrioritiesFilterIssue &&
        other.id == id &&
        other.name == name &&
        other.color == color &&
        other.order == order &&
        other.count == count;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        color.hashCode ^
        order.hashCode ^
        count.hashCode;
  }
}

class SeveritiesFilterIssue {
  const SeveritiesFilterIssue({
    required this.id,
    required this.name,
    required this.color,
    required this.order,
    required this.count,
  });

  final int? id;
  final String? name;
  final String? color;
  final int? order;
  final int? count;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'order': order,
      'count': count,
    };
  }

  factory SeveritiesFilterIssue.fromMap(Map<String, dynamic> map) {
    return SeveritiesFilterIssue(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      color: map['color'],
      order: int.tryParse(map['order']?.toString() ?? ''),
      count: int.tryParse(map['count']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory SeveritiesFilterIssue.fromJson(String source) =>
      SeveritiesFilterIssue.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SeveritiesFilterIssue &&
        other.id == id &&
        other.name == name &&
        other.color == color &&
        other.order == order &&
        other.count == count;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        color.hashCode ^
        order.hashCode ^
        count.hashCode;
  }
}

class AssignedToFilterIssue {
  const AssignedToFilterIssue({
    required this.id,
    required this.fullName,
    required this.count,
  });

  final dynamic id;
  final String? fullName;
  final int? count;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'count': count,
    };
  }

  factory AssignedToFilterIssue.fromMap(Map<String, dynamic> map) {
    return AssignedToFilterIssue(
      id: map['id'],
      fullName: map['full_name'],
      count: int.tryParse(map['count']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory AssignedToFilterIssue.fromJson(String source) =>
      AssignedToFilterIssue.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssignedToFilterIssue &&
        other.id == id &&
        other.fullName == fullName &&
        other.count == count;
  }

  @override
  int get hashCode => id.hashCode ^ fullName.hashCode ^ count.hashCode;
}

class OwnersFilterIssue {
  const OwnersFilterIssue({
    required this.id,
    required this.fullName,
    required this.count,
  });

  final int? id;
  final String? fullName;
  final int? count;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'count': count,
    };
  }

  factory OwnersFilterIssue.fromMap(Map<String, dynamic> map) {
    return OwnersFilterIssue(
      id: int.tryParse(map['id']?.toString() ?? ''),
      fullName: map['full_name'],
      count: int.tryParse(map['count']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory OwnersFilterIssue.fromJson(String source) =>
      OwnersFilterIssue.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OwnersFilterIssue &&
        other.id == id &&
        other.fullName == fullName &&
        other.count == count;
  }

  @override
  int get hashCode => id.hashCode ^ fullName.hashCode ^ count.hashCode;
}

class TagsFilterIssue {
  const TagsFilterIssue({
    required this.name,
    required this.color,
    required this.count,
  });

  final String? name;
  final String? color;
  final int? count;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'color': color,
      'count': count,
    };
  }

  factory TagsFilterIssue.fromMap(Map<String, dynamic> map) {
    return TagsFilterIssue(
      name: map['name'],
      color: map['color'],
      count: int.tryParse(map['count']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory TagsFilterIssue.fromJson(String source) =>
      TagsFilterIssue.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TagsFilterIssue &&
        other.name == name &&
        other.color == color &&
        other.count == count;
  }

  @override
  int get hashCode => name.hashCode ^ color.hashCode ^ count.hashCode;
}

class RolesFilterIssue {
  const RolesFilterIssue({
    required this.id,
    required this.name,
    required this.color,
    required this.order,
    required this.count,
  });

  final int? id;
  final String? name;
  final dynamic color;
  final int? order;
  final int? count;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'order': order,
      'count': count,
    };
  }

  factory RolesFilterIssue.fromMap(Map<String, dynamic> map) {
    return RolesFilterIssue(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      color: map['color'],
      order: int.tryParse(map['order']?.toString() ?? ''),
      count: int.tryParse(map['count']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory RolesFilterIssue.fromJson(String source) =>
      RolesFilterIssue.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RolesFilterIssue &&
        other.id == id &&
        other.name == name &&
        other.color == color &&
        other.order == order &&
        other.count == count;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        color.hashCode ^
        order.hashCode ^
        count.hashCode;
  }
}
