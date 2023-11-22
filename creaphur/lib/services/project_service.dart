import 'package:creaphur/db/helpers/project_helper.dart';
import 'package:creaphur/models/project.dart';
import 'package:creaphur/models/project_list.dart';
import 'package:provider/provider.dart';

class ProjectService {
  static Future<void> addProject(context, Project project) async {
    await ProjectHelper.addProject(project);
    Provider.of<ProjectList>(context, listen: false).add(project);
  }

  static Future<void> updateProject(context, Project project) async {
    await ProjectHelper.updateProject(project);
    Provider.of<ProjectList>(context, listen: false).update(project);
  }

  static Future<void> deleteProject(context, Project project) async {
    await ProjectHelper.deleteProject(project);
    Provider.of<ProjectList>(context, listen: false).remove(project);
  }

  static getProjects(context, String profileId) async {
    List<Project> projects = await ProjectHelper.getProjects(profileId);
    Provider.of<ProjectList>(context, listen: false).addAllProjects(projects);
  }
}
