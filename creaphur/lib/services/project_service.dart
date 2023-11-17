import 'package:creaphur/db/helpers/project_helper.dart';
import 'package:creaphur/models/project.dart';
import 'package:creaphur/models/project_list.dart';
import 'package:provider/provider.dart';

class ProjectService {
  static Future<void> addProject(context, Project project) async {
    await ProjectHelper.addProject(project);
    Provider.of<ProjectList>(context, listen: false).add(project);
  }

  static getProjects(context, String profileId) async {
    List<Project> projects = await ProjectHelper.getProjects(profileId) ?? [];
    Provider.of<ProjectList>(context, listen: false).addAllProjects(projects);
  }
}
