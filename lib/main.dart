import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'backButton.dart';
import 'parameterDropdown.dart';
import 'listMaker.dart';

var appConfig = new Map();
var dropShadow;

double borderRadius = 0;

void main() {
  runApp(MyApp());
}

const offwhite = Color(0xFFEFF3F5);
const gray = Color(0xFF515151);
const fullwhite = Color(0xFFFFFFFF);
const mint = Color(0xFF24FBCA);
const inputColor = Color(0xFF202F44);

final countryNames = [
  "Unknown",
  "Afghanistan",
  "Albania",
  "Algeria",
  "Andorra",
  "Angola",
  "Anguilla",
  "Antigua Barbuda",
  "Argentina",
  "Armenia",
  "Aruba",
  "Australia",
  "Austria",
  "Azerbaijan",
  "Bahamas",
  "Bahrain",
  "Bangladesh",
  "Barbados",
  "Belarus",
  "Belgium",
  "Belize",
  "Benin",
  "Bermuda",
  "Bhutan",
  "Bolivia",
  "Bosnia Herzegovina",
  "Botswana",
  "Brazil",
  "British Virgin Islands",
  "Brunei",
  "Bulgaria",
  "Burkina Faso",
  "Burundi",
  "Cambodia",
  "Cameroon",
  "Cape Verde",
  "Cayman Islands",
  "Chad",
  "Chile",
  "China",
  "Colombia",
  "Congo",
  "Cook Islands",
  "Costa Rica",
  "Cote D Ivoire",
  "Croatia",
  "Cruise Ship",
  "Cuba",
  "Cyprus",
  "Czech Republic",
  "Denmark",
  "Djibouti",
  "Dominica",
  "Dominican Republic",
  "Ecuador",
  "Egypt",
  "El Salvador",
  "Equatorial Guinea",
  "Estonia",
  "Ethiopia",
  "Falkland Islands",
  "Faroe Islands",
  "Fiji",
  "Finland",
  "France",
  "French Polynesia",
  "French West Indies",
  "Gabon",
  "Gambia",
  "Georgia",
  "Germany",
  "Ghana",
  "Gibraltar",
  "Greece",
  "Greenland",
  "Grenada",
  "Guam",
  "Guatemala",
  "Guernsey",
  "Guinea",
  "Guinea Bissau",
  "Guyana",
  "Haiti",
  "Honduras",
  "Hong Kong",
  "Hungary",
  "Iceland",
  "India",
  "Indonesia",
  "Iran",
  "Iraq",
  "Ireland",
  "Isle of Man",
  "Israel",
  "Italy",
  "Jamaica",
  "Japan",
  "Jersey",
  "Jordan",
  "Kazakhstan",
  "Kenya",
  "Kuwait",
  "Kyrgyz Republic",
  "Laos",
  "Latvia",
  "Lebanon",
  "Lesotho",
  "Liberia",
  "Libya",
  "Liechtenstein",
  "Lithuania",
  "Luxembourg",
  "Macau",
  "Macedonia",
  "Madagascar",
  "Malawi",
  "Malaysia",
  "Maldives",
  "Mali",
  "Malta",
  "Mauritania",
  "Mauritius",
  "Mexico",
  "Moldova",
  "Monaco",
  "Mongolia",
  "Montenegro",
  "Montserrat",
  "Morocco",
  "Mozambique",
  "Namibia",
  "Nepal",
  "Netherlands",
  "Netherlands Antilles",
  "New Caledonia",
  "New Zealand",
  "Nicaragua",
  "Niger",
  "Nigeria",
  "Norway",
  "Oman",
  "Pakistan",
  "Palestine",
  "Panama",
  "Papua New Guinea",
  "Paraguay",
  "Peru",
  "Philippines",
  "Poland",
  "Portugal",
  "Puerto Rico",
  "Qatar",
  "Reunion",
  "Romania",
  "Russia",
  "Rwanda",
  "Saint Pierre Miquelon",
  "Samoa",
  "San Marino",
  "Satellite",
  "Saudi Arabia",
  "Senegal",
  "Serbia",
  "Seychelles",
  "Sierra Leone",
  "Singapore",
  "Slovakia",
  "Slovenia",
  "South Africa",
  "South Korea",
  "Spain",
  "Sri Lanka",
  "St Kitts Nevis",
  "St Lucia",
  "St Vincent",
  "St. Lucia",
  "Sudan",
  "Suriname",
  "Swaziland",
  "Sweden",
  "Switzerland",
  "Syria",
  "Taiwan",
  "Tajikistan",
  "Tanzania",
  "Thailand",
  "Timor L'Este",
  "Togo",
  "Tonga",
  "Trinidad Tobago",
  "Tunisia",
  "Turkey",
  "Turkmenistan",
  "Turks Caicos",
  "Uganda",
  "Ukraine",
  "United Arab Emirates",
  "United Kingdom",
  "Uruguay",
  "Uzbekistan",
  "Venezuela",
  "Vietnam",
  "Virgin Islands (US)",
  "Yemen",
  "Zambia",
  "Zimbabwe"
];

var titleStyle =
    GoogleFonts.alata(textStyle: TextStyle(color: gray, fontSize: 30));
var parameterStyle =
    GoogleFonts.alata(textStyle: TextStyle(color: gray, fontSize: 15));
var parameterValueStyle =
    GoogleFonts.alata(textStyle: TextStyle(color: inputColor, fontSize: 13));
var listNameStyle =
    GoogleFonts.alata(textStyle: TextStyle(color: gray, fontSize: 12));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cookbook',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          canvasColor: Colors.white,
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
  String _page = "addRecipe";
  var name2page = {'home': new HomePage(), 'addRecipe': new AddRecipePage()};
  @override
  Widget build(BuildContext context) {
    setScreenSizeDependencies(context);
    return name2page[_page];
  }
}

void setScreenSizeDependencies(BuildContext context) {
  appConfig['width'] = MediaQuery.of(context).size.width;
  appConfig['height'] = MediaQuery.of(context).size.height;
  appConfig['safeAreaHorizontal'] = MediaQuery.of(context).padding.left +
      MediaQuery.of(context).padding.right;
  appConfig['safeAreaVertical'] = MediaQuery.of(context).padding.top +
      MediaQuery.of(context).padding.bottom;
  appConfig['safeWidth'] = appConfig['width'] - appConfig['safeAreaHorizontal'];
  appConfig['safeHeight'] = appConfig['height'] - appConfig['safeAreaVertical'];
  appConfig['blockSize'] = appConfig['safeWidth'] / 100;
  appConfig['blockSizeVertical'] = appConfig['safeHeight'] / 100;

  dropShadow = BoxShadow(
      color: const Color(0x22000000),
      blurRadius: appConfig['blockSize'],
      spreadRadius: appConfig['blockSize'] / 4);

  borderRadius = appConfig['blockSize'] * 3;
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Welcome!",
              style:
                  titleStyle.copyWith(fontSize: appConfig['blockSize'] * 10)),
          SizedBox(height: appConfig['blockSizeVertical'] * 5),
          InkWell(
              onTap: () => print("Container pressed"),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              child: Container(
                height: appConfig['blockSizeVertical'] * 20,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    color: const Color(0xFF33A7FF),
                    boxShadow: [dropShadow]),
              )),
          SizedBox(height: appConfig['blockSizeVertical'] * 5),
          InkWell(
              onTap: () => print("Container pressed"),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              child: Container(
                height: appConfig['blockSizeVertical'] * 20,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    color: const Color(0xFF33A7FF),
                    boxShadow: [dropShadow]),
              )),
          SizedBox(height: appConfig['blockSizeVertical'] * 5),
          InkWell(
              onTap: () => print("Container pressed"),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              child: Container(
                height: appConfig['blockSizeVertical'] * 10,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    color: const Color(0xFF33A7FF),
                    boxShadow: [dropShadow]),
              )),
        ]));
  }
}

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key key}) : super(key: key);

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  var _tags = <String>["Heavy", "Mate", "Konyi"];

  @override
  Widget build(BuildContext context) {
    if (_tags[_tags.length - 1] != "") _tags.add("");
    print("rendering");
    print(_tags);
    return SingleChildScrollView(
      child: Column(
        children: [
          //title
          Row(mainAxisSize: MainAxisSize.max, children: [
            new IconBackButton(() => print('back button pressed')),
            Expanded(
                child: Text(
              "New Recipe",
              textAlign: TextAlign.center,
              style: titleStyle,
            )),
            new IconBackButton(() => print('save button pressed'))
          ]),
          SizedBox(
            height: appConfig['blockSizeVertical'] * 5,
          ),
          //recipe name
          Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
              child: TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mint, width: 1.0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius),
                    ),
                  ),
                  filled: true,
                  fillColor: fullwhite,
                  labelText: "Recipe Name",
                  labelStyle: TextStyle(color: gray),
                ),
                style:
                    GoogleFonts.alata(textStyle: TextStyle(color: inputColor)),
              )),
          SizedBox(
            height: appConfig['blockSizeVertical'] * 5,
          ),
          //time to make
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Time to Make", style: parameterStyle),
                new ParameterInput(() => print("callback")),
              ],
            ),
          ),
          SizedBox(
            height: appConfig['blockSizeVertical'] * 2,
          ),
          //difficulty
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Difficulty", style: parameterStyle),
                new ParameterDropdown(
                    "Easy",
                    <String>['Easy', 'Medium', 'Hard'],
                    () => print("callback")),
              ],
            ),
          ),
          SizedBox(
            height: appConfig['blockSizeVertical'] * 2,
          ),
          //type of dish
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Type of Dish", style: parameterStyle),
                new ParameterDropdown(
                    "Entree",
                    <String>['Appetizer', 'Entree', 'Dessert', 'Drink'],
                    () => print("callback")),
              ],
            ),
          ),
          SizedBox(
            height: appConfig['blockSizeVertical'] * 2,
          ),
          //country
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Country of Origin", style: parameterStyle),
                new ParameterDropdown(
                    "Unknown", countryNames, () => print("callback")),
              ],
            ),
          ),
          SizedBox(
            height: appConfig['blockSizeVertical'] * 5,
          ),
          //tags
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Tags",
                style: listNameStyle,
              ),
            ),
          ),
        ]
          ..addAll(_tags
              .asMap()
              .entries
              .map((e) => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: appConfig['blockSize'] * 10,
                      vertical: appConfig['blockSizeVertical']),
                  child: ListElement(e.value, e.key, addNewTag, removeTag)))
              .toList())
          ..addAll([
            Container(height: 50, color: mint),
            Container(height: 50, color: fullwhite),
            Container(height: 50, color: mint),
            Container(height: 50, color: fullwhite),
            Container(height: 50, color: mint),
            Container(height: 50, color: fullwhite),
            Container(height: 50, color: mint),
          ]),
      ),
    );
  }

  void addNewTag(String newTag) {
    setState(() {
      _tags[_tags.length - 1] = newTag;
      _tags.add("");
      print(_tags);
    });
  }

  void removeTag(int idx) {
    setState(() {
      print(_tags);
      print("removing at" + idx.toString());
      _tags.removeAt(idx);
      print(_tags);
    });
  }
}
