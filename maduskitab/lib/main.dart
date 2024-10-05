import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

//test
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'MadusKitab',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 141, 18)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = MenuPage();
      case 1:
        page = BasketPage();
      case 2:
        page = FoodCard();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: false,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.shopping_basket),
                  label: Text('Basket'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.book),
                  label: Text("Menu"),
                )
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),
          ),
        ],
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Store Name',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Card(
          child: ListTile(
            title: Text(
              "Add a store Website like page that describes the store here.\nCan contain advertisements and offers available in store.",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class FoodCard extends StatelessWidget {
  const FoodCard({super.key});
  @override
  Widget build(BuildContext context) {
    var placeOrder = 0;
    var menuItems = [
      "Fried Egg",
      "MoMo",
      "Keema Noodels",
      "Chowmein",
    ];
    var itemsRating = [
      4.5,
      3.2,
      3.7,
      4.7,
    ];
    var itemPrice = [
      50,
      120,
      150,
      100,
    ];
    // double rating = 4.5;
    // double starCalculate = (itemsRating[menuItems.indexOf(items)] * 10) / 10;
    return ListView(
      children: [
        for (var items in menuItems)
          Card(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 192, 192, 192)
                        .withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundImage: AssetImage("assets/fried_egg.jpg"),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    items,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 1;
                          i < (itemsRating[menuItems.indexOf(items)] * 10) / 10;
                          i++)
                        const Icon(Icons.star, color: Colors.yellow),
                      if ((itemsRating[menuItems.indexOf(items)] * 10) % 10 !=
                          0)
                        const Icon(Icons.star_half, color: Colors.yellow),
                      const SizedBox(width: 5),
                      Text('${itemsRating[menuItems.indexOf(items)]}'),
                      const SizedBox(width: 5),
                      const Text('(users)'),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Rs.' '${itemPrice[menuItems.indexOf(items)]}'),
                      const SizedBox(width: 30),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              placeOrder;
                            },
                            child: const Icon(Icons.shopping_basket),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              placeOrder;
                            },
                            child: Text('Order'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: pair.asPascalCase,
        ),
      ),
    );
  }
}

class BasketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('Basket is empty'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child:
              Text('You have' '${appState.favorites.length} items in Basket:'),
        ),
        for (var pair in appState.favorites)
          Card(
            child: ListTile(
              leading: Icon(Icons.shopping_basket),
              title: Text(pair.asLowerCase),
            ),
          ),
      ],
    );
  }
}
