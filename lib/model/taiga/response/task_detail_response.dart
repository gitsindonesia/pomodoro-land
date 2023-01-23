import 'dart:convert';

import 'package:flutter/foundation.dart';

class TaskDetailResponse {
  const TaskDetailResponse({
    required this.assignedTo,
    required this.assignedToExtraInfo,
    required this.attachments,
    required this.blockedNote,
    required this.blockedNoteHtml,
    required this.comment,
    required this.createdDate,
    required this.description,
    required this.descriptionHtml,
    required this.dueDate,
    required this.dueDateReason,
    required this.dueDateStatus,
    required this.externalReference,
    required this.finishedDate,
    required this.generatedUserStories,
    required this.id,
    required this.isBlocked,
    required this.isClosed,
    required this.isIocaine,
    required this.isVoter,
    required this.isWatcher,
    required this.milestone,
    required this.milestoneSlug,
    required this.modifiedDate,
    required this.neighbors,
    required this.owner,
    required this.ownerExtraInfo,
    required this.project,
    required this.projectExtraInfo,
    required this.ref,
    required this.status,
    required this.statusExtraInfo,
    required this.subject,
    required this.tags,
    required this.taskboardOrder,
    required this.totalComments,
    required this.totalVoters,
    required this.totalWatchers,
    required this.usOrder,
    required this.userStory,
    required this.userStoryExtraInfo,
    required this.version,
    required this.watchers,
  });

  final int? assignedTo;
  final AssignedToExtraInfoTaskDetail? assignedToExtraInfo;
  final List<dynamic>? attachments;
  final String? blockedNote;
  final String? blockedNoteHtml;
  final String? comment;
  final DateTime? createdDate;
  final String? description;
  final String? descriptionHtml;
  final dynamic dueDate;
  final String? dueDateReason;
  final String? dueDateStatus;
  final dynamic externalReference;
  final DateTime? finishedDate;
  final dynamic generatedUserStories;
  final int? id;
  final bool? isBlocked;
  final bool? isClosed;
  final bool? isIocaine;
  final bool? isVoter;
  final bool? isWatcher;
  final int? milestone;
  final String? milestoneSlug;
  final DateTime? modifiedDate;
  final NeighborsTaskDetail? neighbors;
  final int? owner;
  final OwnerExtraInfoTaskDetail? ownerExtraInfo;
  final int? project;
  final ProjectExtraInfoTaskDetail? projectExtraInfo;
  final int? ref;
  final int? status;
  final StatusExtraInfoTaskDetail? statusExtraInfo;
  final String? subject;
  final List<List<String>>? tags;
  final int? taskboardOrder;
  final int? totalComments;
  final int? totalVoters;
  final int? totalWatchers;
  final int? usOrder;
  final int? userStory;
  final UserStoryExtraInfoTaskDetail? userStoryExtraInfo;
  final int? version;
  final List<int>? watchers;

  Map<String, dynamic> toMap() {
    return {
      'assigned_to': assignedTo,
      'assigned_to_extra_info': assignedToExtraInfo?.toMap(),
      'attachments': attachments,
      'blocked_note': blockedNote,
      'blocked_note_html': blockedNoteHtml,
      'comment': comment,
      'created_date': createdDate?.toIso8601String(),
      'description': description,
      'description_html': descriptionHtml,
      'due_date': dueDate,
      'due_date_reason': dueDateReason,
      'due_date_status': dueDateStatus,
      'external_reference': externalReference,
      'finished_date': finishedDate?.toIso8601String(),
      'generated_user_stories': generatedUserStories,
      'id': id,
      'is_blocked': isBlocked,
      'is_closed': isClosed,
      'is_iocaine': isIocaine,
      'is_voter': isVoter,
      'is_watcher': isWatcher,
      'milestone': milestone,
      'milestone_slug': milestoneSlug,
      'modified_date': modifiedDate?.toIso8601String(),
      'neighbors': neighbors?.toMap(),
      'owner': owner,
      'owner_extra_info': ownerExtraInfo?.toMap(),
      'project': project,
      'project_extra_info': projectExtraInfo?.toMap(),
      'ref': ref,
      'status': status,
      'status_extra_info': statusExtraInfo?.toMap(),
      'subject': subject,
      'tags': tags,
      'taskboard_order': taskboardOrder,
      'total_comments': totalComments,
      'total_voters': totalVoters,
      'total_watchers': totalWatchers,
      'us_order': usOrder,
      'user_story': userStory,
      'user_story_extra_info': userStoryExtraInfo?.toMap(),
      'version': version,
      'watchers': watchers,
    };
  }

  factory TaskDetailResponse.fromMap(Map<String, dynamic> map) {
    return TaskDetailResponse(
      assignedTo: int.tryParse(map['assigned_to']?.toString() ?? ''),
      assignedToExtraInfo: map['assigned_to_extra_info'] == null
          ? null
          : AssignedToExtraInfoTaskDetail.fromMap(
              map['assigned_to_extra_info']),
      attachments: map['attachments'],
      blockedNote: map['blocked_note'],
      blockedNoteHtml: map['blocked_note_html'],
      comment: map['comment'],
      createdDate: DateTime.tryParse(map['created_date'] ?? ''),
      description: map['description'],
      descriptionHtml: map['description_html'],
      dueDate: map['due_date'],
      dueDateReason: map['due_date_reason'],
      dueDateStatus: map['due_date_status'],
      externalReference: map['external_reference'],
      finishedDate: DateTime.tryParse(map['finished_date'] ?? ''),
      generatedUserStories: map['generated_user_stories'],
      id: int.tryParse(map['id']?.toString() ?? ''),
      isBlocked: map['is_blocked'],
      isClosed: map['is_closed'],
      isIocaine: map['is_iocaine'],
      isVoter: map['is_voter'],
      isWatcher: map['is_watcher'],
      milestone: int.tryParse(map['milestone']?.toString() ?? ''),
      milestoneSlug: map['milestone_slug'],
      modifiedDate: DateTime.tryParse(map['modified_date'] ?? ''),
      neighbors: map['neighbors'] == null
          ? null
          : NeighborsTaskDetail.fromMap(map['neighbors']),
      owner: int.tryParse(map['owner']?.toString() ?? ''),
      ownerExtraInfo: map['owner_extra_info'] == null
          ? null
          : OwnerExtraInfoTaskDetail.fromMap(map['owner_extra_info']),
      project: int.tryParse(map['project']?.toString() ?? ''),
      projectExtraInfo: map['project_extra_info'] == null
          ? null
          : ProjectExtraInfoTaskDetail.fromMap(map['project_extra_info']),
      ref: int.tryParse(map['ref']?.toString() ?? ''),
      status: int.tryParse(map['status']?.toString() ?? ''),
      statusExtraInfo: map['status_extra_info'] == null
          ? null
          : StatusExtraInfoTaskDetail.fromMap(map['status_extra_info']),
      subject: map['subject'],
      tags: map['tags'] == null ? null : List.from(map['tags']),
      taskboardOrder: int.tryParse(map['taskboard_order']?.toString() ?? ''),
      totalComments: int.tryParse(map['total_comments']?.toString() ?? ''),
      totalVoters: int.tryParse(map['total_voters']?.toString() ?? ''),
      totalWatchers: int.tryParse(map['total_watchers']?.toString() ?? ''),
      usOrder: int.tryParse(map['us_order']?.toString() ?? ''),
      userStory: int.tryParse(map['user_story']?.toString() ?? ''),
      userStoryExtraInfo: map['user_story_extra_info'] == null
          ? null
          : UserStoryExtraInfoTaskDetail.fromMap(map['user_story_extra_info']),
      version: int.tryParse(map['version']?.toString() ?? ''),
      watchers: map['watchers'] == null ? null : List.from(map['watchers']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskDetailResponse.fromJson(String source) =>
      TaskDetailResponse.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskDetailResponse &&
        other.assignedTo == assignedTo &&
        other.assignedToExtraInfo == assignedToExtraInfo &&
        listEquals(other.attachments, attachments) &&
        other.blockedNote == blockedNote &&
        other.blockedNoteHtml == blockedNoteHtml &&
        other.comment == comment &&
        other.createdDate == createdDate &&
        other.description == description &&
        other.descriptionHtml == descriptionHtml &&
        other.dueDate == dueDate &&
        other.dueDateReason == dueDateReason &&
        other.dueDateStatus == dueDateStatus &&
        other.externalReference == externalReference &&
        other.finishedDate == finishedDate &&
        other.generatedUserStories == generatedUserStories &&
        other.id == id &&
        other.isBlocked == isBlocked &&
        other.isClosed == isClosed &&
        other.isIocaine == isIocaine &&
        other.isVoter == isVoter &&
        other.isWatcher == isWatcher &&
        other.milestone == milestone &&
        other.milestoneSlug == milestoneSlug &&
        other.modifiedDate == modifiedDate &&
        other.neighbors == neighbors &&
        other.owner == owner &&
        other.ownerExtraInfo == ownerExtraInfo &&
        other.project == project &&
        other.projectExtraInfo == projectExtraInfo &&
        other.ref == ref &&
        other.status == status &&
        other.statusExtraInfo == statusExtraInfo &&
        other.subject == subject &&
        listEquals(other.tags, tags) &&
        other.taskboardOrder == taskboardOrder &&
        other.totalComments == totalComments &&
        other.totalVoters == totalVoters &&
        other.totalWatchers == totalWatchers &&
        other.usOrder == usOrder &&
        other.userStory == userStory &&
        other.userStoryExtraInfo == userStoryExtraInfo &&
        other.version == version &&
        listEquals(other.watchers, watchers);
  }

  @override
  int get hashCode {
    return assignedTo.hashCode ^
        assignedToExtraInfo.hashCode ^
        attachments.hashCode ^
        blockedNote.hashCode ^
        blockedNoteHtml.hashCode ^
        comment.hashCode ^
        createdDate.hashCode ^
        description.hashCode ^
        descriptionHtml.hashCode ^
        dueDate.hashCode ^
        dueDateReason.hashCode ^
        dueDateStatus.hashCode ^
        externalReference.hashCode ^
        finishedDate.hashCode ^
        generatedUserStories.hashCode ^
        id.hashCode ^
        isBlocked.hashCode ^
        isClosed.hashCode ^
        isIocaine.hashCode ^
        isVoter.hashCode ^
        isWatcher.hashCode ^
        milestone.hashCode ^
        milestoneSlug.hashCode ^
        modifiedDate.hashCode ^
        neighbors.hashCode ^
        owner.hashCode ^
        ownerExtraInfo.hashCode ^
        project.hashCode ^
        projectExtraInfo.hashCode ^
        ref.hashCode ^
        status.hashCode ^
        statusExtraInfo.hashCode ^
        subject.hashCode ^
        tags.hashCode ^
        taskboardOrder.hashCode ^
        totalComments.hashCode ^
        totalVoters.hashCode ^
        totalWatchers.hashCode ^
        usOrder.hashCode ^
        userStory.hashCode ^
        userStoryExtraInfo.hashCode ^
        version.hashCode ^
        watchers.hashCode;
  }
}

class AssignedToExtraInfoTaskDetail {
  const AssignedToExtraInfoTaskDetail({
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

  factory AssignedToExtraInfoTaskDetail.fromMap(Map<String, dynamic> map) {
    return AssignedToExtraInfoTaskDetail(
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

  factory AssignedToExtraInfoTaskDetail.fromJson(String source) =>
      AssignedToExtraInfoTaskDetail.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssignedToExtraInfoTaskDetail &&
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

class NeighborsTaskDetail {
  const NeighborsTaskDetail({
    required this.next,
    required this.previous,
  });

  final NextTaskDetail? next;
  final dynamic previous;

  Map<String, dynamic> toMap() {
    return {
      'next': next?.toMap(),
      'previous': previous,
    };
  }

  factory NeighborsTaskDetail.fromMap(Map<String, dynamic> map) {
    return NeighborsTaskDetail(
      next: map['next'] == null ? null : NextTaskDetail.fromMap(map['next']),
      previous: map['previous'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NeighborsTaskDetail.fromJson(String source) =>
      NeighborsTaskDetail.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NeighborsTaskDetail &&
        other.next == next &&
        other.previous == previous;
  }

  @override
  int get hashCode => next.hashCode ^ previous.hashCode;
}

class NextTaskDetail {
  const NextTaskDetail({
    required this.id,
    required this.ref,
    required this.subject,
  });

  final int? id;
  final int? ref;
  final String? subject;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ref': ref,
      'subject': subject,
    };
  }

  factory NextTaskDetail.fromMap(Map<String, dynamic> map) {
    return NextTaskDetail(
      id: int.tryParse(map['id']?.toString() ?? ''),
      ref: int.tryParse(map['ref']?.toString() ?? ''),
      subject: map['subject'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NextTaskDetail.fromJson(String source) =>
      NextTaskDetail.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NextTaskDetail &&
        other.id == id &&
        other.ref == ref &&
        other.subject == subject;
  }

  @override
  int get hashCode => id.hashCode ^ ref.hashCode ^ subject.hashCode;
}

class OwnerExtraInfoTaskDetail {
  const OwnerExtraInfoTaskDetail({
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

  factory OwnerExtraInfoTaskDetail.fromMap(Map<String, dynamic> map) {
    return OwnerExtraInfoTaskDetail(
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

  factory OwnerExtraInfoTaskDetail.fromJson(String source) =>
      OwnerExtraInfoTaskDetail.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OwnerExtraInfoTaskDetail &&
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

class ProjectExtraInfoTaskDetail {
  const ProjectExtraInfoTaskDetail({
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

  factory ProjectExtraInfoTaskDetail.fromMap(Map<String, dynamic> map) {
    return ProjectExtraInfoTaskDetail(
      id: int.tryParse(map['id']?.toString() ?? ''),
      logoSmallUrl: map['logo_small_url'],
      name: map['name'],
      slug: map['slug'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectExtraInfoTaskDetail.fromJson(String source) =>
      ProjectExtraInfoTaskDetail.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProjectExtraInfoTaskDetail &&
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

class StatusExtraInfoTaskDetail {
  const StatusExtraInfoTaskDetail({
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

  factory StatusExtraInfoTaskDetail.fromMap(Map<String, dynamic> map) {
    return StatusExtraInfoTaskDetail(
      color: map['color'],
      isClosed: map['is_closed'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusExtraInfoTaskDetail.fromJson(String source) =>
      StatusExtraInfoTaskDetail.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatusExtraInfoTaskDetail &&
        other.color == color &&
        other.isClosed == isClosed &&
        other.name == name;
  }

  @override
  int get hashCode => color.hashCode ^ isClosed.hashCode ^ name.hashCode;
}

class UserStoryExtraInfoTaskDetail {
  const UserStoryExtraInfoTaskDetail({
    required this.epics,
    required this.id,
    required this.ref,
    required this.subject,
  });

  final List<EpicsTaskDetail>? epics;
  final int? id;
  final int? ref;
  final String? subject;

  Map<String, dynamic> toMap() {
    return {
      'epics': epics?.map((e) => e.toMap()).toList(),
      'id': id,
      'ref': ref,
      'subject': subject,
    };
  }

  factory UserStoryExtraInfoTaskDetail.fromMap(Map<String, dynamic> map) {
    return UserStoryExtraInfoTaskDetail(
      epics: map['epics'] == null
          ? null
          : List.from(
              (map['epics'] as List).map((e) => EpicsTaskDetail.fromMap(e))),
      id: int.tryParse(map['id']?.toString() ?? ''),
      ref: int.tryParse(map['ref']?.toString() ?? ''),
      subject: map['subject'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserStoryExtraInfoTaskDetail.fromJson(String source) =>
      UserStoryExtraInfoTaskDetail.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserStoryExtraInfoTaskDetail &&
        listEquals(other.epics, epics) &&
        other.id == id &&
        other.ref == ref &&
        other.subject == subject;
  }

  @override
  int get hashCode {
    return epics.hashCode ^ id.hashCode ^ ref.hashCode ^ subject.hashCode;
  }
}

class EpicsTaskDetail {
  const EpicsTaskDetail({
    required this.color,
    required this.id,
    required this.project,
    required this.ref,
    required this.subject,
  });

  final String? color;
  final int? id;
  final ProjectTaskDetail? project;
  final int? ref;
  final String? subject;

  Map<String, dynamic> toMap() {
    return {
      'color': color,
      'id': id,
      'project': project?.toMap(),
      'ref': ref,
      'subject': subject,
    };
  }

  factory EpicsTaskDetail.fromMap(Map<String, dynamic> map) {
    return EpicsTaskDetail(
      color: map['color'],
      id: int.tryParse(map['id']?.toString() ?? ''),
      project: map['project'] == null
          ? null
          : ProjectTaskDetail.fromMap(map['project']),
      ref: int.tryParse(map['ref']?.toString() ?? ''),
      subject: map['subject'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpicsTaskDetail.fromJson(String source) =>
      EpicsTaskDetail.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EpicsTaskDetail &&
        other.color == color &&
        other.id == id &&
        other.project == project &&
        other.ref == ref &&
        other.subject == subject;
  }

  @override
  int get hashCode {
    return color.hashCode ^
        id.hashCode ^
        project.hashCode ^
        ref.hashCode ^
        subject.hashCode;
  }
}

class ProjectTaskDetail {
  const ProjectTaskDetail({
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

  factory ProjectTaskDetail.fromMap(Map<String, dynamic> map) {
    return ProjectTaskDetail(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      slug: map['slug'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectTaskDetail.fromJson(String source) =>
      ProjectTaskDetail.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProjectTaskDetail &&
        other.id == id &&
        other.name == name &&
        other.slug == slug;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ slug.hashCode;
}
