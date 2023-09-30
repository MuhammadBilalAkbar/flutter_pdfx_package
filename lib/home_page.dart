import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const int initialPage = 1;
  late PdfControllerPinch pdfController;

  @override
  void initState() {
    super.initState();
    pdfController = PdfControllerPinch(
      // For assets in project
      // document: PdfDocument.openAsset('assets/flutter_tutorial.pdf'),
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
              builder: (_, loadingState, pageNumber, totalPages) => Container(
                alignment: Alignment.center,
                child: Text(
                  '$pageNumber/${totalPages ?? 0}',
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
              onPressed: () => pdfController.loadDocument(
                PdfDocument.openAsset('assets/flutter_tutorial.pdf'),
              ),
            ),
          ],
        ),
        body: PdfViewPinch(
          controller: pdfController,
          scrollDirection: Axis.vertical,
          builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
            options: const DefaultBuilderOptions(),
            documentLoaderBuilder: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            pageLoaderBuilder: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorBuilder: (_, error) => Center(
              child: Text(
                error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
        ),
      );
}
