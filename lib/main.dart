import 'dart:convert';

import 'package:cookbook/Pages/FindRecipePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Pages/HomePage.dart';
import 'Pages/AddRecipePage.dart';
import 'Pages/FindRecipePage.dart';
import 'Pages/RecipePage.dart';
import 'Pages/RecipesListPage.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

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

Map<String, Recipe> recipeBook = {};

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
  String _page = "home";
  var name2page;

  _AppContainerState() {
    name2page = {
      'home': HomePage(setPage),
      'addRecipe': AddRecipePage(setPage, () => setPage("home", null, null)),
      'findRecipe': FindRecipePage(setPage, () => setPage("home", null, null)),
      'recipe': RecipePage(
        setPage,
        () {},
        new Recipe(
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
              "one liter of ketchup",
              "a really long ingredient that i don't think will fit in one line, but maybe will?"
            ],
            "Put the cheese all together. Cook the cheese. Bake the cheese. Eat the cheese. Repeat."),
      ),
      'recipesList':
          RecipesListPage(setPage, () => setPage("home", null, null), []),
    };
  }

  @override
  Widget build(BuildContext context) {
    setScreenSizeDependencies(context);
    return name2page[_page];
  }

  void setPage(String newPage, var options, VoidCallback backCallback) {
    switch (newPage) {
      case "addRecipe":
        if (options) {
          name2page['addRecipe'].clearValues();
        }
        break;
      case "findRecipe":
        if (options) {
          name2page['findRecipe'].clearValues();
        }
        break;
      case "recipe":
        assert(options is Recipe);
        assert(backCallback != null);
        name2page['recipe'] = RecipePage(setPage, backCallback, options);
        break;
      case "recipesList":
        name2page['recipesList'] =
            RecipesListPage(setPage, backCallback, options);
        break;
      default:
        break;
    }
    setState(() {
      _page = newPage;
    });
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

class Recipe {
  String title;
  int stars;
  bool favorited;
  String difficulty;
  int time2make;
  String typeOfDish;
  String countryOfOrigin;

  List<String> tags;
  List<String> ingredients;
  String prep;
  Recipe(
      this.title,
      this.stars,
      this.favorited,
      this.difficulty,
      this.time2make,
      this.typeOfDish,
      this.countryOfOrigin,
      this.tags,
      this.ingredients,
      this.prep);

  Map<String, dynamic> toJson() => {
        'title': title,
        'stars': stars,
        'favorited': favorited,
        'difficulty': difficulty,
        'time2make': time2make,
        'typeOfDish': typeOfDish,
        'countryOfOrigin': countryOfOrigin,
        'tags': tags,
        'ingredients': ingredients,
        'prep': prep,
      };
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/recipes.json');
}

Future<File> writeRecipes(Map<String, Recipe> recipes) async {
  final file = await _localFile;

  String toWrite = jsonEncode(recipes);

  print("wrote: " + toWrite);
  return file.writeAsString(toWrite);
}

Future<Map<String, dynamic>> readRecipes() async {
  try {
    final file = await _localFile;

    final contents = await file.readAsString();
    Map<String, dynamic> readObject = jsonDecode(contents);
    return readObject;
  } catch (e) {
    print(e);
    return null;
  }
}
