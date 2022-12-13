//version 1.0.0

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';

class PrenterData {
  static Future<void> generate() async {
    final pdf = Document();
    // final ByteData bytes = await rootBundle.load('assets/icon.png');
    // final Uint8List byteList = bytes.buffer.asUint8List();
    // final ByteData bytesFace = await rootBundle.load('assets/facebook.png');
    // final Uint8List byteListFace = bytesFace.buffer.asUint8List();

    pdf.addPage(
      MultiPage(
        textDirection: TextDirection.rtl,
        theme: ThemeData.withFont(
          base: Font.ttf(await rootBundle.load("fonts/Cairo-Regular.ttf")),
          bold: Font.ttf(await rootBundle.load("fonts/Cairo-Regular.ttf")),
          italic: Font.ttf(await rootBundle.load("fonts/Cairo-Regular.ttf")),
          boldItalic:
              Font.ttf(await rootBundle.load("fonts/Cairo-Regular.ttf")),
        ),
        build: (context) => <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            // pw.Container(
            //     height: 100,
            //     width: 100,
            //     child: pw.Image(
            //         pw.MemoryImage(
            //           byteList,
            //         ),
            //         fit: pw.BoxFit.fitHeight)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Text('مواعيد تمديدات الحبس الإحتياطي',
                  style: pw.TextStyle(
                      color: PdfColors.lightBlueAccent700,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 12),
            pw.Container(
              height: 100,
              width: 100,
              child: pw.BarcodeWidget(
                barcode: pw.Barcode.qrCode(),
                data: 'name Reports',
              ),
            ),
          ]),
          pw.Center(
              child: pw.Container(
            height: 200,
            width: 200,
            decoration: const pw.BoxDecoration(
              shape: pw.BoxShape.circle,
              color: PdfColors.deepOrange100,
            ),
            child: pw.Center(
                child: pw.Text(
              ' فاتورة الصادرات',
              style: pw.TextStyle(
                  color: PdfColors.deepOrange,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 27,
                  letterSpacing: -1),
            )),
          )),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          buildCustomHeader(),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          buildCustomHeadline(),
          pw.Row(
            children: [
              buildColumn(
                key: "رقم الفاتورة",
                value: '22281',
              ),
              pw.SizedBox(
                width: 20,
              ),
              buildColumn(
                key: "تاريخ الفاتورة",
                value: '2022-11-30',
              ),
            ],
          ),
          ...buildBulletPoints(),
        ],
      ),
    );
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  static pw.Widget buildColumn({
    required String key,
    required String value,
  }) {
    return pw.Expanded(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          pw.Text(
            key,
            style: pw.TextStyle(
                color: PdfColors.grey,
                fontSize: 25,
                fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
                color: PdfColors.black,
                fontSize: 25,
                fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(
            height: 5,
          ),
          pw.Container(color: PdfColors.grey, height: 2, width: 350)
        ],
      ),
    );
  }

  static Widget buildCustomHeader() => Container(
        padding: const EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 2, color: PdfColors.blue)),
        ),
        child: Row(
          children: [
            PdfLogo(),
            SizedBox(width: 0.5 * PdfPageFormat.cm),
            Text(
              '',
              style: const TextStyle(fontSize: 20, color: PdfColors.blue),
            ),
          ],
        ),
      );

  static Widget buildCustomHeadline() => Header(
        child: Text(
          'تفاصيل التقرير',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: PdfColors.white,
          ),
        ),
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(color: PdfColors.blue),
      );

  static List<Widget> buildBulletPoints() => [
        costumeRow(
          libale: 'رقم الهاتف:',
          value: '+967773228315',
        ),
        costumeRow(
          libale: 'نوع الصنف:',
          value: 'سامسونج',
        ),
        costumeRow(
          libale: 'الوحدة:',
          value: '2000 ريال',
        ),
        costumeRow(
          libale: 'الكمية:',
          value: '2',
        ),
      ];

  static costumeRow({required String libale, required String value}) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(child: Bullet()),
      Text(value, style: const TextStyle(fontSize: 20)),
      Text('$libale: ', style: const TextStyle(fontSize: 19)),
    ]);
  }
}
