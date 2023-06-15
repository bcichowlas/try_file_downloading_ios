import 'package:try_file_downloading_ios/main.dart';
import 'package:try_file_downloading_ios/utils.dart';
import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';

/* for macos, may require
	<key>com.apple.security.network.client</key>
	<true/>
	<key>com.apple.security.network.server</key>
	<true/>
 */


//Errors start with "!"

Future<String> doLoad(TestCase testCase) async {
  Uint8List? list = await loadUint8ListFromUrl(testCase.url);
  if (list == null) {
    return "!exception thrown";
  } else {
    return "length: ${list.length}";
  }
}

Future<String> doSave(TestCase testCase) async {
  Uint8List? list = await loadUint8ListFromUrl(testCase.url);
  MimeType mimeType = interpretMimeType(testCase.ext);//not needed for MacOS

  if (list == null) {
    return "!loading problem";
  } else {
    String? path = await FileSaver.instance.saveAs(name: testCase.name, bytes: list, ext: testCase.ext, mimeType: mimeType);
    //saveAs is currently only for iOS and Android
    print("#@38 ${path.toString()}");
    return("(check the download directory for ${testCase.name}.${testCase.ext})");
  }
}

