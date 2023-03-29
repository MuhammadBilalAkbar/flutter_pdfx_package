## 1. Research: Flutter Pdfx Package

- Keywords:
    - pdfx package flutter
    - flutter pdf viewer
- Video Title: Flutter Pdfx Package - Pdf viewer, render & show PDF pages as images in Flutter using
  Pdfx Package

## 2. Research: Competitors

**Flutter Videos/Articles**

- No videos
- https://pub.dev/packages/pdfx
- https://morioh.com/p/d447f57dd796
- https://flutterforyou.com/how-to-load-pdf-from-url-in-flutter/

**Android/Swift/React Videos**

- 36K: https://www.youtube.com/watch?v=KxIJKv2B-wQ
- 17K: https://www.youtube.com/watch?v=DDmKTjORqKs
- 21K: https://www.youtube.com/watch?v=hxxWWmqYevQ
- 4.2K: https://www.youtube.com/watch?v=8N_JF3D7KBg
- 17K: https://www.youtube.com/watch?v=GaNYWnlV3R4
- 1K: https://www.youtube.com/watch?v=u4q3u3K8KY8
- 6.4K: https://www.youtube.com/watch?v=0adHkCBB-74
- 11K: https://www.youtube.com/watch?v=3Md3Fey6DMQ
- https://pspdfkit.com/blog/2019/open-pdf-android/
- https://developer.android.com/reference/android/graphics/pdf/PdfRenderer
- https://apryse.com/blog/android/build-an-android-pdf-viewer-using-java/
- https://developer.apple.com/documentation/pdfkit/pdfview
- https://www.hackingwithswift.com/example-code/libraries/how-to-display-pdfs-using-pdfview
- https://pspdfkit.com/guides/ios/viewer/swift/
- https://swiftpackageindex.com/diniska/swiftui-pdf
- https://medium.com/@ji3g4kami/download-store-and-view-pdf-in-swift-af399373b451
- https://www.npmjs.com/package/react-native-pdf
- https://apryse.com/blog/mobile/how-to-build-a-pdf-viewer-react-native
- https://pspdfkit.com/blog/2021/how-to-build-a-react-native-pdf-viewer/

**Great Features**

- Flutter plugin to render & show PDF pages as images on Web, MacOS, Windows, Android and iOS.
- You can find more features
  at [https://pub.dev/documentation/pdfx/latest/](https://pub.dev/documentation/pdfx/latest/).

**Problems from Videos**

- NA

**Problems from Flutter Stackoverflow**

- https://stackoverflow.com/questions/75645243/flutter-unhandled-exception-platformexceptionpdfrendererexception-io-scer-pdf

## 3. Video Structure

**Main Points / Purpose Of Lesson**

1. The main purpose of this lesson is to show pdf file as images using pdfx package of flutter.
2. There are three methods to load pdf in flutter app using this package:
    - openData (From Internet)       => pdfController.loadDocument(PdfDocument.openData(InternetFile.get('
      url')))
    - openAsset (From App Assets)    => pdfController.loadDocument(PdfDocument.openAsset('assetPath'))
    - openFile (From Device Storage) => pdfController.loadDocument(PdfDocument.openFile('filePath'))
3. We will cover `openData` and `openAsset` cases to view and show pdf files as Images.

**The Structured Main Content**

1. Run `flutter pub add pdfx` to add pdfx package in your project's `pubspec.yaml` file.
2. To show pdf document from internet, run `flutter pub add internet_file` in project also.
3. In `pdf_view.dart`, initialize initial page and pdfController:

```dart

static const int initialPage = 1;
late PdfControllerPinch pdfController;
```

- When page opens for the first time, load pdf document using initState.

```dart
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
```

- Dispose the controller when this pages terminates:

```dart
  @override
void dispose() {
  pdfController.dispose();
  super.dispose();
}
```

- In `AppBar`, using `actions` property:
  <br/>Make two IconButtons to go to next and previous page using `pdfController`
  <br/>Between these IconButton, show `PdfPageNumber` using pdfx package
  widget
  <br/> Make another IconButton in the last to load pdf document using `openAsset`.

```dart 
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
        )
```

When going to next or previous page, you can use animations as well.

- Show pdf content in the body using `PdfViewPinch` widget of pdfx package:

```dart 
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
```

- **Note:**
  <br/> If your use `PdfController` as controller then use `PdfView` in body to view pdf document in
  the body.
  <br/> Properties of `PdfController` & `PdfControllerPinch` are same.
  <br/> Properties of `PdfView` & `PdfViewPinch` are same.
  <br/> See the official documentation for more
  info.[https://github.com/ScerIO/packages.flutter/tree/main/packages/pdfx](https://github.com/ScerIO/packages.flutter/tree/main/packages/pdfx)
  .