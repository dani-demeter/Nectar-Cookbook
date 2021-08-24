import 'package:cookbook/Pages/FindRecipePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Pages/HomePage.dart';
import 'Pages/AddRecipePage.dart';
import 'Pages/FindRecipePage.dart';
import 'Pages/RecipePage.dart';

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
  String _page = "recipe";
  var name2page = {
    'home': new HomePage(),
    'addRecipe': new AddRecipePage(),
    'findRecipe': new FindRecipePage(),
    'recipe': new RecipePage(
        () => print("hi"),
        "Kasespatzle",
        4,
        true,
        "Easy",
        30,
        "Entree",
        "Austria",
        <String>["Heavy", "Mate", "Konyi"],
        <String>[
          "20 tons of cheese",
          "12 pieces of spatzle",
          "one liter of ketchup"
        ],
        "Put the cheese all together. Cook the cheese. Bake the cheese. Eat the cheese. Repeat."),
  };
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
