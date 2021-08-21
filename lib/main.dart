import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var appConfig = new Map();

void main() {
  runApp(MyApp());
}

const offwhite = Color(0xFFEFF3F5);
const gray = Color(0xFF515151);

var titleStyle =
    GoogleFonts.alata(textStyle: TextStyle(color: gray, fontSize: 50));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cookbook',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SafeArea(
          child: Scaffold(
            body: AppContainer(),
            backgroundColor: offwhite,
          ),
        ));
  }
}

class AppContainer extends StatefulWidget {
  const AppContainer({Key key}) : super(key: key);
  @override
  _AppContainerState createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  String _page = "home";
  var name2page = {'home': new HomePage()};
  @override
  Widget build(BuildContext context) {
    appConfig['width'] = MediaQuery.of(context).size.width;
    appConfig['height'] = MediaQuery.of(context).size.height;
    appConfig['safeAreaHorizontal'] = MediaQuery.of(context).padding.left +
        MediaQuery.of(context).padding.right;
    appConfig['safeAreaVertical'] = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;
    appConfig['safeWidth'] =
        appConfig['width'] - appConfig['safeAreaHorizontal'];
    appConfig['safeHeight'] =
        appConfig['height'] - appConfig['safeAreaVertical'];
    appConfig['blockSize'] = appConfig['safeWidth'] / 100;
    appConfig['blockSizeVertical'] = appConfig['safeHeight'] / 100;
    return name2page[_page];
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dropShadow = BoxShadow(
        color: const Color(0x22000000),
        blurRadius: appConfig['blockSize'],
        spreadRadius: appConfig['blockSize'] / 4);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Welcome!",
              style:
                  titleStyle.copyWith(fontSize: appConfig['blockSize'] * 10)),
          SizedBox(height: appConfig['blockSizeVertical'] * 5),
          InkWell(
              onTap: () => print("Container pressed"),
              borderRadius:
                  BorderRadius.all(Radius.circular(appConfig['blockSize'] * 3)),
              child: Container(
                height: appConfig['blockSizeVertical'] * 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(appConfig['blockSize'] * 3)),
                    color: const Color(0xFF33A7FF),
                    boxShadow: [dropShadow]),
              )),
          SizedBox(height: appConfig['blockSizeVertical'] * 5),
          InkWell(
              onTap: () => print("Container pressed"),
              borderRadius:
                  BorderRadius.all(Radius.circular(appConfig['blockSize'] * 3)),
              child: Container(
                height: appConfig['blockSizeVertical'] * 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(appConfig['blockSize'] * 3)),
                    color: const Color(0xFF33A7FF),
                    boxShadow: [dropShadow]),
              )),
          SizedBox(height: appConfig['blockSizeVertical'] * 5),
          InkWell(
              onTap: () => print("Container pressed"),
              borderRadius:
                  BorderRadius.all(Radius.circular(appConfig['blockSize'] * 3)),
              child: Container(
                height: appConfig['blockSizeVertical'] * 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(appConfig['blockSize'] * 3)),
                    color: const Color(0xFF33A7FF),
                    boxShadow: [dropShadow]),
              )),
        ]));
  }
}
