import 'package:creaphur/models/default_model_list.dart';
import 'package:creaphur/models/project.dart';

class ProjectList extends DefaultModelList<Project> {
  ProjectList(List<Project> items) : super(items);

  void addProject(Project project) {
    add(project);
  }

  void removeProject(Project project) {
    remove(project);
  }

  void updateProject(Project project) {
    update(project);
  }

  void updateAllProjects(List<Project> updatedProjects) {
    updateAll(updatedProjects);
  }
}
