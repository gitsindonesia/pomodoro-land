import 'dart:convert';

import 'package:flutter/foundation.dart';

class IssueResponse {
  const IssueResponse({
    required this.tags,
    required this.dueDate,
    required this.dueDateReason,
    required this.dueDateStatus,
    required this.attachments,
    required this.project,
    required this.projectExtraInfo,
    required this.status,
    required this.statusExtraInfo,
    required this.assignedTo,
    required this.assignedToExtraInfo,
    required this.owner,
    required this.ownerExtraInfo,
    required this.isWatcher,
    required this.totalWatchers,
    required this.isVoter,
    required this.totalVoters,
    required this.id,
    required this.ref,
    required this.severity,
    required this.priority,
    required this.type,
    required this.milestone,
    required this.createdDate,
    required this.modifiedDate,
    required this.finishedDate,
    required this.subject,
    required this.externalReference,
    required this.version,
    required this.watchers,
    required this.isBlocked,
    required this.blockedNote,
    required this.isClosed,
  });

  final dynamic tags;
  final dynamic dueDate;
  final String? dueDateReason;
  final String? dueDateStatus;
  final List<dynamic>? attachments;
  final int? project;
  final ProjectExtraInfoIssue? projectExtraInfo;
  final int? status;
  final StatusExtraInfoIssue? statusExtraInfo;
  final int? assignedTo;
  final AssignedToExtraInfoIssue? assignedToExtraInfo;
  final int? owner;
  final OwnerExtraInfoIssue? ownerExtraInfo;
  final bool? isWatcher;
  final int? totalWatchers;
  final bool? isVoter;
  final int? totalVoters;
  final int? id;
  final int? ref;
  final int? severity;
  final int? priority;
  final int? type;
  final int? milestone;
  final DateTime? createdDate;
  final DateTime? modifiedDate;
  final dynamic finishedDate;
  final String? subject;
  final dynamic externalReference;
  final int? version;
  final List<int>? watchers;
  final bool? isBlocked;
  final String? blockedNote;
  final bool? isClosed;

  Map<String, dynamic> toMap() {
    return {
      'tags': tags,
      'due_date': dueDate,
      'due_date_reason': dueDateReason,
      'due_date_status': dueDateStatus,
      'attachments': attachments,
      'project': project,
      'project_extra_info': projectExtraInfo?.toMap(),
      'status': status,
      'status_extra_info': statusExtraInfo?.toMap(),
      'assigned_to': assignedTo,
      'assigned_to_extra_info': assignedToExtraInfo?.toMap(),
      'owner': owner,
      'owner_extra_info': ownerExtraInfo?.toMap(),
      'is_watcher': isWatcher,
      'total_watchers': totalWatchers,
      'is_voter': isVoter,
      'total_voters': totalVoters,
      'id': id,
      'ref': ref,
      'severity': severity,
      'priority': priority,
      'type': type,
      'milestone': milestone,
      'created_date': createdDate?.toIso8601String(),
      'modified_date': modifiedDate?.toIso8601String(),
      'finished_date': finishedDate,
      'subject': subject,
      'external_reference': externalReference,
      'version': version,
      'watchers': watchers,
      'is_blocked': isBlocked,
      'blocked_note': blockedNote,
      'is_closed': isClosed,
    };
  }

  factory IssueResponse.fromMap(Map<String, dynamic> map) {
    return IssueResponse(
      tags: map['tags'],
      dueDate: map['due_date'],
      dueDateReason: map['due_date_reason'],
      dueDateStatus: map['due_date_status'],
      attachments: map['attachments'],
      project: int.tryParse(map['project']?.toString() ?? ''),
      projectExtraInfo: map['project_extra_info'] == null
          ? null
          : ProjectExtraInfoIssue.fromMap(map['project_extra_info']),
      status: int.tryParse(map['status']?.toString() ?? ''),
      statusExtraInfo: map['status_extra_info'] == null
          ? null
          : StatusExtraInfoIssue.fromMap(map['status_extra_info']),
      assignedTo: int.tryParse(map['assigned_to']?.toString() ?? ''),
      assignedToExtraInfo: map['assigned_to_extra_info'] == null
          ? null
          : AssignedToExtraInfoIssue.fromMap(map['assigned_to_extra_info']),
      owner: int.tryParse(map['owner']?.toString() ?? ''),
      ownerExtraInfo: map['owner_extra_info'] == null
          ? null
          : OwnerExtraInfoIssue.fromMap(map['owner_extra_info']),
      isWatcher: map['is_watcher'],
      totalWatchers: int.tryParse(map['total_watchers']?.toString() ?? ''),
      isVoter: map['is_voter'],
      totalVoters: int.tryParse(map['total_voters']?.toString() ?? ''),
      id: int.tryParse(map['id']?.toString() ?? ''),
      ref: int.tryParse(map['ref']?.toString() ?? ''),
      severity: int.tryParse(map['severity']?.toString() ?? ''),
      priority: int.tryParse(map['priority']?.toString() ?? ''),
      type: int.tryParse(map['type']?.toString() ?? ''),
      milestone: int.tryParse(map['milestone']?.toString() ?? ''),
      createdDate: DateTime.tryParse(map['created_date'] ?? ''),
      modifiedDate: DateTime.tryParse(map['modified_date'] ?? ''),
      finishedDate: map['finished_date'],
      subject: map['subject'],
      externalReference: map['external_reference'],
      version: int.tryParse(map['version']?.toString() ?? ''),
      watchers: map['watchers'] == null ? null : List.from(map['watchers']),
      isBlocked: map['is_blocked'],
      blockedNote: map['blocked_note'],
      isClosed: map['is_closed'],
    );
  }

  String toJson() => json.encode(toMap());

  factory IssueResponse.fromJson(String source) =>
      IssueResponse.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IssueResponse &&
        other.tags == tags &&
        other.dueDate == dueDate &&
        other.dueDateReason == dueDateReason &&
        other.dueDateStatus == dueDateStatus &&
        listEquals(other.attachments, attachments) &&
        other.project == project &&
        other.projectExtraInfo == projectExtraInfo &&
        other.status == status &&
        other.statusExtraInfo == statusExtraInfo &&
        other.assignedTo == assignedTo &&
        other.assignedToExtraInfo == assignedToExtraInfo &&
        other.owner == owner &&
        other.ownerExtraInfo == ownerExtraInfo &&
        other.isWatcher == isWatcher &&
        other.totalWatchers == totalWatchers &&
        other.isVoter == isVoter &&
        other.totalVoters == totalVoters &&
        other.id == id &&
        other.ref == ref &&
        other.severity == severity &&
        other.priority == priority &&
        other.type == type &&
        other.milestone == milestone &&
        other.createdDate == createdDate &&
        other.modifiedDate == modifiedDate &&
        other.finishedDate == finishedDate &&
        other.subject == subject &&
        other.externalReference == externalReference &&
        other.version == version &&
        listEquals(other.watchers, watchers) &&
        other.isBlocked == isBlocked &&
        other.blockedNote == blockedNote &&
        other.isClosed == isClosed;
  }

  @override
  int get hashCode {
    return tags.hashCode ^
        dueDate.hashCode ^
        dueDateReason.hashCode ^
        dueDateStatus.hashCode ^
        attachments.hashCode ^
        project.hashCode ^
        projectExtraInfo.hashCode ^
        status.hashCode ^
        statusExtraInfo.hashCode ^
        assignedTo.hashCode ^
        assignedToExtraInfo.hashCode ^
        owner.hashCode ^
        ownerExtraInfo.hashCode ^
        isWatcher.hashCode ^
        totalWatchers.hashCode ^
        isVoter.hashCode ^
        totalVoters.hashCode ^
        id.hashCode ^
        ref.hashCode ^
        severity.hashCode ^
        priority.hashCode ^
        type.hashCode ^
        milestone.hashCode ^
        createdDate.hashCode ^
        modifiedDate.hashCode ^
        finishedDate.hashCode ^
        subject.hashCode ^
        externalReference.hashCode ^
        version.hashCode ^
        watchers.hashCode ^
        isBlocked.hashCode ^
        blockedNote.hashCode ^
        isClosed.hashCode;
  }

  IssueResponse copyWith({
    dynamic tags,
    dynamic dueDate,
    String? dueDateReason,
    String? dueDateStatus,
    List<dynamic>? attachments,
    int? project,
    ProjectExtraInfoIssue? projectExtraInfo,
    int? status,
    StatusExtraInfoIssue? statusExtraInfo,
    int? assignedTo,
    AssignedToExtraInfoIssue? assignedToExtraInfo,
    int? owner,
    OwnerExtraInfoIssue? ownerExtraInfo,
    bool? isWatcher,
    int? totalWatchers,
    bool? isVoter,
    int? totalVoters,
    int? id,
    int? ref,
    int? severity,
    int? priority,
    int? type,
    int? milestone,
    DateTime? createdDate,
    DateTime? modifiedDate,
    dynamic finishedDate,
    String? subject,
    dynamic externalReference,
    int? version,
    List<int>? watchers,
    bool? isBlocked,
    String? blockedNote,
    bool? isClosed,
  }) {
    return IssueResponse(
      tags: tags ?? this.tags,
      dueDate: dueDate ?? this.dueDate,
      dueDateReason: dueDateReason ?? this.dueDateReason,
      dueDateStatus: dueDateStatus ?? this.dueDateStatus,
      attachments: attachments ?? this.attachments,
      project: project ?? this.project,
      projectExtraInfo: projectExtraInfo ?? this.projectExtraInfo,
      status: status ?? this.status,
      statusExtraInfo: statusExtraInfo ?? this.statusExtraInfo,
      assignedTo: assignedTo ?? this.assignedTo,
      assignedToExtraInfo: assignedToExtraInfo ?? this.assignedToExtraInfo,
      owner: owner ?? this.owner,
      ownerExtraInfo: ownerExtraInfo ?? this.ownerExtraInfo,
      isWatcher: isWatcher ?? this.isWatcher,
      totalWatchers: totalWatchers ?? this.totalWatchers,
      isVoter: isVoter ?? this.isVoter,
      totalVoters: totalVoters ?? this.totalVoters,
      id: id ?? this.id,
      ref: ref ?? this.ref,
      severity: severity ?? this.severity,
      priority: priority ?? this.priority,
      type: type ?? this.type,
      milestone: milestone ?? this.milestone,
      createdDate: createdDate ?? this.createdDate,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      finishedDate: finishedDate ?? this.finishedDate,
      subject: subject ?? this.subject,
      externalReference: externalReference ?? this.externalReference,
      version: version ?? this.version,
      watchers: watchers ?? this.watchers,
      isBlocked: isBlocked ?? this.isBlocked,
      blockedNote: blockedNote ?? this.blockedNote,
      isClosed: isClosed ?? this.isClosed,
    );
  }
}

class ProjectExtraInfoIssue {
  const ProjectExtraInfoIssue({
    required this.name,
    required this.slug,
    required this.logoSmallUrl,
    required this.id,
  });

  final String? name;
  final String? slug;
  final dynamic logoSmallUrl;
  final int? id;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'slug': slug,
      'logo_small_url': logoSmallUrl,
      'id': id,
    };
  }

  factory ProjectExtraInfoIssue.fromMap(Map<String, dynamic> map) {
    return ProjectExtraInfoIssue(
      name: map['name'],
      slug: map['slug'],
      logoSmallUrl: map['logo_small_url'],
      id: int.tryParse(map['id']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectExtraInfoIssue.fromJson(String source) =>
      ProjectExtraInfoIssue.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProjectExtraInfoIssue &&
        other.name == name &&
        other.slug == slug &&
        other.logoSmallUrl == logoSmallUrl &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^ slug.hashCode ^ logoSmallUrl.hashCode ^ id.hashCode;
  }
}

class StatusExtraInfoIssue {
  const StatusExtraInfoIssue({
    required this.name,
    required this.color,
    required this.isClosed,
  });

  final String? name;
  final String? color;
  final bool? isClosed;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'color': color,
      'is_closed': isClosed,
    };
  }

  factory StatusExtraInfoIssue.fromMap(Map<String, dynamic> map) {
    return StatusExtraInfoIssue(
      name: map['name'],
      color: map['color'],
      isClosed: map['is_closed'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusExtraInfoIssue.fromJson(String source) =>
      StatusExtraInfoIssue.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatusExtraInfoIssue &&
        other.name == name &&
        other.color == color &&
        other.isClosed == isClosed;
  }

  @override
  int get hashCode => name.hashCode ^ color.hashCode ^ isClosed.hashCode;

  StatusExtraInfoIssue copyWith({
    String? name,
    String? color,
    bool? isClosed,
  }) {
    return StatusExtraInfoIssue(
      name: name ?? this.name,
      color: color ?? this.color,
      isClosed: isClosed ?? this.isClosed,
    );
  }
}

class AssignedToExtraInfoIssue {
  const AssignedToExtraInfoIssue({
    required this.username,
    required this.fullNameDisplay,
    required this.photo,
    required this.bigPhoto,
    required this.gravatarId,
    required this.isActive,
    required this.id,
  });

  final String? username;
  final String? fullNameDisplay;
  final dynamic photo;
  final dynamic bigPhoto;
  final String? gravatarId;
  final bool? isActive;
  final int? id;

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'full_name_display': fullNameDisplay,
      'photo': photo,
      'big_photo': bigPhoto,
      'gravatar_id': gravatarId,
      'is_active': isActive,
      'id': id,
    };
  }

  factory AssignedToExtraInfoIssue.fromMap(Map<String, dynamic> map) {
    return AssignedToExtraInfoIssue(
      username: map['username'],
      fullNameDisplay: map['full_name_display'],
      photo: map['photo'],
      bigPhoto: map['big_photo'],
      gravatarId: map['gravatar_id'],
      isActive: map['is_active'],
      id: int.tryParse(map['id']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory AssignedToExtraInfoIssue.fromJson(String source) =>
      AssignedToExtraInfoIssue.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssignedToExtraInfoIssue &&
        other.username == username &&
        other.fullNameDisplay == fullNameDisplay &&
        other.photo == photo &&
        other.bigPhoto == bigPhoto &&
        other.gravatarId == gravatarId &&
        other.isActive == isActive &&
        other.id == id;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        fullNameDisplay.hashCode ^
        photo.hashCode ^
        bigPhoto.hashCode ^
        gravatarId.hashCode ^
        isActive.hashCode ^
        id.hashCode;
  }
}

class OwnerExtraInfoIssue {
  const OwnerExtraInfoIssue({
    required this.username,
    required this.fullNameDisplay,
    required this.photo,
    required this.bigPhoto,
    required this.gravatarId,
    required this.isActive,
    required this.id,
  });

  final String? username;
  final String? fullNameDisplay;
  final String? photo;
  final String? bigPhoto;
  final String? gravatarId;
  final bool? isActive;
  final int? id;

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'full_name_display': fullNameDisplay,
      'photo': photo,
      'big_photo': bigPhoto,
      'gravatar_id': gravatarId,
      'is_active': isActive,
      'id': id,
    };
  }

  factory OwnerExtraInfoIssue.fromMap(Map<String, dynamic> map) {
    return OwnerExtraInfoIssue(
      username: map['username'],
      fullNameDisplay: map['full_name_display'],
      photo: map['photo'],
      bigPhoto: map['big_photo'],
      gravatarId: map['gravatar_id'],
      isActive: map['is_active'],
      id: int.tryParse(map['id']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory OwnerExtraInfoIssue.fromJson(String source) =>
      OwnerExtraInfoIssue.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OwnerExtraInfoIssue &&
        other.username == username &&
        other.fullNameDisplay == fullNameDisplay &&
        other.photo == photo &&
        other.bigPhoto == bigPhoto &&
        other.gravatarId == gravatarId &&
        other.isActive == isActive &&
        other.id == id;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        fullNameDisplay.hashCode ^
        photo.hashCode ^
        bigPhoto.hashCode ^
        gravatarId.hashCode ^
        isActive.hashCode ^
        id.hashCode;
  }
}
