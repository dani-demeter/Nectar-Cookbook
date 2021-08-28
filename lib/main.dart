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
import 'dart:math';
// import 'package:uuid/uuid.dart';

var appConfig = new Map();
var dropShadow;

double tagSimilarityCutoff = 0.3;

double borderRadius = 0;

Set allTags = Set();

void main() {
  runApp(MyApp());
  // writeRecipes(<String, Recipe>{
  //   "Kenesei Álom": Recipe(
  //       "Kenesei Álom",
  //       5,
  //       true,
  //       "Easy",
  //       30,
  //       "Dessert",
  //       "Hungary",
  //       ["Light", "Unmade"],
  //       ["3 meggy", "Tejföl", "Háztartási keksz", "Vaniliás cukor", "Cukor"],
  //       "A tejfölt összekeverjük a cukorral. A jénait kirakjuk a kekszekkel, rárakunk egy réteg krémet, majd kekszet, megint krémet. Tetejét kekszekkel fedjük. Letakarjuk, hűtőbe tesszük. Másnapra megpuhul a keksz, jól szeletelhető kockákra.\nGyümölcsöt beleszórva még finomabb!",
  //       "",
  //       Uuid().v1())
  // });
  readRecipes().then((value) {
    recipeBook = {};
    value.values.forEach((recipe2add) {
      Recipe recipe = Recipe.fromJson(recipe2add);
      recipeBook[recipe2add['id']] = recipe;
      allTags.addAll(recipe.tags);
    });
  });
}

void updateAllTags() {
  allTags.clear();
  recipeBook.entries.forEach((element) {
    allTags.addAll(element.value.tags);
  });
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
        title: 'Nectar',
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
  AppContainer({Key key}) : super(key: key);

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
        "",
      ),
      'recipesList':
          RecipesListPage(setPage, () => setPage("home", null, null), {}, ''),
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
        if (options['clear']) {
          name2page['addRecipe'].clearValues();
        }
        if (options['setValues'] != false) {
          name2page['addRecipe'].setValues(options['setValues']);
        }
        name2page['addRecipe'].setBackCallback(backCallback);

        break;
      case "findRecipe":
        if (options) {
          name2page['findRecipe'].clearValues();
        }
        break;
      case "recipe":
        assert(backCallback != null);
        name2page['recipe'] = RecipePage(setPage, backCallback, options);
        break;
      case "recipesList":
        name2page['recipesList'] = RecipesListPage(
            setPage, backCallback, options['criteria'], options['title']);
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
  String imagePath;

  String id;
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
      this.prep,
      this.imagePath,
      this.id);

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
        'imagePath': imagePath,
        'id': id
      };

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
        json["title"],
        json["stars"],
        json["favorited"],
        json["difficulty"],
        json["time2make"],
        json["typeOfDish"],
        json["countryOfOrigin"],
        [...json["tags"]].map((tag) => tag as String).toList(),
        [...json["ingredients"]]
            .map((ingredient) => ingredient as String)
            .toList(),
        json["prep"],
        json["imagePath"],
        json["id"]);
  }
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

List<Recipe> findRecipesWithCriteria(Map<String, dynamic> criteria) {
  List<Recipe> results = [];
  List<Recipe> recipes2filter = recipeBook.values.toList();
  if (criteria.isEmpty) {
    return recipes2filter;
  }
  for (var i = 0; i < recipes2filter.length; i++) {
    bool need2addRecipe = true;
    //favorited
    if (criteria.containsKey('favorite') && !recipes2filter[i].favorited) {
      need2addRecipe = false;
    }
    //max time to make
    if (criteria.containsKey('maxTime2Make') &&
        criteria['maxTime2Make'] != 0 &&
        recipes2filter[i].time2make != 0 &&
        criteria['maxTime2Make'] < recipes2filter[i].time2make) {
      need2addRecipe = false;
    }
    //difficulty
    if (criteria.containsKey('difficulty') &&
        criteria['difficulty'] != 'Any' &&
        criteria['difficulty'] != recipes2filter[i].difficulty) {
      need2addRecipe = false;
    }
    //type of dish
    if (criteria.containsKey('typeOfDish') &&
        criteria['typeOfDish'] != 'Any' &&
        criteria['typeOfDish'] != recipes2filter[i].typeOfDish) {
      need2addRecipe = false;
    }
    //country of origin
    if (criteria.containsKey('countryOfOrigin') &&
        criteria['countryOfOrigin'] != 'Any' &&
        recipes2filter[i].countryOfOrigin != 'Unknown' &&
        criteria['countryOfOrigin'] != recipes2filter[i].countryOfOrigin) {
      need2addRecipe = false;
    }
    //tags
    if (criteria.containsKey('tags')) {
      criteria['tags'].forEach((tag) {
        bool containsThisTag = false;
        for (int j = 0; j < recipes2filter[i].tags.length; j++) {
          if (equalsIgnoreCase(recipes2filter[i].tags[j], tag)) {
            containsThisTag = true;
            break;
          }
        }
        if (!containsThisTag) {
          need2addRecipe = false;
        }
      });
    }
    if (criteria.containsKey('keywords')) {
      criteria['keywords'].forEach((keyword) {
        bool ingredientIncludesKeyword = false;
        for (int j = 0; j < recipes2filter[i].ingredients.length; j++) {
          if (containsIgnoreCase(recipes2filter[i].ingredients[j], keyword)) {
            ingredientIncludesKeyword = true;
            break;
          }
        }
        if (!ingredientIncludesKeyword) {
          if (!(containsIgnoreCase(recipes2filter[i].title, keyword) ||
              containsIgnoreCase(recipes2filter[i].prep, keyword))) {
            need2addRecipe = false;
          }
        }
      });
    }
    if (need2addRecipe) {
      results.add(recipes2filter[i]);
    }
  }
  return results;
}

bool containsIgnoreCase(String string1, String string2) {
  return string1.toLowerCase().contains(string2.toLowerCase());
}

bool equalsIgnoreCase(String string1, String string2) {
  return string1.toLowerCase() == string2.toLowerCase();
}

int levenshtein(String a, String b) {
  a = a.toUpperCase();
  b = b.toUpperCase();
  int sa = a.length;
  int sb = b.length;
  int i, j, cost, min1, min2, min3;
  int levenshtein;
  List<List<int>> d = new List.generate(sa + 1, (int i) => new List(sb + 1));
  if (a.length == 0) {
    levenshtein = b.length;
    return (levenshtein);
  }
  if (b.length == 0) {
    levenshtein = a.length;
    return (levenshtein);
  }
  for (i = 0; i <= sa; i++) d[i][0] = i;
  for (j = 0; j <= sb; j++) d[0][j] = j;
  for (i = 1; i <= a.length; i++)
    for (j = 1; j <= b.length; j++) {
      if (a[i - 1] == b[j - 1])
        cost = 0;
      else
        cost = 1;
      min1 = (d[i - 1][j] + 1);
      min2 = (d[i][j - 1] + 1);
      min3 = (d[i - 1][j - 1] + cost);
      d[i][j] = min(min1, min(min2, min3));
    }
  levenshtein = d[a.length][b.length];
  return (levenshtein);
}

double similarity(String a, String b) {
  double _similarity;
  a = a.toUpperCase();
  b = b.toUpperCase();
  _similarity = 1 - levenshtein(a, b) / (max(a.length, b.length));
  return (_similarity);
}

List<String> similarTags(String query, double cutoff) {
  List<String> res = [];
  allTags.forEach((tag) {
    if (similarity(query, tag) >= cutoff) {
      res.add(tag);
    }
  });
  return res;
}
