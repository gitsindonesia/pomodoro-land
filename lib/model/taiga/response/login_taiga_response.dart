import 'dart:convert';

import 'package:flutter/foundation.dart';

class LoginTaigaResponse {
  const LoginTaigaResponse({
    required this.id,
    required this.username,
    required this.fullName,
    required this.fullNameDisplay,
    required this.color,
    required this.bio,
    required this.lang,
    required this.theme,
    required this.timezone,
    required this.isActive,
    required this.photo,
    required this.bigPhoto,
    required this.gravatarId,
    required this.roles,
    required this.totalPrivateProjects,
    required this.totalPublicProjects,
    required this.email,
    required this.uuid,
    required this.dateJoined,
    required this.readNewTerms,
    required this.acceptedTerms,
    required this.maxPrivateProjects,
    required this.maxPublicProjects,
    required this.maxMembershipsPrivateProjects,
    required this.maxMembershipsPublicProjects,
    required this.verifiedEmail,
    required this.refresh,
    required this.authToken,
  });

  final int? id;
  final String? username;
  final String? fullName;
  final String? fullNameDisplay;
  final String? color;
  final String? bio;
  final String? lang;
  final String? theme;
  final String? timezone;
  final bool? isActive;
  final String? photo;
  final String? bigPhoto;
  final String? gravatarId;
  final List<String>? roles;
  final int? totalPrivateProjects;
  final int? totalPublicProjects;
  final String? email;
  final String? uuid;
  final DateTime? dateJoined;
  final bool? readNewTerms;
  final bool? acceptedTerms;
  final dynamic maxPrivateProjects;
  final dynamic maxPublicProjects;
  final dynamic maxMembershipsPrivateProjects;
  final dynamic maxMembershipsPublicProjects;
  final bool? verifiedEmail;
  final String? refresh;
  final String? authToken;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'full_name': fullName,
      'full_name_display': fullNameDisplay,
      'color': color,
      'bio': bio,
      'lang': lang,
      'theme': theme,
      'timezone': timezone,
      'is_active': isActive,
      'photo': photo,
      'big_photo': bigPhoto,
      'gravatar_id': gravatarId,
      'roles': roles,
      'total_private_projects': totalPrivateProjects,
      'total_public_projects': totalPublicProjects,
      'email': email,
      'uuid': uuid,
      'date_joined': dateJoined?.toIso8601String(),
      'read_new_terms': readNewTerms,
      'accepted_terms': acceptedTerms,
      'max_private_projects': maxPrivateProjects,
      'max_public_projects': maxPublicProjects,
      'max_memberships_private_projects': maxMembershipsPrivateProjects,
      'max_memberships_public_projects': maxMembershipsPublicProjects,
      'verified_email': verifiedEmail,
      'refresh': refresh,
      'auth_token': authToken,
    };
  }

  factory LoginTaigaResponse.fromMap(Map<String, dynamic> map) {
    return LoginTaigaResponse(
      id: int.tryParse(map['id']?.toString() ?? ''),
      username: map['username'],
      fullName: map['full_name'],
      fullNameDisplay: map['full_name_display'],
      color: map['color'],
      bio: map['bio'],
      lang: map['lang'],
      theme: map['theme'],
      timezone: map['timezone'],
      isActive: map['is_active'],
      photo: map['photo'],
      bigPhoto: map['big_photo'],
      gravatarId: map['gravatar_id'],
      roles: map['roles'] == null ? null : List.from(map['roles']),
      totalPrivateProjects:
          int.tryParse(map['total_private_projects']?.toString() ?? ''),
      totalPublicProjects:
          int.tryParse(map['total_public_projects']?.toString() ?? ''),
      email: map['email'],
      uuid: map['uuid'],
      dateJoined: DateTime.tryParse(map['date_joined'] ?? ''),
      readNewTerms: map['read_new_terms'],
      acceptedTerms: map['accepted_terms'],
      maxPrivateProjects: map['max_private_projects'],
      maxPublicProjects: map['max_public_projects'],
      maxMembershipsPrivateProjects: map['max_memberships_private_projects'],
      maxMembershipsPublicProjects: map['max_memberships_public_projects'],
      verifiedEmail: map['verified_email'],
      refresh: map['refresh'],
      authToken: map['auth_token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginTaigaResponse.fromJson(String source) =>
      LoginTaigaResponse.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginTaigaResponse &&
        other.id == id &&
        other.username == username &&
        other.fullName == fullName &&
        other.fullNameDisplay == fullNameDisplay &&
        other.color == color &&
        other.bio == bio &&
        other.lang == lang &&
        other.theme == theme &&
        other.timezone == timezone &&
        other.isActive == isActive &&
        other.photo == photo &&
        other.bigPhoto == bigPhoto &&
        other.gravatarId == gravatarId &&
        listEquals(other.roles, roles) &&
        other.totalPrivateProjects == totalPrivateProjects &&
        other.totalPublicProjects == totalPublicProjects &&
        other.email == email &&
        other.uuid == uuid &&
        other.dateJoined == dateJoined &&
        other.readNewTerms == readNewTerms &&
        other.acceptedTerms == acceptedTerms &&
        other.maxPrivateProjects == maxPrivateProjects &&
        other.maxPublicProjects == maxPublicProjects &&
        other.maxMembershipsPrivateProjects == maxMembershipsPrivateProjects &&
        other.maxMembershipsPublicProjects == maxMembershipsPublicProjects &&
        other.verifiedEmail == verifiedEmail &&
        other.refresh == refresh &&
        other.authToken == authToken;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        fullName.hashCode ^
        fullNameDisplay.hashCode ^
        color.hashCode ^
        bio.hashCode ^
        lang.hashCode ^
        theme.hashCode ^
        timezone.hashCode ^
        isActive.hashCode ^
        photo.hashCode ^
        bigPhoto.hashCode ^
        gravatarId.hashCode ^
        roles.hashCode ^
        totalPrivateProjects.hashCode ^
        totalPublicProjects.hashCode ^
        email.hashCode ^
        uuid.hashCode ^
        dateJoined.hashCode ^
        readNewTerms.hashCode ^
        acceptedTerms.hashCode ^
        maxPrivateProjects.hashCode ^
        maxPublicProjects.hashCode ^
        maxMembershipsPrivateProjects.hashCode ^
        maxMembershipsPublicProjects.hashCode ^
        verifiedEmail.hashCode ^
        refresh.hashCode ^
        authToken.hashCode;
  }
}
