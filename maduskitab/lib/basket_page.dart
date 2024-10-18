import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class BasketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.basketItems.isEmpty) {
      return Center(
        child: Text('Basket is empty'),
      );
    }

    // Calculate the total price
    int totalPrice = appState.basketItems.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'You have ${appState.basketItems.length} items in your basket:',
                ),
              ),
              for (var item in appState.basketItems)
                Card(
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rating: ${item.rating}'),
                        Text('Description: ${item.description}'),
                        Text('Price: Rs. ${item.price}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            appState.removeItemFromBasket(item);
                          },
                        ),
                        Text('${item.quantity}'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            appState.addItemToBasket(item);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: Rs. $totalPrice',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Order placed! Total: Rs. $totalPrice'),
                    ),
                  );
                },
                child: Text('Place Order'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
