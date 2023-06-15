import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:file_saver/file_saver.dart';


MimeType interpretMimeType(String ext){
  if (ext == "jpg"){
    return MimeType.jpeg;
  } else if (ext == "json"){
    return MimeType.json;
  } else if (ext == "txt"){
    return MimeType.text;
  } else if (ext == "png"){
    return MimeType.png;
  } else if (ext == "bmp"){
    return MimeType.bmp;
  } else if (ext == "tiff"){
    return MimeType.ttf; //is that correct for TIFF's?
  } else {
    return MimeType.text; //have a default
  }
}

String dateTimeString(){
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyMMdd–kkmmss').format(now);
  return formattedDate;
}

//FIXME: TODO: Should probably have error checking.
Future<Uint8List?> loadUint8ListFromUrl(String url) async {
  try {
    print("#@6 loadUint8ListFromUrl: $url");
    http.Response response = await http.get(Uri.parse(url));
    print("#@7 loadUint8ListFromUrl response received.");
    return response.bodyBytes; //Uint8List
  } catch (e){
    print("#!22 exception: $e");
    return null;
  }
}


