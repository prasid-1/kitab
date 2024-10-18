import 'package:flutter/material.dart';

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
