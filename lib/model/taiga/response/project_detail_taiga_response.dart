import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProjectDetailTaigaResponse {
  const ProjectDetailTaigaResponse({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.createdDate,
    required this.modifiedDate,
    required this.owner,
    required this.members,
    required this.totalMilestones,
    required this.totalStoryPoints,
    required this.isContactActivated,
    required this.isEpicsActivated,
    required this.isBacklogActivated,
    required this.isKanbanActivated,
    required this.isWikiActivated,
    required this.isIssuesActivated,
    required this.videoconferences,
    required this.videoconferencesExtraData,
    required this.creationTemplate,
    required this.isPrivate,
    required this.anonPermissions,
    required this.publicPermissions,
    required this.isFeatured,
    required this.isLookingForPeople,
    required this.lookingForPeopleNote,
    required this.blockedCode,
    required this.totalsUpdatedDatetime,
    required this.totalFans,
    required this.totalFansLastWeek,
    required this.totalFansLastMonth,
    required this.totalFansLastYear,
    required this.totalActivity,
    required this.totalActivityLastWeek,
    required this.totalActivityLastMonth,
    required this.totalActivityLastYear,
    required this.tags,
    required this.tagsColors,
    required this.defaultEpicStatus,
    required this.defaultPoints,
    required this.defaultUsStatus,
    required this.defaultTaskStatus,
    required this.defaultPriority,
    required this.defaultSeverity,
    required this.defaultIssueStatus,
    required this.defaultIssueType,
    required this.defaultSwimlane,
    required this.myPermissions,
    required this.iAmOwner,
    required this.iAmAdmin,
    required this.iAmMember,
    required this.notifyLevel,
    required this.totalClosedMilestones,
    required this.isWatcher,
    required this.totalWatchers,
    required this.logoSmallUrl,
    required this.logoBigUrl,
    required this.isFan,
    required this.myHomepage,
    required this.epicStatuses,
    required this.swimlanes,
    required this.usStatuses,
    required this.usDuedates,
    required this.points,
    required this.taskStatuses,
    required this.taskDuedates,
    required this.issueStatuses,
    required this.issueTypes,
    required this.issueDuedates,
    required this.priorities,
    required this.severities,
    required this.epicCustomAttributes,
    required this.userstoryCustomAttributes,
    required this.taskCustomAttributes,
    required this.issueCustomAttributes,
    required this.roles,
    required this.totalMemberships,
    required this.isOutOfOwnerLimits,
    required this.milestones,
  });

  final int? id;
  final String? name;
  final String? slug;
  final String? description;
  final DateTime? createdDate;
  final DateTime? modifiedDate;
  final OwnerProjectDetailTaiga? owner;
  final List<MembersProjectDetailTaiga>? members;
  final dynamic totalMilestones;
  final dynamic totalStoryPoints;
  final bool? isContactActivated;
  final bool? isEpicsActivated;
  final bool? isBacklogActivated;
  final bool? isKanbanActivated;
  final bool? isWikiActivated;
  final bool? isIssuesActivated;
  final dynamic videoconferences;
  final dynamic videoconferencesExtraData;
  final int? creationTemplate;
  final bool? isPrivate;
  final List<dynamic>? anonPermissions;
  final List<dynamic>? publicPermissions;
  final bool? isFeatured;
  final bool? isLookingForPeople;
  final String? lookingForPeopleNote;
  final dynamic blockedCode;
  final DateTime? totalsUpdatedDatetime;
  final int? totalFans;
  final int? totalFansLastWeek;
  final int? totalFansLastMonth;
  final int? totalFansLastYear;
  final int? totalActivity;
  final int? totalActivityLastWeek;
  final int? totalActivityLastMonth;
  final int? totalActivityLastYear;
  final List<dynamic>? tags;
  final TagsColorsProjectDetailTaiga? tagsColors;
  final int? defaultEpicStatus;
  final int? defaultPoints;
  final int? defaultUsStatus;
  final int? defaultTaskStatus;
  final int? defaultPriority;
  final int? defaultSeverity;
  final int? defaultIssueStatus;
  final int? defaultIssueType;
  final dynamic defaultSwimlane;
  final List<String>? myPermissions;
  final bool? iAmOwner;
  final bool? iAmAdmin;
  final bool? iAmMember;
  final int? notifyLevel;
  final int? totalClosedMilestones;
  final bool? isWatcher;
  final int? totalWatchers;
  final dynamic logoSmallUrl;
  final dynamic logoBigUrl;
  final bool? isFan;
  final int? myHomepage;
  final List<EpicStatusesProjectDetailTaiga>? epicStatuses;
  final dynamic swimlanes;
  final List<UsStatusesProjectDetailTaiga>? usStatuses;
  final List<UsDuedatesProjectDetailTaiga>? usDuedates;
  final List<PointsProjectDetailTaiga>? points;
  final List<TaskStatusesProjectDetailTaiga>? taskStatuses;
  final List<TaskDuedatesProjectDetailTaiga>? taskDuedates;
  final List<IssueStatusesProjectDetailTaiga>? issueStatuses;
  final List<IssueTypesProjectDetailTaiga>? issueTypes;
  final List<IssueDuedatesProjectDetailTaiga>? issueDuedates;
  final List<PrioritiesProjectDetailTaiga>? priorities;
  final List<SeveritiesProjectDetailTaiga>? severities;
  final dynamic epicCustomAttributes;
  final List<UserstoryCustomAttributesProjectDetailTaiga>?
      userstoryCustomAttributes;
  final dynamic taskCustomAttributes;
  final dynamic issueCustomAttributes;
  final List<RolesProjectDetailTaiga>? roles;
  final int? totalMemberships;
  final bool? isOutOfOwnerLimits;
  final List<MilestonesProjectDetailTaiga>? milestones;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'created_date': createdDate?.toIso8601String(),
      'modified_date': modifiedDate?.toIso8601String(),
      'owner': owner?.toMap(),
      'members': members?.map((e) => e.toMap()).toList(),
      'total_milestones': totalMilestones,
      'total_story_points': totalStoryPoints,
      'is_contact_activated': isContactActivated,
      'is_epics_activated': isEpicsActivated,
      'is_backlog_activated': isBacklogActivated,
      'is_kanban_activated': isKanbanActivated,
      'is_wiki_activated': isWikiActivated,
      'is_issues_activated': isIssuesActivated,
      'videoconferences': videoconferences,
      'videoconferences_extra_data': videoconferencesExtraData,
      'creation_template': creationTemplate,
      'is_private': isPrivate,
      'anon_permissions': anonPermissions,
      'public_permissions': publicPermissions,
      'is_featured': isFeatured,
      'is_looking_for_people': isLookingForPeople,
      'looking_for_people_note': lookingForPeopleNote,
      'blocked_code': blockedCode,
      'totals_updated_datetime': totalsUpdatedDatetime?.toIso8601String(),
      'total_fans': totalFans,
      'total_fans_last_week': totalFansLastWeek,
      'total_fans_last_month': totalFansLastMonth,
      'total_fans_last_year': totalFansLastYear,
      'total_activity': totalActivity,
      'total_activity_last_week': totalActivityLastWeek,
      'total_activity_last_month': totalActivityLastMonth,
      'total_activity_last_year': totalActivityLastYear,
      'tags': tags,
      'tags_colors': tagsColors?.toMap(),
      'default_epic_status': defaultEpicStatus,
      'default_points': defaultPoints,
      'default_us_status': defaultUsStatus,
      'default_task_status': defaultTaskStatus,
      'default_priority': defaultPriority,
      'default_severity': defaultSeverity,
      'default_issue_status': defaultIssueStatus,
      'default_issue_type': defaultIssueType,
      'default_swimlane': defaultSwimlane,
      'my_permissions': myPermissions,
      'i_am_owner': iAmOwner,
      'i_am_admin': iAmAdmin,
      'i_am_member': iAmMember,
      'notify_level': notifyLevel,
      'total_closed_milestones': totalClosedMilestones,
      'is_watcher': isWatcher,
      'total_watchers': totalWatchers,
      'logo_small_url': logoSmallUrl,
      'logo_big_url': logoBigUrl,
      'is_fan': isFan,
      'my_homepage': myHomepage,
      'epic_statuses': epicStatuses?.map((e) => e.toMap()).toList(),
      'swimlanes': swimlanes,
      'us_statuses': usStatuses?.map((e) => e.toMap()).toList(),
      'us_duedates': usDuedates?.map((e) => e.toMap()).toList(),
      'points': points?.map((e) => e.toMap()).toList(),
      'task_statuses': taskStatuses?.map((e) => e.toMap()).toList(),
      'task_duedates': taskDuedates?.map((e) => e.toMap()).toList(),
      'issue_statuses': issueStatuses?.map((e) => e.toMap()).toList(),
      'issue_types': issueTypes?.map((e) => e.toMap()).toList(),
      'issue_duedates': issueDuedates?.map((e) => e.toMap()).toList(),
      'priorities': priorities?.map((e) => e.toMap()).toList(),
      'severities': severities?.map((e) => e.toMap()).toList(),
      'epic_custom_attributes': epicCustomAttributes,
      'userstory_custom_attributes':
          userstoryCustomAttributes?.map((e) => e.toMap()).toList(),
      'task_custom_attributes': taskCustomAttributes,
      'issue_custom_attributes': issueCustomAttributes,
      'roles': roles?.map((e) => e.toMap()).toList(),
      'total_memberships': totalMemberships,
      'is_out_of_owner_limits': isOutOfOwnerLimits,
      'milestones': milestones?.map((e) => e.toMap()).toList(),
    };
  }

  factory ProjectDetailTaigaResponse.fromMap(Map<String, dynamic> map) {
    return ProjectDetailTaigaResponse(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      slug: map['slug'],
      description: map['description'],
      createdDate: DateTime.tryParse(map['created_date'] ?? ''),
      modifiedDate: DateTime.tryParse(map['modified_date'] ?? ''),
      owner: map['owner'] == null
          ? null
          : OwnerProjectDetailTaiga.fromMap(map['owner']),
      members: map['members'] == null
          ? null
          : List.from((map['members'] as List)
              .map((e) => MembersProjectDetailTaiga.fromMap(e))),
      totalMilestones: map['total_milestones'],
      totalStoryPoints: map['total_story_points'],
      isContactActivated: map['is_contact_activated'],
      isEpicsActivated: map['is_epics_activated'],
      isBacklogActivated: map['is_backlog_activated'],
      isKanbanActivated: map['is_kanban_activated'],
      isWikiActivated: map['is_wiki_activated'],
      isIssuesActivated: map['is_issues_activated'],
      videoconferences: map['videoconferences'],
      videoconferencesExtraData: map['videoconferences_extra_data'],
      creationTemplate:
          int.tryParse(map['creation_template']?.toString() ?? ''),
      isPrivate: map['is_private'],
      anonPermissions: map['anon_permissions'],
      publicPermissions: map['public_permissions'],
      isFeatured: map['is_featured'],
      isLookingForPeople: map['is_looking_for_people'],
      lookingForPeopleNote: map['looking_for_people_note'],
      blockedCode: map['blocked_code'],
      totalsUpdatedDatetime:
          DateTime.tryParse(map['totals_updated_datetime'] ?? ''),
      totalFans: int.tryParse(map['total_fans']?.toString() ?? ''),
      totalFansLastWeek:
          int.tryParse(map['total_fans_last_week']?.toString() ?? ''),
      totalFansLastMonth:
          int.tryParse(map['total_fans_last_month']?.toString() ?? ''),
      totalFansLastYear:
          int.tryParse(map['total_fans_last_year']?.toString() ?? ''),
      totalActivity: int.tryParse(map['total_activity']?.toString() ?? ''),
      totalActivityLastWeek:
          int.tryParse(map['total_activity_last_week']?.toString() ?? ''),
      totalActivityLastMonth:
          int.tryParse(map['total_activity_last_month']?.toString() ?? ''),
      totalActivityLastYear:
          int.tryParse(map['total_activity_last_year']?.toString() ?? ''),
      tags: map['tags'],
      tagsColors: map['tags_colors'] == null
          ? null
          : TagsColorsProjectDetailTaiga.fromMap(map['tags_colors']),
      defaultEpicStatus:
          int.tryParse(map['default_epic_status']?.toString() ?? ''),
      defaultPoints: int.tryParse(map['default_points']?.toString() ?? ''),
      defaultUsStatus: int.tryParse(map['default_us_status']?.toString() ?? ''),
      defaultTaskStatus:
          int.tryParse(map['default_task_status']?.toString() ?? ''),
      defaultPriority: int.tryParse(map['default_priority']?.toString() ?? ''),
      defaultSeverity: int.tryParse(map['default_severity']?.toString() ?? ''),
      defaultIssueStatus:
          int.tryParse(map['default_issue_status']?.toString() ?? ''),
      defaultIssueType:
          int.tryParse(map['default_issue_type']?.toString() ?? ''),
      defaultSwimlane: map['default_swimlane'],
      myPermissions: map['my_permissions'] == null
          ? null
          : List.from(map['my_permissions']),
      iAmOwner: map['i_am_owner'],
      iAmAdmin: map['i_am_admin'],
      iAmMember: map['i_am_member'],
      notifyLevel: int.tryParse(map['notify_level']?.toString() ?? ''),
      totalClosedMilestones:
          int.tryParse(map['total_closed_milestones']?.toString() ?? ''),
      isWatcher: map['is_watcher'],
      totalWatchers: int.tryParse(map['total_watchers']?.toString() ?? ''),
      logoSmallUrl: map['logo_small_url'],
      logoBigUrl: map['logo_big_url'],
      isFan: map['is_fan'],
      myHomepage: int.tryParse(map['my_homepage']?.toString() ?? ''),
      epicStatuses: map['epic_statuses'] == null
          ? null
          : List.from((map['epic_statuses'] as List)
              .map((e) => EpicStatusesProjectDetailTaiga.fromMap(e))),
      swimlanes: map['swimlanes'],
      usStatuses: map['us_statuses'] == null
          ? null
          : List.from((map['us_statuses'] as List)
              .map((e) => UsStatusesProjectDetailTaiga.fromMap(e))),
      usDuedates: map['us_duedates'] == null
          ? null
          : List.from((map['us_duedates'] as List)
              .map((e) => UsDuedatesProjectDetailTaiga.fromMap(e))),
      points: map['points'] == null
          ? null
          : List.from((map['points'] as List)
              .map((e) => PointsProjectDetailTaiga.fromMap(e))),
      taskStatuses: map['task_statuses'] == null
          ? null
          : List.from((map['task_statuses'] as List)
              .map((e) => TaskStatusesProjectDetailTaiga.fromMap(e))),
      taskDuedates: map['task_duedates'] == null
          ? null
          : List.from((map['task_duedates'] as List)
              .map((e) => TaskDuedatesProjectDetailTaiga.fromMap(e))),
      issueStatuses: map['issue_statuses'] == null
          ? null
          : List.from((map['issue_statuses'] as List)
              .map((e) => IssueStatusesProjectDetailTaiga.fromMap(e))),
      issueTypes: map['issue_types'] == null
          ? null
          : List.from((map['issue_types'] as List)
              .map((e) => IssueTypesProjectDetailTaiga.fromMap(e))),
      issueDuedates: map['issue_duedates'] == null
          ? null
          : List.from((map['issue_duedates'] as List)
              .map((e) => IssueDuedatesProjectDetailTaiga.fromMap(e))),
      priorities: map['priorities'] == null
          ? null
          : List.from((map['priorities'] as List)
              .map((e) => PrioritiesProjectDetailTaiga.fromMap(e))),
      severities: map['severities'] == null
          ? null
          : List.from((map['severities'] as List)
              .map((e) => SeveritiesProjectDetailTaiga.fromMap(e))),
      epicCustomAttributes: map['epic_custom_attributes'],
      userstoryCustomAttributes: map['userstory_custom_attributes'] == null
          ? null
          : List.from((map['userstory_custom_attributes'] as List).map(
              (e) => UserstoryCustomAttributesProjectDetailTaiga.fromMap(e))),
      taskCustomAttributes: map['task_custom_attributes'],
      issueCustomAttributes: map['issue_custom_attributes'],
      roles: map['roles'] == null
          ? null
          : List.from((map['roles'] as List)
              .map((e) => RolesProjectDetailTaiga.fromMap(e))),
      totalMemberships:
          int.tryParse(map['total_memberships']?.toString() ?? ''),
      isOutOfOwnerLimits: map['is_out_of_owner_limits'],
      milestones: map['milestones'] == null
          ? null
          : List.from((map['milestones'] as List)
              .map((e) => MilestonesProjectDetailTaiga.fromMap(e))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectDetailTaigaResponse.fromJson(String source) =>
      ProjectDetailTaigaResponse.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProjectDetailTaigaResponse &&
        other.id == id &&
        other.name == name &&
        other.slug == slug &&
        other.description == description &&
        other.createdDate == createdDate &&
        other.modifiedDate == modifiedDate &&
        other.owner == owner &&
        listEquals(other.members, members) &&
        other.totalMilestones == totalMilestones &&
        other.totalStoryPoints == totalStoryPoints &&
        other.isContactActivated == isContactActivated &&
        other.isEpicsActivated == isEpicsActivated &&
        other.isBacklogActivated == isBacklogActivated &&
        other.isKanbanActivated == isKanbanActivated &&
        other.isWikiActivated == isWikiActivated &&
        other.isIssuesActivated == isIssuesActivated &&
        other.videoconferences == videoconferences &&
        other.videoconferencesExtraData == videoconferencesExtraData &&
        other.creationTemplate == creationTemplate &&
        other.isPrivate == isPrivate &&
        listEquals(other.anonPermissions, anonPermissions) &&
        listEquals(other.publicPermissions, publicPermissions) &&
        other.isFeatured == isFeatured &&
        other.isLookingForPeople == isLookingForPeople &&
        other.lookingForPeopleNote == lookingForPeopleNote &&
        other.blockedCode == blockedCode &&
        other.totalsUpdatedDatetime == totalsUpdatedDatetime &&
        other.totalFans == totalFans &&
        other.totalFansLastWeek == totalFansLastWeek &&
        other.totalFansLastMonth == totalFansLastMonth &&
        other.totalFansLastYear == totalFansLastYear &&
        other.totalActivity == totalActivity &&
        other.totalActivityLastWeek == totalActivityLastWeek &&
        other.totalActivityLastMonth == totalActivityLastMonth &&
        other.totalActivityLastYear == totalActivityLastYear &&
        listEquals(other.tags, tags) &&
        other.tagsColors == tagsColors &&
        other.defaultEpicStatus == defaultEpicStatus &&
        other.defaultPoints == defaultPoints &&
        other.defaultUsStatus == defaultUsStatus &&
        other.defaultTaskStatus == defaultTaskStatus &&
        other.defaultPriority == defaultPriority &&
        other.defaultSeverity == defaultSeverity &&
        other.defaultIssueStatus == defaultIssueStatus &&
        other.defaultIssueType == defaultIssueType &&
        other.defaultSwimlane == defaultSwimlane &&
        listEquals(other.myPermissions, myPermissions) &&
        other.iAmOwner == iAmOwner &&
        other.iAmAdmin == iAmAdmin &&
        other.iAmMember == iAmMember &&
        other.notifyLevel == notifyLevel &&
        other.totalClosedMilestones == totalClosedMilestones &&
        other.isWatcher == isWatcher &&
        other.totalWatchers == totalWatchers &&
        other.logoSmallUrl == logoSmallUrl &&
        other.logoBigUrl == logoBigUrl &&
        other.isFan == isFan &&
        other.myHomepage == myHomepage &&
        listEquals(other.epicStatuses, epicStatuses) &&
        other.swimlanes == swimlanes &&
        listEquals(other.usStatuses, usStatuses) &&
        listEquals(other.usDuedates, usDuedates) &&
        listEquals(other.points, points) &&
        listEquals(other.taskStatuses, taskStatuses) &&
        listEquals(other.taskDuedates, taskDuedates) &&
        listEquals(other.issueStatuses, issueStatuses) &&
        listEquals(other.issueTypes, issueTypes) &&
        listEquals(other.issueDuedates, issueDuedates) &&
        listEquals(other.priorities, priorities) &&
        listEquals(other.severities, severities) &&
        other.epicCustomAttributes == epicCustomAttributes &&
        other.taskCustomAttributes == taskCustomAttributes &&
        other.issueCustomAttributes == issueCustomAttributes &&
        listEquals(other.roles, roles) &&
        other.totalMemberships == totalMemberships &&
        other.isOutOfOwnerLimits == isOutOfOwnerLimits &&
        listEquals(other.milestones, milestones);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        slug.hashCode ^
        description.hashCode ^
        createdDate.hashCode ^
        modifiedDate.hashCode ^
        owner.hashCode ^
        members.hashCode ^
        totalMilestones.hashCode ^
        totalStoryPoints.hashCode ^
        isContactActivated.hashCode ^
        isEpicsActivated.hashCode ^
        isBacklogActivated.hashCode ^
        isKanbanActivated.hashCode ^
        isWikiActivated.hashCode ^
        isIssuesActivated.hashCode ^
        videoconferences.hashCode ^
        videoconferencesExtraData.hashCode ^
        creationTemplate.hashCode ^
        isPrivate.hashCode ^
        anonPermissions.hashCode ^
        publicPermissions.hashCode ^
        isFeatured.hashCode ^
        isLookingForPeople.hashCode ^
        lookingForPeopleNote.hashCode ^
        blockedCode.hashCode ^
        totalsUpdatedDatetime.hashCode ^
        totalFans.hashCode ^
        totalFansLastWeek.hashCode ^
        totalFansLastMonth.hashCode ^
        totalFansLastYear.hashCode ^
        totalActivity.hashCode ^
        totalActivityLastWeek.hashCode ^
        totalActivityLastMonth.hashCode ^
        totalActivityLastYear.hashCode ^
        tags.hashCode ^
        tagsColors.hashCode ^
        defaultEpicStatus.hashCode ^
        defaultPoints.hashCode ^
        defaultUsStatus.hashCode ^
        defaultTaskStatus.hashCode ^
        defaultPriority.hashCode ^
        defaultSeverity.hashCode ^
        defaultIssueStatus.hashCode ^
        defaultIssueType.hashCode ^
        defaultSwimlane.hashCode ^
        myPermissions.hashCode ^
        iAmOwner.hashCode ^
        iAmAdmin.hashCode ^
        iAmMember.hashCode ^
        notifyLevel.hashCode ^
        totalClosedMilestones.hashCode ^
        isWatcher.hashCode ^
        totalWatchers.hashCode ^
        logoSmallUrl.hashCode ^
        logoBigUrl.hashCode ^
        isFan.hashCode ^
        myHomepage.hashCode ^
        epicStatuses.hashCode ^
        swimlanes.hashCode ^
        usStatuses.hashCode ^
        usDuedates.hashCode ^
        points.hashCode ^
        taskStatuses.hashCode ^
        taskDuedates.hashCode ^
        issueStatuses.hashCode ^
        issueTypes.hashCode ^
        issueDuedates.hashCode ^
        priorities.hashCode ^
        severities.hashCode ^
        epicCustomAttributes.hashCode ^
        taskCustomAttributes.hashCode ^
        issueCustomAttributes.hashCode ^
        roles.hashCode ^
        totalMemberships.hashCode ^
        isOutOfOwnerLimits.hashCode ^
        milestones.hashCode;
  }
}

class OwnerProjectDetailTaiga {
  const OwnerProjectDetailTaiga({
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

  factory OwnerProjectDetailTaiga.fromMap(Map<String, dynamic> map) {
    return OwnerProjectDetailTaiga(
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

  factory OwnerProjectDetailTaiga.fromJson(String source) =>
      OwnerProjectDetailTaiga.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OwnerProjectDetailTaiga &&
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

class TagsColorsProjectDetailTaiga {
  const TagsColorsProjectDetailTaiga({
    required this.mobile,
    required this.cms,
    required this.feature,
    required this.architecture,
    required this.defect,
    required this.nonFunctional,
    required this.be,
    required this.web,
    required this.webMerchant,
    required this.pds,
  });

  final dynamic mobile;
  final dynamic cms;
  final String? feature;
  final dynamic architecture;
  final String? defect;
  final String? nonFunctional;
  final dynamic be;
  final String? web;
  final String? webMerchant;
  final dynamic pds;

  Map<String, dynamic> toMap() {
    return {
      'mobile': mobile,
      'cms': cms,
      'feature': feature,
      'architecture': architecture,
      'defect': defect,
      'non-functional': nonFunctional,
      'be': be,
      'web': web,
      'web merchant': webMerchant,
      'pds': pds,
    };
  }

  factory TagsColorsProjectDetailTaiga.fromMap(Map<String, dynamic> map) {
    return TagsColorsProjectDetailTaiga(
      mobile: map['mobile'],
      cms: map['cms'],
      feature: map['feature'],
      architecture: map['architecture'],
      defect: map['defect'],
      nonFunctional: map['non-functional'],
      be: map['be'],
      web: map['web'],
      webMerchant: map['web merchant'],
      pds: map['pds'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TagsColorsProjectDetailTaiga.fromJson(String source) =>
      TagsColorsProjectDetailTaiga.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TagsColorsProjectDetailTaiga &&
        other.mobile == mobile &&
        other.cms == cms &&
        other.feature == feature &&
        other.architecture == architecture &&
        other.defect == defect &&
        other.nonFunctional == nonFunctional &&
        other.be == be &&
        other.web == web &&
        other.webMerchant == webMerchant &&
        other.pds == pds;
  }

  @override
  int get hashCode {
    return mobile.hashCode ^
        cms.hashCode ^
        feature.hashCode ^
        architecture.hashCode ^
        defect.hashCode ^
        nonFunctional.hashCode ^
        be.hashCode ^
        web.hashCode ^
        webMerchant.hashCode ^
        pds.hashCode;
  }
}

class MembersProjectDetailTaiga {
  const MembersProjectDetailTaiga({
    required this.role,
    required this.roleName,
    required this.fullName,
    required this.fullNameDisplay,
    required this.isActive,
    required this.id,
    required this.color,
    required this.username,
    required this.photo,
    required this.gravatarId,
  });

  final int? role;
  final String? roleName;
  final String? fullName;
  final String? fullNameDisplay;
  final bool? isActive;
  final int? id;
  final String? color;
  final String? username;
  final String? photo;
  final String? gravatarId;

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'role_name': roleName,
      'full_name': fullName,
      'full_name_display': fullNameDisplay,
      'is_active': isActive,
      'id': id,
      'color': color,
      'username': username,
      'photo': photo,
      'gravatar_id': gravatarId,
    };
  }

  factory MembersProjectDetailTaiga.fromMap(Map<String, dynamic> map) {
    return MembersProjectDetailTaiga(
      role: int.tryParse(map['role']?.toString() ?? ''),
      roleName: map['role_name'],
      fullName: map['full_name'],
      fullNameDisplay: map['full_name_display'],
      isActive: map['is_active'],
      id: int.tryParse(map['id']?.toString() ?? ''),
      color: map['color'],
      username: map['username'],
      photo: map['photo'],
      gravatarId: map['gravatar_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MembersProjectDetailTaiga.fromJson(String source) =>
      MembersProjectDetailTaiga.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MembersProjectDetailTaiga &&
        other.role == role &&
        other.roleName == roleName &&
        other.fullName == fullName &&
        other.fullNameDisplay == fullNameDisplay &&
        other.isActive == isActive &&
        other.id == id &&
        other.color == color &&
        other.username == username &&
        other.photo == photo &&
        other.gravatarId == gravatarId;
  }

  @override
  int get hashCode {
    return role.hashCode ^
        roleName.hashCode ^
        fullName.hashCode ^
        fullNameDisplay.hashCode ^
        isActive.hashCode ^
        id.hashCode ^
        color.hashCode ^
        username.hashCode ^
        photo.hashCode ^
        gravatarId.hashCode;
  }
}

class EpicStatusesProjectDetailTaiga {
  const EpicStatusesProjectDetailTaiga({
    required this.id,
    required this.name,
    required this.slug,
    required this.order,
    required this.isClosed,
    required this.color,
    required this.projectId,
  });

  final int? id;
  final String? name;
  final String? slug;
  final int? order;
  final bool? isClosed;
  final String? color;
  final int? projectId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'order': order,
      'is_closed': isClosed,
      'color': color,
      'project_id': projectId,
    };
  }

  factory EpicStatusesProjectDetailTaiga.fromMap(Map<String, dynamic> map) {
    return EpicStatusesProjectDetailTaiga(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      slug: map['slug'],
      order: int.tryParse(map['order']?.toString() ?? ''),
      isClosed: map['is_closed'],
      color: map['color'],
      projectId: int.tryParse(map['project_id']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpicStatusesProjectDetailTaiga.fromJson(String source) =>
      EpicStatusesProjectDetailTaiga.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EpicStatusesProjectDetailTaiga &&
        other.id == id &&
        other.name == name &&
        other.slug == slug &&
        other.order == order &&
        other.isClosed == isClosed &&
        other.color == color &&
        other.projectId == projectId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        slug.hashCode ^
        order.hashCode ^
        isClosed.hashCode ^
        color.hashCode ^
        projectId.hashCode;
  }
}

class UsStatusesProjectDetailTaiga {
  const UsStatusesProjectDetailTaiga({
    required this.id,
    required this.name,
    required this.order,
    required this.isClosed,
    required this.color,
    required this.wipLimit,
    required this.projectId,
    required this.slug,
    required this.isArchived,
  });

  final int? id;
  final String? name;
  final int? order;
  final bool? isClosed;
  final String? color;
  final dynamic wipLimit;
  final int? projectId;
  final String? slug;
  final bool? isArchived;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'order': order,
      'is_closed': isClosed,
      'color': color,
      'wip_limit': wipLimit,
      'project_id': projectId,
      'slug': slug,
      'is_archived': isArchived,
    };
  }

  factory UsStatusesProjectDetailTaiga.fromMap(Map<String, dynamic> map) {
    return UsStatusesProjectDetailTaiga(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      order: int.tryParse(map['order']?.toString() ?? ''),
      isClosed: map['is_closed'],
      color: map['color'],
      wipLimit: map['wip_limit'],
      projectId: int.tryParse(map['project_id']?.toString() ?? ''),
      slug: map['slug'],
      isArchived: map['is_archived'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UsStatusesProjectDetailTaiga.fromJson(String source) =>
      UsStatusesProjectDetailTaiga.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsStatusesProjectDetailTaiga &&
        other.id == id &&
        other.name == name &&
        other.order == order &&
        other.isClosed == isClosed &&
        other.color == color &&
        other.wipLimit == wipLimit &&
        other.projectId == projectId &&
        other.slug == slug &&
        other.isArchived == isArchived;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        order.hashCode ^
        isClosed.hashCode ^
        color.hashCode ^
        wipLimit.hashCode ^
        projectId.hashCode ^
        slug.hashCode ^
        isArchived.hashCode;
  }
}

class UsDuedatesProjectDetailTaiga {
  const UsDuedatesProjectDetailTaiga({
    required this.id,
    required this.name,
    required this.order,
    required this.byDefault,
    required this.color,
    required this.daysToDue,
    required this.projectId,
  });

  final int? id;
  final String? name;
  final int? order;
  final bool? byDefault;
  final String? color;
  final dynamic daysToDue;
  final int? projectId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'order': order,
      'by_default': byDefault,
      'color': color,
      'days_to_due': daysToDue,
      'project_id': projectId,
    };
  }

  factory UsDuedatesProjectDetailTaiga.fromMap(Map<String, dynamic> map) {
    return UsDuedatesProjectDetailTaiga(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      order: int.tryParse(map['order']?.toString() ?? ''),
      byDefault: map['by_default'],
      color: map['color'],
      daysToDue: map['days_to_due'],
      projectId: int.tryParse(map['project_id']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory UsDuedatesProjectDetailTaiga.fromJson(String source) =>
      UsDuedatesProjectDetailTaiga.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsDuedatesProjectDetailTaiga &&
        other.id == id &&
        other.name == name &&
        other.order == order &&
        other.byDefault == byDefault &&
        other.color == color &&
        other.daysToDue == daysToDue &&
        other.projectId == projectId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        order.hashCode ^
        byDefault.hashCode ^
        color.hashCode ^
        daysToDue.hashCode ^
        projectId.hashCode;
  }
}

class PointsProjectDetailTaiga {
  const PointsProjectDetailTaiga({
    required this.id,
    required this.name,
    required this.order,
    required this.value,
    required this.projectId,
  });

  final int? id;
  final String? name;
  final int? order;
  final dynamic value;
  final int? projectId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'order': order,
      'value': value,
      'project_id': projectId,
    };
  }

  factory PointsProjectDetailTaiga.fromMap(Map<String, dynamic> map) {
    return PointsProjectDetailTaiga(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      order: int.tryParse(map['order']?.toString() ?? ''),
      value: map['value'],
      projectId: int.tryParse(map['project_id']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory PointsProjectDetailTaiga.fromJson(String source) =>
      PointsProjectDetailTaiga.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PointsProjectDetailTaiga &&
        other.id == id &&
        other.name == name &&
        other.order == order &&
        other.value == value &&
        other.projectId == projectId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        order.hashCode ^
        value.hashCode ^
        projectId.hashCode;
  }
}

class TaskStatusesProjectDetailTaiga {
  const TaskStatusesProjectDetailTaiga({
    required this.id,
    required this.name,
    required this.order,
    required this.isClosed,
    required this.color,
    required this.projectId,
    required this.slug,
  });

  final int? id;
  final String? name;
  final int? order;
  final bool? isClosed;
  final String? color;
  final int? projectId;
  final String? slug;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'order': order,
      'is_closed': isClosed,
      'color': color,
      'project_id': projectId,
      'slug': slug,
    };
  }

  factory TaskStatusesProjectDetailTaiga.fromMap(Map<String, dynamic> map) {
    return TaskStatusesProjectDetailTaiga(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      order: int.tryParse(map['order']?.toString() ?? ''),
      isClosed: map['is_closed'],
      color: map['color'],
      projectId: int.tryParse(map['project_id']?.toString() ?? ''),
      slug: map['slug'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskStatusesProjectDetailTaiga.fromJson(String source) =>
      TaskStatusesProjectDetailTaiga.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskStatusesProjectDetailTaiga &&
        other.id == id &&
        other.name == name &&
        other.order == order &&
        other.isClosed == isClosed &&
        other.color == color &&
        other.projectId == projectId &&
        other.slug == slug;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        order.hashCode ^
        isClosed.hashCode ^
        color.hashCode ^
        projectId.hashCode ^
        slug.hashCode;
  }
}

class TaskDuedatesProjectDetailTaiga {
  const TaskDuedatesProjectDetailTaiga({
    required this.id,
    required this.name,
    required this.order,
    required this.byDefault,
    required this.color,
    required this.daysToDue,
    required this.projectId,
  });

  final int? id;
  final String? name;
  final int? order;
  final bool? byDefault;
  final String? color;
  final dynamic daysToDue;
  final int? projectId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'order': order,
      'by_default': byDefault,
      'color': color,
      'days_to_due': daysToDue,
      'project_id': projectId,
    };
  }

  factory TaskDuedatesProjectDetailTaiga.fromMap(Map<String, dynamic> map) {
    return TaskDuedatesProjectDetailTaiga(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      order: int.tryParse(map['order']?.toString() ?? ''),
      byDefault: map['by_default'],
      color: map['color'],
      daysToDue: map['days_to_due'],
      projectId: int.tryParse(map['project_id']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskDuedatesProjectDetailTaiga.fromJson(String source) =>
      TaskDuedatesProjectDetailTaiga.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskDuedatesProjectDetailTaiga &&
        other.id == id &&
        other.name == name &&
        other.order == order &&
        other.byDefault == byDefault &&
        other.color == color &&
        other.daysToDue == daysToDue &&
        other.projectId == projectId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        order.hashCode ^
        byDefault.hashCode ^
        color.hashCode ^
        daysToDue.hashCode ^
        projectId.hashCode;
  }
}

class IssueStatusesProjectDetailTaiga {
  const IssueStatusesProjectDetailTaiga({
    required this.id,
    required this.name,
    required this.order,
    required this.isClosed,
    required this.color,
    required this.projectId,
    required this.slug,
  });

  final int? id;
  final String? name;
  final int? order;
  final bool? isClosed;
  final String? color;
  final int? projectId;
  final String? slug;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'order': order,
      'is_closed': isClosed,
      'color': color,
      'project_id': projectId,
      'slug': slug,
    };
  }

  factory IssueStatusesProjectDetailTaiga.fromMap(Map<String, dynamic> map) {
    return IssueStatusesProjectDetailTaiga(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      order: int.tryParse(map['order']?.toString() ?? ''),
      isClosed: map['is_closed'],
      color: map['color'],
      projectId: int.tryParse(map['project_id']?.toString() ?? ''),
      slug: map['slug'],
    );
  }

  String toJson() => json.encode(toMap());

  factory IssueStatusesProjectDetailTaiga.fromJson(String source) =>
      IssueStatusesProjectDetailTaiga.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IssueStatusesProjectDetailTaiga &&
        other.id == id &&
        other.name == name &&
        other.order == order &&
        other.isClosed == isClosed &&
        other.color == color &&
        other.projectId == projectId &&
        other.slug == slug;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        order.hashCode ^
        isClosed.hashCode ^
        color.hashCode ^
        projectId.hashCode ^
        slug.hashCode;
  }
}

class IssueTypesProjectDetailTaiga {
  const IssueTypesProjectDetailTaiga({
    required this.id,
    required this.name,
    required this.order,
    required this.color,
    required this.projectId,
  });

  final int? id;
  final String? name;
  final int? order;
  final String? color;
  final int? projectId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'order': order,
      'color': color,
      'project_id': projectId,
    };
  }

  factory IssueTypesProjectDetailTaiga.fromMap(Map<String, dynamic> map) {
    return IssueTypesProjectDetailTaiga(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      order: int.tryParse(map['order']?.toString() ?? ''),
      color: map['color'],
      projectId: int.tryParse(map['project_id']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory IssueTypesProjectDetailTaiga.fromJson(String source) =>
      IssueTypesProjectDetailTaiga.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IssueTypesProjectDetailTaiga &&
        other.id == id &&
        other.name == name &&
        other.order == order &&
        other.color == color &&
        other.projectId == projectId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        order.hashCode ^
        color.hashCode ^
        projectId.hashCode;
  }
}

class IssueDuedatesProjectDetailTaiga {
  const IssueDuedatesProjectDetailTaiga({
    required this.id,
    required this.name,
    required this.order,
    required this.byDefault,
    required this.color,
    required this.daysToDue,
    required this.projectId,
  });

  final int? id;
  final String? name;
  final int? order;
  final bool? byDefault;
  final String? color;
  final dynamic daysToDue;
  final int? projectId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'order': order,
      'by_default': byDefault,
      'color': color,
      'days_to_due': daysToDue,
      'project_id': projectId,
    };
  }

  factory IssueDuedatesProjectDetailTaiga.fromMap(Map<String, dynamic> map) {
    return IssueDuedatesProjectDetailTaiga(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      order: int.tryParse(map['order']?.toString() ?? ''),
      byDefault: map['by_default'],
      color: map['color'],
      daysToDue: map['days_to_due'],
      projectId: int.tryParse(map['project_id']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory IssueDuedatesProjectDetailTaiga.fromJson(String source) =>
      IssueDuedatesProjectDetailTaiga.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IssueDuedatesProjectDetailTaiga &&
        other.id == id &&
        other.name == name &&
        other.order == order &&
        other.byDefault == byDefault &&
        other.color == color &&
        other.daysToDue == daysToDue &&
        other.projectId == projectId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        order.hashCode ^
        byDefault.hashCode ^
        color.hashCode ^
        daysToDue.hashCode ^
        projectId.hashCode;
  }
}

class PrioritiesProjectDetailTaiga {
  const PrioritiesProjectDetailTaiga({
    required this.id,
    required this.name,
    required this.order,
    required this.color,
    required this.projectId,
  });

  final int? id;
  final String? name;
  final int? order;
  final String? color;
  final int? projectId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'order': order,
      'color': color,
      'project_id': projectId,
    };
  }

  factory PrioritiesProjectDetailTaiga.fromMap(Map<String, dynamic> map) {
    return PrioritiesProjectDetailTaiga(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      order: int.tryParse(map['order']?.toString() ?? ''),
      color: map['color'],
      projectId: int.tryParse(map['project_id']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory PrioritiesProjectDetailTaiga.fromJson(String source) =>
      PrioritiesProjectDetailTaiga.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PrioritiesProjectDetailTaiga &&
        other.id == id &&
        other.name == name &&
        other.order == order &&
        other.color == color &&
        other.projectId == projectId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        order.hashCode ^
        color.hashCode ^
        projectId.hashCode;
  }
}

class SeveritiesProjectDetailTaiga {
  const SeveritiesProjectDetailTaiga({
    required this.id,
    required this.name,
    required this.order,
    required this.color,
    required this.projectId,
  });

  final int? id;
  final String? name;
  final int? order;
  final String? color;
  final int? projectId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'order': order,
      'color': color,
      'project_id': projectId,
    };
  }

  factory SeveritiesProjectDetailTaiga.fromMap(Map<String, dynamic> map) {
    return SeveritiesProjectDetailTaiga(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      order: int.tryParse(map['order']?.toString() ?? ''),
      color: map['color'],
      projectId: int.tryParse(map['project_id']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory SeveritiesProjectDetailTaiga.fromJson(String source) =>
      SeveritiesProjectDetailTaiga.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SeveritiesProjectDetailTaiga &&
        other.id == id &&
        other.name == name &&
        other.order == order &&
        other.color == color &&
        other.projectId == projectId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        order.hashCode ^
        color.hashCode ^
        projectId.hashCode;
  }
}

class UserstoryCustomAttributesProjectDetailTaiga {
  const UserstoryCustomAttributesProjectDetailTaiga({
    required this.id,
    required this.name,
    required this.description,
    required this.order,
    required this.createdDate,
    required this.modifiedDate,
    required this.projectId,
    required this.type,
    required this.extra,
  });

  final int? id;
  final String? name;
  final String? description;
  final int? order;
  final String? createdDate;
  final String? modifiedDate;
  final int? projectId;
  final String? type;
  final dynamic extra;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'order': order,
      'created_date': createdDate,
      'modified_date': modifiedDate,
      'project_id': projectId,
      'type': type,
      'extra': extra,
    };
  }

  factory UserstoryCustomAttributesProjectDetailTaiga.fromMap(
      Map<String, dynamic> map) {
    return UserstoryCustomAttributesProjectDetailTaiga(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      description: map['description'],
      order: int.tryParse(map['order']?.toString() ?? ''),
      createdDate: map['created_date'],
      modifiedDate: map['modified_date'],
      projectId: int.tryParse(map['project_id']?.toString() ?? ''),
      type: map['type'],
      extra: map['extra'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserstoryCustomAttributesProjectDetailTaiga.fromJson(String source) =>
      UserstoryCustomAttributesProjectDetailTaiga.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserstoryCustomAttributesProjectDetailTaiga &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.order == order &&
        other.createdDate == createdDate &&
        other.modifiedDate == modifiedDate &&
        other.projectId == projectId &&
        other.type == type &&
        other.extra == extra;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        order.hashCode ^
        createdDate.hashCode ^
        modifiedDate.hashCode ^
        projectId.hashCode ^
        type.hashCode ^
        extra.hashCode;
  }
}

class RolesProjectDetailTaiga {
  const RolesProjectDetailTaiga({
    required this.id,
    required this.name,
    required this.slug,
    required this.permissions,
    required this.order,
    required this.computable,
    required this.projectId,
  });

  final int? id;
  final String? name;
  final String? slug;
  final List<String>? permissions;
  final int? order;
  final bool? computable;
  final int? projectId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'permissions': permissions,
      'order': order,
      'computable': computable,
      'project_id': projectId,
    };
  }

  factory RolesProjectDetailTaiga.fromMap(Map<String, dynamic> map) {
    return RolesProjectDetailTaiga(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      slug: map['slug'],
      permissions:
          map['permissions'] == null ? null : List.from(map['permissions']),
      order: int.tryParse(map['order']?.toString() ?? ''),
      computable: map['computable'],
      projectId: int.tryParse(map['project_id']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory RolesProjectDetailTaiga.fromJson(String source) =>
      RolesProjectDetailTaiga.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RolesProjectDetailTaiga &&
        other.id == id &&
        other.name == name &&
        other.slug == slug &&
        listEquals(other.permissions, permissions) &&
        other.order == order &&
        other.computable == computable &&
        other.projectId == projectId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        slug.hashCode ^
        permissions.hashCode ^
        order.hashCode ^
        computable.hashCode ^
        projectId.hashCode;
  }
}

class MilestonesProjectDetailTaiga {
  const MilestonesProjectDetailTaiga({
    required this.id,
    required this.slug,
    required this.name,
    required this.closed,
  });

  final int? id;
  final String? slug;
  final String? name;
  final bool? closed;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'closed': closed,
    };
  }

  factory MilestonesProjectDetailTaiga.fromMap(Map<String, dynamic> map) {
    return MilestonesProjectDetailTaiga(
      id: int.tryParse(map['id']?.toString() ?? ''),
      slug: map['slug'],
      name: map['name'],
      closed: map['closed'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MilestonesProjectDetailTaiga.fromJson(String source) =>
      MilestonesProjectDetailTaiga.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MilestonesProjectDetailTaiga &&
        other.id == id &&
        other.slug == slug &&
        other.name == name &&
        other.closed == closed;
  }

  @override
  int get hashCode {
    return id.hashCode ^ slug.hashCode ^ name.hashCode ^ closed.hashCode;
  }
}
