import 'package:creaphur/models/project.dart';
import 'package:creaphur/widgets/project_summary_card.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent projectSummaryCard = WidgetbookComponent(
  name: 'ProjectSummaryCard',
  useCases: [
    WidgetbookUseCase(
      name: 'For Project with no image and short description',
      builder: (context) => ProjectSummaryCard(
          project: Project(
              id: '1',
              name: 'Test Project',
              profileId: '123',
              estCost: 1000.00,
              startDate: DateTime.now(),
              endDate: DateTime.now().add(const Duration(days: 2)),
              image: '',
              description: "Test description here.",
              status: Project.getStatuses().first),
          onTap: () {
            // ignore: avoid_print
            print("Project clicked");
          }),
    ),
    WidgetbookUseCase(
      name: 'For Project with no image and long description',
      builder: (context) => ProjectSummaryCard(
          project: Project(
              id: '1',
              name: 'Test Project',
              profileId: '123',
              estCost: 1000.00,
              startDate: DateTime.now(),
              endDate: DateTime.now().add(const Duration(days: 2)),
              image: '',
              status: Project.getStatuses().first,
              description:
                  "Test description here. Hey this is very long, blah blah blah blah blah blah do dee da la la la la la doop de doo"),
          onTap: () {
            // ignore: avoid_print
            print("Project clicked");
          }),
    ),
    WidgetbookUseCase(
      name: 'For Project with no image and long description',
      builder: (context) => ProjectSummaryCard(
          project: Project(
              id: '1',
              name: 'Test Project',
              profileId: '123',
              estCost: 1000.00,
              startDate: DateTime.now(),
              endDate: DateTime.now().subtract(const Duration(days: 2)),
              image: '',
              status: Project.getStatuses().first,
              description:
                  "Test description here. Hey this is very long, blah blah blah blah blah blah do dee da la la la la la doop de doo"),
          onTap: () {
            // ignore: avoid_print
            print("Project clicked");
          }),
    ),
  ],
);
