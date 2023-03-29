import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

class PdfView extends StatefulWidget {
  const PdfView({Key? key}) : super(key: key);

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  static const int initialPage = 1;
  late PdfControllerPinch pdfController;

  @override
  void initState() {
    pdfController = PdfControllerPinch(
      // For assets in project
      // document: PdfDocument.openAsset('assets/hello.pdf'),
      // For files in device storage
      // document: PdfDocument.openFile('filePath'),
      // For assets on internet
      document: PdfDocument.openData(
        InternetFile.get(
          'https://api.codetabs.com/v1/proxy/?quest=http://www.africau.edu/images/default/sample.pdf',
        ),
      ),
      initialPage: initialPage,
    );
    super.initState();
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: const Text('Pdfx Flutter'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.navigate_before),
              onPressed: () {
                pdfController.previousPage(
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 100),
                );
              },
            ),
            PdfPageNumber(
              controller: pdfController,
              builder: (_, loadingState, page, pagesCount) => Container(
                alignment: Alignment.center,
                child: Text(
                  '$page/${pagesCount ?? 0}',
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.navigate_next),
              onPressed: () {
                pdfController.nextPage(
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 100),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                pdfController.loadDocument(
                  PdfDocument.openAsset('assets/flutter_tutorial.pdf'),
                );
              },
            )
          ],
        ),
        body: PdfViewPinch(
          builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
            options: const DefaultBuilderOptions(),
            documentLoaderBuilder: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            pageLoaderBuilder: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorBuilder: (_, error) => Center(
              child: Text(error.toString()),
            ),
          ),
          controller: pdfController,
          scrollDirection: Axis.vertical,
        ),
      );
}
