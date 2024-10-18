import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({super.key});

  @override
  Widget build(BuildContext context) {
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
    var descriptions = [
      "Delicious fried egg with spices.",
      "Steamed dumplings with meat filling.",
      "Noodles cooked with minced meat.",
      "Classic stir-fried noodles with veggies."
    ];

    return ListView(
      children: [
        for (var i = 0; i < menuItems.length; i++)
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
                    menuItems[i],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var j = 1; j < (itemsRating[i] * 10) / 10; j++)
                        const Icon(Icons.star, color: Colors.yellow),
                      if ((itemsRating[i] * 10) % 10 != 0)
                        const Icon(Icons.star_half, color: Colors.yellow),
                      const SizedBox(width: 5),
                      Text('${itemsRating[i]}'),
                      const SizedBox(width: 5),
                      const Text('(users)'),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Rs.' '${itemPrice[i]}'),
                      const SizedBox(width: 30),
                      ElevatedButton(
                        onPressed: () {
                          var appState = context.read<MyAppState>();
                          // Create a BasketItem and add it to the basket
                          appState.addItemToBasket(
                            BasketItem(
                              name: menuItems[i],
                              rating: itemsRating[i],
                              description: descriptions[i],
                              price: itemPrice[i],
                            ),
                          );
                        },
                        child: Text('Order'),
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
