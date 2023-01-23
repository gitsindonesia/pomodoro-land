import 'dart:convert';

class IssueDetailResponse {
  const IssueDetailResponse({
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
    required this.isVoter,
    required this.isWatcher,
    required this.milestone,
    required this.modifiedDate,
    required this.neighbors,
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
  final dynamic attachments;
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
  final bool? isVoter;
  final bool? isWatcher;
  final dynamic milestone;
  final DateTime? modifiedDate;
  final NeighborsIssueDetail? neighbors;
  final int? owner;
  final OwnerExtraInfoIssueDetail? ownerExtraInfo;
  final int? priority;
  final int? project;
  final ProjectExtraInfoIssueDetail? projectExtraInfo;
  final int? ref;
  final int? severity;
  final int? status;
  final StatusExtraInfoIssueDetail? statusExtraInfo;
  final String? subject;
  final dynamic tags;
  final int? totalVoters;
  final int? totalWatchers;
  final int? type;
  final int? version;
  final dynamic watchers;

  Map<String, dynamic> toMap() {
    return {
      'assigned_to': assignedTo,
      'assigned_to_extra_info': assignedToExtraInfo,
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
      'is_voter': isVoter,
      'is_watcher': isWatcher,
      'milestone': milestone,
      'modified_date': modifiedDate?.toIso8601String(),
      'neighbors': neighbors?.toMap(),
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

  factory IssueDetailResponse.fromMap(Map<String, dynamic> map) {
    return IssueDetailResponse(
      assignedTo: map['assigned_to'],
      assignedToExtraInfo: map['assigned_to_extra_info'],
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
      isVoter: map['is_voter'],
      isWatcher: map['is_watcher'],
      milestone: map['milestone'],
      modifiedDate: DateTime.tryParse(map['modified_date'] ?? ''),
      neighbors: map['neighbors'] == null
          ? null
          : NeighborsIssueDetail.fromMap(map['neighbors']),
      owner: int.tryParse(map['owner']?.toString() ?? ''),
      ownerExtraInfo: map['owner_extra_info'] == null
          ? null
          : OwnerExtraInfoIssueDetail.fromMap(map['owner_extra_info']),
      priority: int.tryParse(map['priority']?.toString() ?? ''),
      project: int.tryParse(map['project']?.toString() ?? ''),
      projectExtraInfo: map['project_extra_info'] == null
          ? null
          : ProjectExtraInfoIssueDetail.fromMap(map['project_extra_info']),
      ref: int.tryParse(map['ref']?.toString() ?? ''),
      severity: int.tryParse(map['severity']?.toString() ?? ''),
      status: int.tryParse(map['status']?.toString() ?? ''),
      statusExtraInfo: map['status_extra_info'] == null
          ? null
          : StatusExtraInfoIssueDetail.fromMap(map['status_extra_info']),
      subject: map['subject'],
      tags: map['tags'],
      totalVoters: int.tryParse(map['total_voters']?.toString() ?? ''),
      totalWatchers: int.tryParse(map['total_watchers']?.toString() ?? ''),
      type: int.tryParse(map['type']?.toString() ?? ''),
      version: int.tryParse(map['version']?.toString() ?? ''),
      watchers: map['watchers'],
    );
  }

  String toJson() => json.encode(toMap());

  factory IssueDetailResponse.fromJson(String source) =>
      IssueDetailResponse.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IssueDetailResponse &&
        other.assignedTo == assignedTo &&
        other.assignedToExtraInfo == assignedToExtraInfo &&
        other.attachments == attachments &&
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
        other.isVoter == isVoter &&
        other.isWatcher == isWatcher &&
        other.milestone == milestone &&
        other.modifiedDate == modifiedDate &&
        other.neighbors == neighbors &&
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
        other.watchers == watchers;
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
        isVoter.hashCode ^
        isWatcher.hashCode ^
        milestone.hashCode ^
        modifiedDate.hashCode ^
        neighbors.hashCode ^
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

class NeighborsIssueDetail {
  const NeighborsIssueDetail({
    required this.next,
    required this.previous,
  });

  final NextIssueDetail? next;
  final PreviousIssueDetail? previous;

  Map<String, dynamic> toMap() {
    return {
      'next': next?.toMap(),
      'previous': previous?.toMap(),
    };
  }

  factory NeighborsIssueDetail.fromMap(Map<String, dynamic> map) {
    return NeighborsIssueDetail(
      next: map['next'] == null ? null : NextIssueDetail.fromMap(map['next']),
      previous: map['previous'] == null
          ? null
          : PreviousIssueDetail.fromMap(map['previous']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NeighborsIssueDetail.fromJson(String source) =>
      NeighborsIssueDetail.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NeighborsIssueDetail &&
        other.next == next &&
        other.previous == previous;
  }

  @override
  int get hashCode => next.hashCode ^ previous.hashCode;
}

class NextIssueDetail {
  const NextIssueDetail({
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

  factory NextIssueDetail.fromMap(Map<String, dynamic> map) {
    return NextIssueDetail(
      id: int.tryParse(map['id']?.toString() ?? ''),
      ref: int.tryParse(map['ref']?.toString() ?? ''),
      subject: map['subject'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NextIssueDetail.fromJson(String source) =>
      NextIssueDetail.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NextIssueDetail &&
        other.id == id &&
        other.ref == ref &&
        other.subject == subject;
  }

  @override
  int get hashCode => id.hashCode ^ ref.hashCode ^ subject.hashCode;
}

class PreviousIssueDetail {
  const PreviousIssueDetail({
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

  factory PreviousIssueDetail.fromMap(Map<String, dynamic> map) {
    return PreviousIssueDetail(
      id: int.tryParse(map['id']?.toString() ?? ''),
      ref: int.tryParse(map['ref']?.toString() ?? ''),
      subject: map['subject'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PreviousIssueDetail.fromJson(String source) =>
      PreviousIssueDetail.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PreviousIssueDetail &&
        other.id == id &&
        other.ref == ref &&
        other.subject == subject;
  }

  @override
  int get hashCode => id.hashCode ^ ref.hashCode ^ subject.hashCode;
}

class OwnerExtraInfoIssueDetail {
  const OwnerExtraInfoIssueDetail({
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

  factory OwnerExtraInfoIssueDetail.fromMap(Map<String, dynamic> map) {
    return OwnerExtraInfoIssueDetail(
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

  factory OwnerExtraInfoIssueDetail.fromJson(String source) =>
      OwnerExtraInfoIssueDetail.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OwnerExtraInfoIssueDetail &&
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

class ProjectExtraInfoIssueDetail {
  const ProjectExtraInfoIssueDetail({
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

  factory ProjectExtraInfoIssueDetail.fromMap(Map<String, dynamic> map) {
    return ProjectExtraInfoIssueDetail(
      id: int.tryParse(map['id']?.toString() ?? ''),
      logoSmallUrl: map['logo_small_url'],
      name: map['name'],
      slug: map['slug'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectExtraInfoIssueDetail.fromJson(String source) =>
      ProjectExtraInfoIssueDetail.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProjectExtraInfoIssueDetail &&
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

class StatusExtraInfoIssueDetail {
  const StatusExtraInfoIssueDetail({
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

  factory StatusExtraInfoIssueDetail.fromMap(Map<String, dynamic> map) {
    return StatusExtraInfoIssueDetail(
      color: map['color'],
      isClosed: map['is_closed'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusExtraInfoIssueDetail.fromJson(String source) =>
      StatusExtraInfoIssueDetail.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatusExtraInfoIssueDetail &&
        other.color == color &&
        other.isClosed == isClosed &&
        other.name == name;
  }

  @override
  int get hashCode => color.hashCode ^ isClosed.hashCode ^ name.hashCode;
}
