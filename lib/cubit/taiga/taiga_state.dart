part of 'taiga_cubit.dart';

class TaigaState {
  TaigaState({
    required this.loadingGlobal,
    required this.loadingContent,
    required this.projects,
    this.selectedProject,
    this.projectDetail,
  });

  final bool loadingGlobal;
  final bool loadingContent;
  final List<ProjectTaigaResponse> projects;
  final ProjectTaigaResponse? selectedProject;
  final ProjectDetailTaigaResponse? projectDetail;

  TaigaState copyWith({
    bool? loadingGlobal,
    bool? loadingContent,
    List<ProjectTaigaResponse>? projects,
    ProjectTaigaResponse? selectedProject,
    ProjectDetailTaigaResponse? projectDetail,
  }) {
    return TaigaState(
      loadingGlobal: loadingGlobal ?? this.loadingGlobal,
      loadingContent: loadingContent ?? this.loadingContent,
      projects: projects ?? this.projects,
      selectedProject: selectedProject ?? this.selectedProject,
      projectDetail: projectDetail ?? this.projectDetail,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaigaState &&
        other.loadingGlobal == loadingGlobal &&
        other.loadingContent == loadingContent &&
        listEquals(other.projects, projects) &&
        other.selectedProject == selectedProject &&
        other.projectDetail == projectDetail;
  }

  @override
  int get hashCode {
    return loadingGlobal.hashCode ^
        loadingContent.hashCode ^
        projects.hashCode ^
        selectedProject.hashCode ^
        projectDetail.hashCode;
  }
}
