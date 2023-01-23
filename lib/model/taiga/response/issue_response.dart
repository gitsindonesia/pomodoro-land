import 'dart:convert';

import 'package:flutter/foundation.dart';

class IssueResponse {
  const IssueResponse({
    required this.assignedTo,
    required this.assignedToExtraInfo,
    required this.attachments,
    required this.blockedNote,
    required this.createdDate,
    required this.dueDate,
    required this.dueDateReason,
    required this.dueDateStatus,
    required this.externalReference,
    required this.finishedDate,
    required this.id,
    required this.isBlocked,
    required this.isClosed,
    required this.isVoter,
    required this.isWatcher,
    required this.milestone,
    required this.modifiedDate,
    required this.owner,
    required this.ownerExtraInfo,
    required this.priority,
    required this.project,
    required this.projectExtraInfo,
    required this.ref,
    required this.severity,
    required this.status,
    required this.statusExtraInfo,
    required this.subject,
    required this.tags,
    required this.totalVoters,
    required this.totalWatchers,
    required this.type,
    required this.version,
    required this.watchers,
  });

  final dynamic assignedTo;
  final dynamic assignedToExtraInfo;
  final List<dynamic>? attachments;
  final String? blockedNote;
  final DateTime? createdDate;
  final dynamic dueDate;
  final String? dueDateReason;
  final String? dueDateStatus;
  final dynamic externalReference;
  final dynamic finishedDate;
  final int? id;
  final bool? isBlocked;
  final bool? isClosed;
  final bool? isVoter;
  final bool? isWatcher;
  final dynamic milestone;
  final DateTime? modifiedDate;
  final int? owner;
  final OwnerExtraInfoIssue? ownerExtraInfo;
  final int? priority;
  final int? project;
  final ProjectExtraInfoIssue? projectExtraInfo;
  final int? ref;
  final int? severity;
  final int? status;
  final StatusExtraInfoIssue? statusExtraInfo;
  final String? subject;
  final dynamic tags;
  final int? totalVoters;
  final int? totalWatchers;
  final int? type;
  final int? version;
  final List<int>? watchers;

  Map<String, dynamic> toMap() {
    return {
      'assigned_to': assignedTo,
      'assigned_to_extra_info': assignedToExtraInfo,
      'attachments': attachments,
      'blocked_note': blockedNote,
      'created_date': createdDate?.toIso8601String(),
      'due_date': dueDate,
      'due_date_reason': dueDateReason,
      'due_date_status': dueDateStatus,
      'external_reference': externalReference,
      'finished_date': finishedDate,
      'id': id,
      'is_blocked': isBlocked,
      'is_closed': isClosed,
      'is_voter': isVoter,
      'is_watcher': isWatcher,
      'milestone': milestone,
      'modified_date': modifiedDate?.toIso8601String(),
      'owner': owner,
      'owner_extra_info': ownerExtraInfo?.toMap(),
      'priority': priority,
      'project': project,
      'project_extra_info': projectExtraInfo?.toMap(),
      'ref': ref,
      'severity': severity,
      'status': status,
      'status_extra_info': statusExtraInfo?.toMap(),
      'subject': subject,
      'tags': tags,
      'total_voters': totalVoters,
      'total_watchers': totalWatchers,
      'type': type,
      'version': version,
      'watchers': watchers,
    };
  }

  factory IssueResponse.fromMap(Map<String, dynamic> map) {
    return IssueResponse(
      assignedTo: map['assigned_to'],
      assignedToExtraInfo: map['assigned_to_extra_info'],
      attachments: map['attachments'],
      blockedNote: map['blocked_note'],
      createdDate: DateTime.tryParse(map['created_date'] ?? ''),
      dueDate: map['due_date'],
      dueDateReason: map['due_date_reason'],
      dueDateStatus: map['due_date_status'],
      externalReference: map['external_reference'],
      finishedDate: map['finished_date'],
      id: int.tryParse(map['id']?.toString() ?? ''),
      isBlocked: map['is_blocked'],
      isClosed: map['is_closed'],
      isVoter: map['is_voter'],
      isWatcher: map['is_watcher'],
      milestone: map['milestone'],
      modifiedDate: DateTime.tryParse(map['modified_date'] ?? ''),
      owner: int.tryParse(map['owner']?.toString() ?? ''),
      ownerExtraInfo: map['owner_extra_info'] == null
          ? null
          : OwnerExtraInfoIssue.fromMap(map['owner_extra_info']),
      priority: int.tryParse(map['priority']?.toString() ?? ''),
      project: int.tryParse(map['project']?.toString() ?? ''),
      projectExtraInfo: map['project_extra_info'] == null
          ? null
          : ProjectExtraInfoIssue.fromMap(map['project_extra_info']),
      ref: int.tryParse(map['ref']?.toString() ?? ''),
      severity: int.tryParse(map['severity']?.toString() ?? ''),
      status: int.tryParse(map['status']?.toString() ?? ''),
      statusExtraInfo: map['status_extra_info'] == null
          ? null
          : StatusExtraInfoIssue.fromMap(map['status_extra_info']),
      subject: map['subject'],
      tags: map['tags'],
      totalVoters: int.tryParse(map['total_voters']?.toString() ?? ''),
      totalWatchers: int.tryParse(map['total_watchers']?.toString() ?? ''),
      type: int.tryParse(map['type']?.toString() ?? ''),
      version: int.tryParse(map['version']?.toString() ?? ''),
      watchers: map['watchers'] == null ? null : List.from(map['watchers']),
    );
  }

  String toJson() => json.encode(toMap());

  factory IssueResponse.fromJson(String source) =>
      IssueResponse.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IssueResponse &&
        other.assignedTo == assignedTo &&
        other.assignedToExtraInfo == assignedToExtraInfo &&
        listEquals(other.attachments, attachments) &&
        other.blockedNote == blockedNote &&
        other.createdDate == createdDate &&
        other.dueDate == dueDate &&
        other.dueDateReason == dueDateReason &&
        other.dueDateStatus == dueDateStatus &&
        other.externalReference == externalReference &&
        other.finishedDate == finishedDate &&
        other.id == id &&
        other.isBlocked == isBlocked &&
        other.isClosed == isClosed &&
        other.isVoter == isVoter &&
        other.isWatcher == isWatcher &&
        other.milestone == milestone &&
        other.modifiedDate == modifiedDate &&
        other.owner == owner &&
        other.ownerExtraInfo == ownerExtraInfo &&
        other.priority == priority &&
        other.project == project &&
        other.projectExtraInfo == projectExtraInfo &&
        other.ref == ref &&
        other.severity == severity &&
        other.status == status &&
        other.statusExtraInfo == statusExtraInfo &&
        other.subject == subject &&
        other.tags == tags &&
        other.totalVoters == totalVoters &&
        other.totalWatchers == totalWatchers &&
        other.type == type &&
        other.version == version &&
        listEquals(other.watchers, watchers);
  }

  @override
  int get hashCode {
    return assignedTo.hashCode ^
        assignedToExtraInfo.hashCode ^
        attachments.hashCode ^
        blockedNote.hashCode ^
        createdDate.hashCode ^
        dueDate.hashCode ^
        dueDateReason.hashCode ^
        dueDateStatus.hashCode ^
        externalReference.hashCode ^
        finishedDate.hashCode ^
        id.hashCode ^
        isBlocked.hashCode ^
        isClosed.hashCode ^
        isVoter.hashCode ^
        isWatcher.hashCode ^
        milestone.hashCode ^
        modifiedDate.hashCode ^
        owner.hashCode ^
        ownerExtraInfo.hashCode ^
        priority.hashCode ^
        project.hashCode ^
        projectExtraInfo.hashCode ^
        ref.hashCode ^
        severity.hashCode ^
        status.hashCode ^
        statusExtraInfo.hashCode ^
        subject.hashCode ^
        tags.hashCode ^
        totalVoters.hashCode ^
        totalWatchers.hashCode ^
        type.hashCode ^
        version.hashCode ^
        watchers.hashCode;
  }
}

class OwnerExtraInfoIssue {
  const OwnerExtraInfoIssue({
    required this.bigPhoto,
    required this.fullNameDisplay,
    required this.gravatarId,
    required this.id,
    required this.isActive,
    required this.photo,
    required this.username,
  });

  final dynamic bigPhoto;
  final String? fullNameDisplay;
  final String? gravatarId;
  final int? id;
  final bool? isActive;
  final dynamic photo;
  final String? username;

  Map<String, dynamic> toMap() {
    return {
      'big_photo': bigPhoto,
      'full_name_display': fullNameDisplay,
      'gravatar_id': gravatarId,
      'id': id,
      'is_active': isActive,
      'photo': photo,
      'username': username,
    };
  }

  factory OwnerExtraInfoIssue.fromMap(Map<String, dynamic> map) {
    return OwnerExtraInfoIssue(
      bigPhoto: map['big_photo'],
      fullNameDisplay: map['full_name_display'],
      gravatarId: map['gravatar_id'],
      id: int.tryParse(map['id']?.toString() ?? ''),
      isActive: map['is_active'],
      photo: map['photo'],
      username: map['username'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OwnerExtraInfoIssue.fromJson(String source) =>
      OwnerExtraInfoIssue.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OwnerExtraInfoIssue &&
        other.bigPhoto == bigPhoto &&
        other.fullNameDisplay == fullNameDisplay &&
        other.gravatarId == gravatarId &&
        other.id == id &&
        other.isActive == isActive &&
        other.photo == photo &&
        other.username == username;
  }

  @override
  int get hashCode {
    return bigPhoto.hashCode ^
        fullNameDisplay.hashCode ^
        gravatarId.hashCode ^
        id.hashCode ^
        isActive.hashCode ^
        photo.hashCode ^
        username.hashCode;
  }
}

class ProjectExtraInfoIssue {
  const ProjectExtraInfoIssue({
    required this.id,
    required this.logoSmallUrl,
    required this.name,
    required this.slug,
  });

  final int? id;
  final dynamic logoSmallUrl;
  final String? name;
  final String? slug;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'logo_small_url': logoSmallUrl,
      'name': name,
      'slug': slug,
    };
  }

  factory ProjectExtraInfoIssue.fromMap(Map<String, dynamic> map) {
    return ProjectExtraInfoIssue(
      id: int.tryParse(map['id']?.toString() ?? ''),
      logoSmallUrl: map['logo_small_url'],
      name: map['name'],
      slug: map['slug'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectExtraInfoIssue.fromJson(String source) =>
      ProjectExtraInfoIssue.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProjectExtraInfoIssue &&
        other.id == id &&
        other.logoSmallUrl == logoSmallUrl &&
        other.name == name &&
        other.slug == slug;
  }

  @override
  int get hashCode {
    return id.hashCode ^ logoSmallUrl.hashCode ^ name.hashCode ^ slug.hashCode;
  }
}

class StatusExtraInfoIssue {
  const StatusExtraInfoIssue({
    required this.color,
    required this.isClosed,
    required this.name,
  });

  final String? color;
  final bool? isClosed;
  final String? name;

  Map<String, dynamic> toMap() {
    return {
      'color': color,
      'is_closed': isClosed,
      'name': name,
    };
  }

  factory StatusExtraInfoIssue.fromMap(Map<String, dynamic> map) {
    return StatusExtraInfoIssue(
      color: map['color'],
      isClosed: map['is_closed'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusExtraInfoIssue.fromJson(String source) =>
      StatusExtraInfoIssue.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatusExtraInfoIssue &&
        other.color == color &&
        other.isClosed == isClosed &&
        other.name == name;
  }

  @override
  int get hashCode => color.hashCode ^ isClosed.hashCode ^ name.hashCode;
}
