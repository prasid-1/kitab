import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

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
