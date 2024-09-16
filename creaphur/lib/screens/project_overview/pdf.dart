import 'dart:math';

import 'package:creaphur/models/expense_list.dart';
import 'package:creaphur/models/project.dart';
import 'package:creaphur/models/time_entry_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';

import 'package:provider/provider.dart';

class ProjectPDF {
  static const materialHeaders = [
    'Material Name',
    'Quantity Used',
    'Cost',
    'Retailer'
  ];

  static const timeEntriesHeaders = [
    'Action',
    'Cost of Services',
    'Duration',
  ];

  static String generateRandomHexColor() {
    final Random random = Random();

    // Generate random values for R, G, B
    int red = random.nextInt(256);
    int green = random.nextInt(256);
    int blue = random.nextInt(256);

    // Format the color as a hex string
    return '#${red.toRadixString(16).padLeft(2, '0')}${green.toRadixString(16).padLeft(2, '0')}${blue.toRadixString(16).padLeft(2, '0')}';
  }

  static Future<Uint8List> generatePdf(PdfPageFormat format, String title,
      Project project, BuildContext con) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    pw.TextStyle body = const pw.TextStyle(fontSize: 24);
    List expenseDataTable = Provider.of<ExpenseList>(con, listen: false)
        .getDataTableForPieChart(con);
    List expenseMaterialUseDataTable =
        Provider.of<ExpenseList>(con, listen: false)
            .getDataTableForPieChartMarterials(con);
    List materialDataTable =
        Provider.of<ExpenseList>(con, listen: false).getDataTable(con);
    List timeEntryDataTable =
        Provider.of<TimeEntryList>(con, listen: false).getDataTable(con);

    PdfColor returnColor() {
      return project.status == Project.inProgress
          ? const PdfColor.fromInt(0xffad99ff)
          : project.status == Project.finished
              ? PdfColors.green
              : PdfColors.red;
    }

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.Text("${project.name}'s Story",
                  style: const pw.TextStyle(fontSize: 64)),
              pw.Text(project.description ?? '', style: body),
              pw.Divider(),
              pw.Container(height: 50),
              pw.Container(
                width: 500,
                height: 50,
                decoration: pw.BoxDecoration(
                  borderRadius:
                      const pw.BorderRadius.all(pw.Radius.elliptical(40, 20)),
                  color: returnColor(),
                ),
                child: pw.Center(child: pw.Text(project.status, style: body)),
              ),
              pw.Container(height: 250),
              pw.Text(
                  'Total Cost of Project: ${project.getTotalCostOfProject(con)}',
                  style: body),
              pw.Text('Total Hours Worked: ${project.getTotalHours(con)}',
                  style: body),
              pw.Text(
                  'Total Cost of Materials: ${project.getCostOfMaterials(con)}',
                  style: body),
              pw.Text('Total Cost of Time: ${project.getTotalCost(con)}',
                  style: body),
              pw.Text(
                  'Projected Start Date: ${DateFormat.yMMMd().format(project.startDate)}',
                  style: body),
              pw.Text(
                  'Projected End Date: ${DateFormat.yMMMd().format(project.endDate)}',
                  style: body),
            ],
          );
        },
      ),
    );

    pdf.addPage(pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Chart(
            title: pw.Text(
              'Material Use Breakdown',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 34),
            ),
            grid: pw.PieGrid(),
            datasets:
                List<pw.Dataset>.generate(expenseDataTable.length, (index) {
              final data = expenseMaterialUseDataTable[index];
              final color = PdfColor.fromHex(generateRandomHexColor());
              final value = (data[1]);
              final sumCost = Provider.of<ExpenseList>(con, listen: false)
                  .getTotalQuantityUse(con);
              final pct = (value / sumCost * 100).round();
              return pw.PieDataSet(
                legend: '${data[0]}\n$pct%',
                value: value,
                color: color,
                legendStyle: const pw.TextStyle(fontSize: 10),
              );
            }),
          );
        }));

    pdf.addPage(pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Chart(
            title: pw.Text('Expense Breakdown',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 34)),
            grid: pw.PieGrid(),
            datasets:
                List<pw.Dataset>.generate(expenseDataTable.length, (index) {
              final data = expenseDataTable[index];
              final color = PdfColor.fromHex(generateRandomHexColor());
              final value = (double.parse(data[1]));
              final sumCost = Provider.of<ExpenseList>(con, listen: false)
                  .getTotalCost(con);
              final pct = (value / sumCost * 100).round();
              return pw.PieDataSet(
                legend: '${data[0]}\n$pct%',
                value: value,
                color: color,
                legendStyle: const pw.TextStyle(fontSize: 10),
              );
            }),
          );
        }));

    // Data table
    pdf.addPage(pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(children: [
            pw.Text("List of Expenses",
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 34)),
            pw.TableHelper.fromTextArray(
              border: null,
              headers: materialHeaders,
              data: List<List<dynamic>>.generate(
                materialDataTable.length,
                (index) => <dynamic>[
                  materialDataTable[index][0],
                  materialDataTable[index][1],
                  materialDataTable[index][2],
                  materialDataTable[index][3],
                ],
              ),
              headerStyle: pw.TextStyle(
                color: PdfColors.white,
                fontWeight: pw.FontWeight.bold,
              ),
              headerDecoration: const pw.BoxDecoration(
                color: PdfColor.fromInt(0xffad99ff),
              ),
              rowDecoration: const pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(
                    color: PdfColor.fromInt(0xffad99ff),
                    width: .5,
                  ),
                ),
              ),
              cellAlignment: pw.Alignment.centerRight,
              cellAlignments: {0: pw.Alignment.centerLeft},
            )
          ]);
        }));

    // Data table
    pdf.addPage(pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(children: [
            pw.Text("List of Time Entries",
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 34)),
            pw.TableHelper.fromTextArray(
              border: null,
              headers: timeEntriesHeaders,
              data: List<List<dynamic>>.generate(
                timeEntryDataTable.length,
                (index) => <dynamic>[
                  timeEntryDataTable[index][0],
                  timeEntryDataTable[index][1],
                  timeEntryDataTable[index][2],
                ],
              ),
              headerStyle: pw.TextStyle(
                color: PdfColors.white,
                fontWeight: pw.FontWeight.bold,
              ),
              headerDecoration: const pw.BoxDecoration(
                color: PdfColor.fromInt(0xffad99ff),
              ),
              rowDecoration: const pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(
                    color: PdfColor.fromInt(0xffad99ff),
                    width: .5,
                  ),
                ),
              ),
              cellAlignment: pw.Alignment.centerRight,
              cellAlignments: {0: pw.Alignment.centerLeft},
            )
          ]);
        }));

    return pdf.save();
  }
}
