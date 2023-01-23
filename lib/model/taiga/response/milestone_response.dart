import 'dart:convert';

import 'package:flutter/foundation.dart';

class MilestoneResponse {
  const MilestoneResponse({
    required this.project,
    required this.projectExtraInfo,
    required this.id,
    required this.name,
    required this.slug,
    required this.owner,
    required this.estimatedStart,
    required this.estimatedFinish,
    required this.createdDate,
    required this.modifiedDate,
    required this.closed,
    required this.disponibility,
    required this.order,
    required this.userStories,
    required this.totalPoints,
    required this.closedPoints,
  });

  final int? project;
  final ProjectExtraInfoMilestone? projectExtraInfo;
  final int? id;
  final String? name;
  final String? slug;
  final int? owner;
  final DateTime? estimatedStart;
  final DateTime? estimatedFinish;
  final DateTime? createdDate;
  final DateTime? modifiedDate;
  final bool? closed;
  final double? disponibility;
  final int? order;
  final List<UserStoriesMilestone>? userStories;
  final double? totalPoints;
  final dynamic closedPoints;

  Map<String, dynamic> toMap() {
    return {
      'project': project,
      'project_extra_info': projectExtraInfo?.toMap(),
      'id': id,
      'name': name,
      'slug': slug,
      'owner': owner,
      'estimated_start': estimatedStart?.toIso8601String(),
      'estimated_finish': estimatedFinish?.toIso8601String(),
      'created_date': createdDate?.toIso8601String(),
      'modified_date': modifiedDate?.toIso8601String(),
      'closed': closed,
      'disponibility': disponibility,
      'order': order,
      'user_stories': userStories?.map((e) => e.toMap()).toList(),
      'total_points': totalPoints,
      'closed_points': closedPoints,
    };
  }

  factory MilestoneResponse.fromMap(Map<String, dynamic> map) {
    return MilestoneResponse(
      project: int.tryParse(map['project']?.toString() ?? ''),
      projectExtraInfo: map['project_extra_info'] == null
          ? null
          : ProjectExtraInfoMilestone.fromMap(map['project_extra_info']),
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      slug: map['slug'],
      owner: int.tryParse(map['owner']?.toString() ?? ''),
      estimatedStart: DateTime.tryParse(map['estimated_start'] ?? ''),
      estimatedFinish: DateTime.tryParse(map['estimated_finish'] ?? ''),
      createdDate: DateTime.tryParse(map['created_date'] ?? ''),
      modifiedDate: DateTime.tryParse(map['modified_date'] ?? ''),
      closed: map['closed'],
      disponibility: double.tryParse(map['disponibility']?.toString() ?? ''),
      order: int.tryParse(map['order']?.toString() ?? ''),
      userStories: map['user_stories'] == null
          ? null
          : List.from((map['user_stories'] as List)
              .map((e) => UserStoriesMilestone.fromMap(e))),
      totalPoints: double.tryParse(map['total_points']?.toString() ?? ''),
      closedPoints: map['closed_points'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MilestoneResponse.fromJson(String source) =>
      MilestoneResponse.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MilestoneResponse &&
        other.project == project &&
        other.projectExtraInfo == projectExtraInfo &&
        other.id == id &&
        other.name == name &&
        other.slug == slug &&
        other.owner == owner &&
        other.estimatedStart == estimatedStart &&
        other.estimatedFinish == estimatedFinish &&
        other.createdDate == createdDate &&
        other.modifiedDate == modifiedDate &&
        other.closed == closed &&
        other.disponibility == disponibility &&
        other.order == order &&
        listEquals(other.userStories, userStories) &&
        other.totalPoints == totalPoints &&
        other.closedPoints == closedPoints;
  }

  @override
  int get hashCode {
    return project.hashCode ^
        projectExtraInfo.hashCode ^
        id.hashCode ^
        name.hashCode ^
        slug.hashCode ^
        owner.hashCode ^
        estimatedStart.hashCode ^
        estimatedFinish.hashCode ^
        createdDate.hashCode ^
        modifiedDate.hashCode ^
        closed.hashCode ^
        disponibility.hashCode ^
        order.hashCode ^
        userStories.hashCode ^
        totalPoints.hashCode ^
        closedPoints.hashCode;
  }
}

class ProjectExtraInfoMilestone {
  const ProjectExtraInfoMilestone({
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

  factory ProjectExtraInfoMilestone.fromMap(Map<String, dynamic> map) {
    return ProjectExtraInfoMilestone(
      name: map['name'],
      slug: map['slug'],
      logoSmallUrl: map['logo_small_url'],
      id: int.tryParse(map['id']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectExtraInfoMilestone.fromJson(String source) =>
      ProjectExtraInfoMilestone.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProjectExtraInfoMilestone &&
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

class UserStoriesMilestone {
  const UserStoriesMilestone({
    required this.dueDate,
    required this.dueDateReason,
    required this.dueDateStatus,
    required this.assignedTo,
    required this.assignedToExtraInfo,
    required this.status,
    required this.statusExtraInfo,
    required this.project,
    required this.projectExtraInfo,
    required this.id,
    required this.ref,
    required this.milestone,
    required this.isClosed,
    required this.createdDate,
    required this.modifiedDate,
    required this.finishDate,
    required this.subject,
    required this.clientRequirement,
    required this.teamRequirement,
    required this.externalReference,
    required this.version,
    required this.isBlocked,
    required this.blockedNote,
    required this.backlogOrder,
    required this.sprintOrder,
    required this.kanbanOrder,
    required this.epics,
    required this.points,
    required this.totalPoints,
  });

  final dynamic dueDate;
  final String? dueDateReason;
  final String? dueDateStatus;
  final int? assignedTo;
  final AssignedToExtraInfoMilestone? assignedToExtraInfo;
  final int? status;
  final StatusExtraInfoMilestone? statusExtraInfo;
  final int? project;
  final AlphaProjectExtraInfoMilestone? projectExtraInfo;
  final int? id;
  final int? ref;
  final int? milestone;
  final bool? isClosed;
  final DateTime? createdDate;
  final DateTime? modifiedDate;
  final dynamic finishDate;
  final String? subject;
  final bool? clientRequirement;
  final bool? teamRequirement;
  final dynamic externalReference;
  final int? version;
  final bool? isBlocked;
  final String? blockedNote;
  final int? backlogOrder;
  final int? sprintOrder;
  final int? kanbanOrder;
  final dynamic epics;
  final dynamic points;
  final double? totalPoints;

  Map<String, dynamic> toMap() {
    return {
      'due_date': dueDate,
      'due_date_reason': dueDateReason,
      'due_date_status': dueDateStatus,
      'assigned_to': assignedTo,
      'assigned_to_extra_info': assignedToExtraInfo?.toMap(),
      'status': status,
      'status_extra_info': statusExtraInfo?.toMap(),
      'project': project,
      'project_extra_info': projectExtraInfo?.toMap(),
      'id': id,
      'ref': ref,
      'milestone': milestone,
      'is_closed': isClosed,
      'created_date': createdDate?.toIso8601String(),
      'modified_date': modifiedDate?.toIso8601String(),
      'finish_date': finishDate,
      'subject': subject,
      'client_requirement': clientRequirement,
      'team_requirement': teamRequirement,
      'external_reference': externalReference,
      'version': version,
      'is_blocked': isBlocked,
      'blocked_note': blockedNote,
      'backlog_order': backlogOrder,
      'sprint_order': sprintOrder,
      'kanban_order': kanbanOrder,
      'epics': epics,
      'points': points,
      'total_points': totalPoints,
    };
  }

  factory UserStoriesMilestone.fromMap(Map<String, dynamic> map) {
    return UserStoriesMilestone(
      dueDate: map['due_date'],
      dueDateReason: map['due_date_reason'],
      dueDateStatus: map['due_date_status'],
      assignedTo: int.tryParse(map['assigned_to']?.toString() ?? ''),
      assignedToExtraInfo: map['assigned_to_extra_info'] == null
          ? null
          : AssignedToExtraInfoMilestone.fromMap(map['assigned_to_extra_info']),
      status: int.tryParse(map['status']?.toString() ?? ''),
      statusExtraInfo: map['status_extra_info'] == null
          ? null
          : StatusExtraInfoMilestone.fromMap(map['status_extra_info']),
      project: int.tryParse(map['project']?.toString() ?? ''),
      projectExtraInfo: map['project_extra_info'] == null
          ? null
          : AlphaProjectExtraInfoMilestone.fromMap(map['project_extra_info']),
      id: int.tryParse(map['id']?.toString() ?? ''),
      ref: int.tryParse(map['ref']?.toString() ?? ''),
      milestone: int.tryParse(map['milestone']?.toString() ?? ''),
      isClosed: map['is_closed'],
      createdDate: DateTime.tryParse(map['created_date'] ?? ''),
      modifiedDate: DateTime.tryParse(map['modified_date'] ?? ''),
      finishDate: map['finish_date'],
      subject: map['subject'],
      clientRequirement: map['client_requirement'],
      teamRequirement: map['team_requirement'],
      externalReference: map['external_reference'],
      version: int.tryParse(map['version']?.toString() ?? ''),
      isBlocked: map['is_blocked'],
      blockedNote: map['blocked_note'],
      backlogOrder: int.tryParse(map['backlog_order']?.toString() ?? ''),
      sprintOrder: int.tryParse(map['sprint_order']?.toString() ?? ''),
      kanbanOrder: int.tryParse(map['kanban_order']?.toString() ?? ''),
      epics: map['epics'],
      points: map['points'],
      totalPoints: double.tryParse(map['total_points']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserStoriesMilestone.fromJson(String source) =>
      UserStoriesMilestone.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserStoriesMilestone &&
        other.dueDate == dueDate &&
        other.dueDateReason == dueDateReason &&
        other.dueDateStatus == dueDateStatus &&
        other.assignedTo == assignedTo &&
        other.assignedToExtraInfo == assignedToExtraInfo &&
        other.status == status &&
        other.statusExtraInfo == statusExtraInfo &&
        other.project == project &&
        other.projectExtraInfo == projectExtraInfo &&
        other.id == id &&
        other.ref == ref &&
        other.milestone == milestone &&
        other.isClosed == isClosed &&
        other.createdDate == createdDate &&
        other.modifiedDate == modifiedDate &&
        other.finishDate == finishDate &&
        other.subject == subject &&
        other.clientRequirement == clientRequirement &&
        other.teamRequirement == teamRequirement &&
        other.externalReference == externalReference &&
        other.version == version &&
        other.isBlocked == isBlocked &&
        other.blockedNote == blockedNote &&
        other.backlogOrder == backlogOrder &&
        other.sprintOrder == sprintOrder &&
        other.kanbanOrder == kanbanOrder &&
        other.epics == epics &&
        other.points == points &&
        other.totalPoints == totalPoints;
  }

  @override
  int get hashCode {
    return dueDate.hashCode ^
        dueDateReason.hashCode ^
        dueDateStatus.hashCode ^
        assignedTo.hashCode ^
        assignedToExtraInfo.hashCode ^
        status.hashCode ^
        statusExtraInfo.hashCode ^
        project.hashCode ^
        projectExtraInfo.hashCode ^
        id.hashCode ^
        ref.hashCode ^
        milestone.hashCode ^
        isClosed.hashCode ^
        createdDate.hashCode ^
        modifiedDate.hashCode ^
        finishDate.hashCode ^
        subject.hashCode ^
        clientRequirement.hashCode ^
        teamRequirement.hashCode ^
        externalReference.hashCode ^
        version.hashCode ^
        isBlocked.hashCode ^
        blockedNote.hashCode ^
        backlogOrder.hashCode ^
        sprintOrder.hashCode ^
        kanbanOrder.hashCode ^
        epics.hashCode ^
        points.hashCode ^
        totalPoints.hashCode;
  }
}

class AssignedToExtraInfoMilestone {
  const AssignedToExtraInfoMilestone({
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

  factory AssignedToExtraInfoMilestone.fromMap(Map<String, dynamic> map) {
    return AssignedToExtraInfoMilestone(
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

  factory AssignedToExtraInfoMilestone.fromJson(String source) =>
      AssignedToExtraInfoMilestone.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssignedToExtraInfoMilestone &&
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

class StatusExtraInfoMilestone {
  const StatusExtraInfoMilestone({
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

  factory StatusExtraInfoMilestone.fromMap(Map<String, dynamic> map) {
    return StatusExtraInfoMilestone(
      name: map['name'],
      color: map['color'],
      isClosed: map['is_closed'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusExtraInfoMilestone.fromJson(String source) =>
      StatusExtraInfoMilestone.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatusExtraInfoMilestone &&
        other.name == name &&
        other.color == color &&
        other.isClosed == isClosed;
  }

  @override
  int get hashCode => name.hashCode ^ color.hashCode ^ isClosed.hashCode;
}

class AlphaProjectExtraInfoMilestone {
  const AlphaProjectExtraInfoMilestone({
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

  factory AlphaProjectExtraInfoMilestone.fromMap(Map<String, dynamic> map) {
    return AlphaProjectExtraInfoMilestone(
      name: map['name'],
      slug: map['slug'],
      logoSmallUrl: map['logo_small_url'],
      id: int.tryParse(map['id']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory AlphaProjectExtraInfoMilestone.fromJson(String source) =>
      AlphaProjectExtraInfoMilestone.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AlphaProjectExtraInfoMilestone &&
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
