import 'package:creaphur/models/project.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';

class ProjectPDF {
  //List materialCostTable() {}

  // pw.Widget _contentTable(pw.Context context) {
  //   const tableHeaders = [
  //     'SKU#',
  //     'Item Description',
  //     'Price',
  //     'Quantity',
  //     'Total'
  //   ];

  //   return pw.TableHelper.fromTextArray(
  //     border: null,
  //     cellAlignment: pw.Alignment.centerLeft,
  //     headerDecoration: pw.BoxDecoration(
  //       borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
  //       color: baseColor,
  //     ),
  //     headerHeight: 25,
  //     cellHeight: 40,
  //     cellAlignments: {
  //       0: pw.Alignment.centerLeft,
  //       1: pw.Alignment.centerLeft,
  //       2: pw.Alignment.centerRight,
  //       3: pw.Alignment.center,
  //       4: pw.Alignment.centerRight,
  //     },
  //     headerStyle: pw.TextStyle(
  //       color: _baseTextColor,
  //       fontSize: 10,
  //       fontWeight: pw.FontWeight.bold,
  //     ),
  //     cellStyle: const pw.TextStyle(
  //       color: _darkColor,
  //       fontSize: 10,
  //     ),
  //     rowDecoration: pw.BoxDecoration(
  //       border: pw.Border(
  //         bottom: pw.BorderSide(
  //           color: accentColor,
  //           width: .5,
  //         ),
  //       ),
  //     ),
  //     headers: List<String>.generate(
  //       tableHeaders.length,
  //       (col) => tableHeaders[col],
  //     ),
  //     data: List<List<String>>.generate(
  //       products.length,
  //       (row) => List<String>.generate(
  //         tableHeaders.length,
  //         (col) => products[row].getIndex(col),
  //       ),
  //     ),
  //   );
  // }

  static Future<Uint8List> generatePdf(PdfPageFormat format, String title,
      Project project, BuildContext con) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.Text(project.name, style: const pw.TextStyle(fontSize: 25)),
              pw.Text(
                  'Total Cost of Project: ${project.getTotalCostOfProject(con)}'),
              pw.Text('Total Hours Worked: ${project.getTotalHours(con)}'),
              pw.Text(
                  'Total Cost of Materials: ${project.getCostOfMaterials(con)}'),
              pw.Text('Total Cost of Time: ${project.getTotalCost(con)}'),
            ],
          );
        },
      ),
    );

    // pdf.addPage(pw.Page(
    //     pageFormat: format,
    //     build: (context) {
    //       return pw.Chart(
    //         title: pw.Text(
    //           'Material Use Breakdown',
    //           style: const pw.TextStyle(
    //             color: PdfColors.purple200,
    //             fontSize: 20,
    //           ),
    //         ),
    //         grid: pw.PieGrid(),
    //         datasets: List<pw.Dataset>.generate(dataTable.length, (index) {
    //           final data = dataTable[index];
    //           final color = chartColors[index % chartColors.length];
    //           final value = (data[2] as num).toDouble();
    //           final pct = (value / expense * 100).round();
    //           return pw.PieDataSet(
    //             legend: '${data[0]}\n$pct%',
    //             value: value,
    //             color: color,
    //             legendStyle: const pw.TextStyle(fontSize: 10),
    //           );
    //         }),
    //       );
    //     }));

    // pdf.addPage(pw.Page(
    //     pageFormat: format,
    //     build: (context) {
    //       return pw.Chart(
    //         title: pw.Text(
    //           'Expense Breakdown',
    //           style: const pw.TextStyle(
    //             color: baseColor,
    //             fontSize: 20,
    //           ),
    //         ),
    //         grid: pw.PieGrid(),
    //         datasets: List<pw.Dataset>.generate(dataTable.length, (index) {
    //           final data = dataTable[index];
    //           final color = chartColors[index % chartColors.length];
    //           final value = (data[2] as num).toDouble();
    //           final pct = (value / expense * 100).round();
    //           return pw.PieDataSet(
    //             legend: '${data[0]}\n$pct%',
    //             value: value,
    //             color: color,
    //             legendStyle: const pw.TextStyle(fontSize: 10),
    //           );
    //         }),
    //       );
    //     }));

    return pdf.save();
  }
}
