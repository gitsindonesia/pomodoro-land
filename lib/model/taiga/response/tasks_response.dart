import 'dart:convert';

import 'package:flutter/foundation.dart';

class TasksResponse {
  const TasksResponse({
    required this.dueDate,
    required this.dueDateReason,
    required this.dueDateStatus,
    required this.totalComments,
    required this.tags,
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
    required this.userStory,
    required this.ref,
    required this.milestone,
    required this.milestoneSlug,
    required this.createdDate,
    required this.modifiedDate,
    required this.finishedDate,
    required this.subject,
    required this.usOrder,
    required this.taskboardOrder,
    required this.isIocaine,
    required this.externalReference,
    required this.version,
    required this.watchers,
    required this.isBlocked,
    required this.blockedNote,
    required this.isClosed,
    required this.userStoryExtraInfo,
  });

  final dynamic dueDate;
  final String? dueDateReason;
  final String? dueDateStatus;
  final int? totalComments;
  final List<dynamic>? tags;
  final List<dynamic>? attachments;
  final int? project;
  final ProjectExtraInfoTasks? projectExtraInfo;
  final int? status;
  final StatusExtraInfoTasks? statusExtraInfo;
  final int? assignedTo;
  final AssignedToExtraInfoTasks? assignedToExtraInfo;
  final int? owner;
  final OwnerExtraInfoTasks? ownerExtraInfo;
  final bool? isWatcher;
  final int? totalWatchers;
  final bool? isVoter;
  final int? totalVoters;
  final int? id;
  final int? userStory;
  final int? ref;
  final int? milestone;
  final String? milestoneSlug;
  final DateTime? createdDate;
  final DateTime? modifiedDate;
  final dynamic finishedDate;
  final String? subject;
  final int? usOrder;
  final int? taskboardOrder;
  final bool? isIocaine;
  final dynamic externalReference;
  final int? version;
  final List<dynamic>? watchers;
  final bool? isBlocked;
  final String? blockedNote;
  final bool? isClosed;
  final UserStoryExtraInfoTasks? userStoryExtraInfo;

  Map<String, dynamic> toMap() {
    return {
      'due_date': dueDate,
      'due_date_reason': dueDateReason,
      'due_date_status': dueDateStatus,
      'total_comments': totalComments,
      'tags': tags,
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
      'user_story': userStory,
      'ref': ref,
      'milestone': milestone,
      'milestone_slug': milestoneSlug,
      'created_date': createdDate?.toIso8601String(),
      'modified_date': modifiedDate?.toIso8601String(),
      'finished_date': finishedDate,
      'subject': subject,
      'us_order': usOrder,
      'taskboard_order': taskboardOrder,
      'is_iocaine': isIocaine,
      'external_reference': externalReference,
      'version': version,
      'watchers': watchers,
      'is_blocked': isBlocked,
      'blocked_note': blockedNote,
      'is_closed': isClosed,
      'user_story_extra_info': userStoryExtraInfo?.toMap(),
    };
  }

  factory TasksResponse.fromMap(Map<String, dynamic> map) {
    return TasksResponse(
      dueDate: map['due_date'],
      dueDateReason: map['due_date_reason'],
      dueDateStatus: map['due_date_status'],
      totalComments: int.tryParse(map['total_comments']?.toString() ?? ''),
      tags: map['tags'],
      attachments: map['attachments'],
      project: int.tryParse(map['project']?.toString() ?? ''),
      projectExtraInfo: map['project_extra_info'] == null
          ? null
          : ProjectExtraInfoTasks.fromMap(map['project_extra_info']),
      status: int.tryParse(map['status']?.toString() ?? ''),
      statusExtraInfo: map['status_extra_info'] == null
          ? null
          : StatusExtraInfoTasks.fromMap(map['status_extra_info']),
      assignedTo: int.tryParse(map['assigned_to']?.toString() ?? ''),
      assignedToExtraInfo: map['assigned_to_extra_info'] == null
          ? null
          : AssignedToExtraInfoTasks.fromMap(map['assigned_to_extra_info']),
      owner: int.tryParse(map['owner']?.toString() ?? ''),
      ownerExtraInfo: map['owner_extra_info'] == null
          ? null
          : OwnerExtraInfoTasks.fromMap(map['owner_extra_info']),
      isWatcher: map['is_watcher'],
      totalWatchers: int.tryParse(map['total_watchers']?.toString() ?? ''),
      isVoter: map['is_voter'],
      totalVoters: int.tryParse(map['total_voters']?.toString() ?? ''),
      id: int.tryParse(map['id']?.toString() ?? ''),
      userStory: int.tryParse(map['user_story']?.toString() ?? ''),
      ref: int.tryParse(map['ref']?.toString() ?? ''),
      milestone: int.tryParse(map['milestone']?.toString() ?? ''),
      milestoneSlug: map['milestone_slug'],
      createdDate: DateTime.tryParse(map['created_date'] ?? ''),
      modifiedDate: DateTime.tryParse(map['modified_date'] ?? ''),
      finishedDate: map['finished_date'],
      subject: map['subject'],
      usOrder: int.tryParse(map['us_order']?.toString() ?? ''),
      taskboardOrder: int.tryParse(map['taskboard_order']?.toString() ?? ''),
      isIocaine: map['is_iocaine'],
      externalReference: map['external_reference'],
      version: int.tryParse(map['version']?.toString() ?? ''),
      watchers: map['watchers'],
      isBlocked: map['is_blocked'],
      blockedNote: map['blocked_note'],
      isClosed: map['is_closed'],
      userStoryExtraInfo: map['user_story_extra_info'] == null
          ? null
          : UserStoryExtraInfoTasks.fromMap(map['user_story_extra_info']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TasksResponse.fromJson(String source) =>
      TasksResponse.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TasksResponse &&
        other.dueDate == dueDate &&
        other.dueDateReason == dueDateReason &&
        other.dueDateStatus == dueDateStatus &&
        other.totalComments == totalComments &&
        listEquals(other.tags, tags) &&
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
        other.userStory == userStory &&
        other.ref == ref &&
        other.milestone == milestone &&
        other.milestoneSlug == milestoneSlug &&
        other.createdDate == createdDate &&
        other.modifiedDate == modifiedDate &&
        other.finishedDate == finishedDate &&
        other.subject == subject &&
        other.usOrder == usOrder &&
        other.taskboardOrder == taskboardOrder &&
        other.isIocaine == isIocaine &&
        other.externalReference == externalReference &&
        other.version == version &&
        listEquals(other.watchers, watchers) &&
        other.isBlocked == isBlocked &&
        other.blockedNote == blockedNote &&
        other.isClosed == isClosed &&
        other.userStoryExtraInfo == userStoryExtraInfo;
  }

  @override
  int get hashCode {
    return dueDate.hashCode ^
        dueDateReason.hashCode ^
        dueDateStatus.hashCode ^
        totalComments.hashCode ^
        tags.hashCode ^
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
        userStory.hashCode ^
        ref.hashCode ^
        milestone.hashCode ^
        milestoneSlug.hashCode ^
        createdDate.hashCode ^
        modifiedDate.hashCode ^
        finishedDate.hashCode ^
        subject.hashCode ^
        usOrder.hashCode ^
        taskboardOrder.hashCode ^
        isIocaine.hashCode ^
        externalReference.hashCode ^
        version.hashCode ^
        watchers.hashCode ^
        isBlocked.hashCode ^
        blockedNote.hashCode ^
        isClosed.hashCode ^
        userStoryExtraInfo.hashCode;
  }

  TasksResponse copyWith({
    dynamic dueDate,
    String? dueDateReason,
    String? dueDateStatus,
    int? totalComments,
    List<dynamic>? tags,
    List<dynamic>? attachments,
    int? project,
    ProjectExtraInfoTasks? projectExtraInfo,
    int? status,
    StatusExtraInfoTasks? statusExtraInfo,
    int? assignedTo,
    AssignedToExtraInfoTasks? assignedToExtraInfo,
    int? owner,
    OwnerExtraInfoTasks? ownerExtraInfo,
    bool? isWatcher,
    int? totalWatchers,
    bool? isVoter,
    int? totalVoters,
    int? id,
    int? userStory,
    int? ref,
    int? milestone,
    String? milestoneSlug,
    DateTime? createdDate,
    DateTime? modifiedDate,
    dynamic finishedDate,
    String? subject,
    int? usOrder,
    int? taskboardOrder,
    bool? isIocaine,
    dynamic externalReference,
    int? version,
    List<dynamic>? watchers,
    bool? isBlocked,
    String? blockedNote,
    bool? isClosed,
    UserStoryExtraInfoTasks? userStoryExtraInfo,
  }) {
    return TasksResponse(
      dueDate: dueDate ?? this.dueDate,
      dueDateReason: dueDateReason ?? this.dueDateReason,
      dueDateStatus: dueDateStatus ?? this.dueDateStatus,
      totalComments: totalComments ?? this.totalComments,
      tags: tags ?? this.tags,
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
      userStory: userStory ?? this.userStory,
      ref: ref ?? this.ref,
      milestone: milestone ?? this.milestone,
      milestoneSlug: milestoneSlug ?? this.milestoneSlug,
      createdDate: createdDate ?? this.createdDate,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      finishedDate: finishedDate ?? this.finishedDate,
      subject: subject ?? this.subject,
      usOrder: usOrder ?? this.usOrder,
      taskboardOrder: taskboardOrder ?? this.taskboardOrder,
      isIocaine: isIocaine ?? this.isIocaine,
      externalReference: externalReference ?? this.externalReference,
      version: version ?? this.version,
      watchers: watchers ?? this.watchers,
      isBlocked: isBlocked ?? this.isBlocked,
      blockedNote: blockedNote ?? this.blockedNote,
      isClosed: isClosed ?? this.isClosed,
      userStoryExtraInfo: userStoryExtraInfo ?? this.userStoryExtraInfo,
    );
  }
}

class ProjectExtraInfoTasks {
  const ProjectExtraInfoTasks({
    required this.name,
    required this.slug,
    required this.logoSmallUrl,
    required this.id,
  });

  final String? name;
  final String? slug;
  final String? logoSmallUrl;
  final int? id;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'slug': slug,
      'logo_small_url': logoSmallUrl,
      'id': id,
    };
  }

  factory ProjectExtraInfoTasks.fromMap(Map<String, dynamic> map) {
    return ProjectExtraInfoTasks(
      name: map['name'],
      slug: map['slug'],
      logoSmallUrl: map['logo_small_url'],
      id: int.tryParse(map['id']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectExtraInfoTasks.fromJson(String source) =>
      ProjectExtraInfoTasks.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProjectExtraInfoTasks &&
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

class StatusExtraInfoTasks {
  const StatusExtraInfoTasks({
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

  factory StatusExtraInfoTasks.fromMap(Map<String, dynamic> map) {
    return StatusExtraInfoTasks(
      name: map['name'],
      color: map['color'],
      isClosed: map['is_closed'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusExtraInfoTasks.fromJson(String source) =>
      StatusExtraInfoTasks.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatusExtraInfoTasks &&
        other.name == name &&
        other.color == color &&
        other.isClosed == isClosed;
  }

  @override
  int get hashCode => name.hashCode ^ color.hashCode ^ isClosed.hashCode;

  StatusExtraInfoTasks copyWith({
    String? name,
    String? color,
    bool? isClosed,
  }) {
    return StatusExtraInfoTasks(
      name: name ?? this.name,
      color: color ?? this.color,
      isClosed: isClosed ?? this.isClosed,
    );
  }
}

class AssignedToExtraInfoTasks {
  const AssignedToExtraInfoTasks({
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

  factory AssignedToExtraInfoTasks.fromMap(Map<String, dynamic> map) {
    return AssignedToExtraInfoTasks(
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

  factory AssignedToExtraInfoTasks.fromJson(String source) =>
      AssignedToExtraInfoTasks.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssignedToExtraInfoTasks &&
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

class OwnerExtraInfoTasks {
  const OwnerExtraInfoTasks({
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

  factory OwnerExtraInfoTasks.fromMap(Map<String, dynamic> map) {
    return OwnerExtraInfoTasks(
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

  factory OwnerExtraInfoTasks.fromJson(String source) =>
      OwnerExtraInfoTasks.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OwnerExtraInfoTasks &&
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

class UserStoryExtraInfoTasks {
  const UserStoryExtraInfoTasks({
    required this.id,
    required this.ref,
    required this.subject,
    required this.epics,
  });

  final int? id;
  final int? ref;
  final String? subject;
  final List<EpicsTasks>? epics;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ref': ref,
      'subject': subject,
      'epics': epics?.map((e) => e.toMap()).toList(),
    };
  }

  factory UserStoryExtraInfoTasks.fromMap(Map<String, dynamic> map) {
    return UserStoryExtraInfoTasks(
      id: int.tryParse(map['id']?.toString() ?? ''),
      ref: int.tryParse(map['ref']?.toString() ?? ''),
      subject: map['subject'],
      epics: map['epics'] == null
          ? null
          : List.from((map['epics'] as List).map((e) => EpicsTasks.fromMap(e))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserStoryExtraInfoTasks.fromJson(String source) =>
      UserStoryExtraInfoTasks.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserStoryExtraInfoTasks &&
        other.id == id &&
        other.ref == ref &&
        other.subject == subject &&
        listEquals(other.epics, epics);
  }

  @override
  int get hashCode {
    return id.hashCode ^ ref.hashCode ^ subject.hashCode ^ epics.hashCode;
  }
}

class EpicsTasks {
  const EpicsTasks({
    required this.id,
    required this.ref,
    required this.subject,
    required this.color,
    required this.project,
  });

  final int? id;
  final int? ref;
  final String? subject;
  final String? color;
  final ProjectTasks? project;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ref': ref,
      'subject': subject,
      'color': color,
      'project': project?.toMap(),
    };
  }

  factory EpicsTasks.fromMap(Map<String, dynamic> map) {
    return EpicsTasks(
      id: int.tryParse(map['id']?.toString() ?? ''),
      ref: int.tryParse(map['ref']?.toString() ?? ''),
      subject: map['subject'],
      color: map['color'],
      project:
          map['project'] == null ? null : ProjectTasks.fromMap(map['project']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpicsTasks.fromJson(String source) =>
      EpicsTasks.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EpicsTasks &&
        other.id == id &&
        other.ref == ref &&
        other.subject == subject &&
        other.color == color &&
        other.project == project;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        ref.hashCode ^
        subject.hashCode ^
        color.hashCode ^
        project.hashCode;
  }
}

class ProjectTasks {
  const ProjectTasks({
    required this.id,
    required this.name,
    required this.slug,
  });

  final int? id;
  final String? name;
  final String? slug;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
    };
  }

  factory ProjectTasks.fromMap(Map<String, dynamic> map) {
    return ProjectTasks(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      slug: map['slug'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectTasks.fromJson(String source) =>
      ProjectTasks.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProjectTasks &&
        other.id == id &&
        other.name == name &&
        other.slug == slug;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ slug.hashCode;
}
