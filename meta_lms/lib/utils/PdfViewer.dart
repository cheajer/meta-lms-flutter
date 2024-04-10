import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';

import 'package:meta_lms/ui/widgets/GlobalAppBar.dart';


class PDFViewer extends StatelessWidget {
  final File file;

  const PDFViewer({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(),
      body: PDFView(
        filePath: file.path,
      ),
    );
  }
}
