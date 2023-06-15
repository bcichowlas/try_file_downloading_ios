import 'package:flutter/material.dart';
import 'package:try_file_downloading_ios/actions.dart';
import 'package:try_file_downloading_ios/utils.dart';

void main() {
  runApp(const MainApp());
}

//The idea is to do something simple with each platform, but in
// separate apps to keep it simple and so that they don't interactt
// I'll try to put the device dependent things in a separate file,
// so that this can be reused.

//We'll have a list of possible URL's to test.

class TestCase{
  String url;
  String name;
  String ext;

  TestCase(this.url, this.name, this.ext);

}

List<TestCase> testURLs = [
  TestCase("http://hbi-brucevcichowlas.pythonanywhere.com/hbi/status", "status", "txt"),
  TestCase("https://www.cichowlas.org/files/Images/JPEG/Session20_Item1_image4.jpg", "Session20_Item1_image4", "jpg"),
  TestCase("http://brucevcichowlas.pythonanywhere.com/files/mf.txt", "mf", "txt"),
  TestCase("http://hbi-brucevcichowlas.pythonanywhere.com/files/Images/JPEG/Session22_Item1_image10.jpg", "Session22_Item1_image10", "jpg"),
];

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String message0 = "";
  void changeMessage0(String val){
    setState(() {
      message0 = val;
    });
  }

  String message1 = "";
  void changeMessage1(String val){
    setState(() {
      message1 = val;
    });
  }

  String loadResult = "";
  void changeLoadResult(String val){
    setState(() {
      loadResult = val;
    });
  }

  String saveResult = "";
  void changeSaveResult(String val){
    setState(() {
      saveResult = val;
    });
  }

  int currentCase = 0;
  _nextTestCase(){
    setState(() {
      currentCase += 1;
      if (currentCase >= testURLs.length){
        currentCase = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child:Column(
            children: [
              Expanded(
                child: Text(''),
              ),
              Row(
                children: [
                  ElevatedButton(
                    child: Text(
                        'URL'
                    ),
                    onPressed: (){
                      _nextTestCase();
                    },
                  ),
                  Expanded(child: Text(testURLs[currentCase].url)),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    child: Text(
                        'LOAD'
                    ),
                    onPressed: () async {
                      String result = await doLoad(testURLs[currentCase]);
                      if (!result.startsWith("!")){
                        changeLoadResult("${dateTimeString()} okay: $result");
                      } else {
                        changeLoadResult("${dateTimeString()} error: $result");
                      }
                    },
                  ),
                  Expanded(child: Text(loadResult)),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    child: Text(
                        'SAVE'
                    ),
                    onPressed: () async{
                      String result = await doSave(testURLs[currentCase]);
                      if (!result.startsWith("!")){
                        changeSaveResult("${dateTimeString()} okay: $result");
                      } else {
                        changeSaveResult("${dateTimeString()} error: $result");
                      }
                    },
                  ),
                  Expanded(child: Text(saveResult)),
                ],
              ),
              Expanded(
                child: Text(''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
