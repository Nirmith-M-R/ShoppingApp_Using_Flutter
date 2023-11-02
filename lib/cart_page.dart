import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/cart_provider.dart';
import 'package:shop_app/global_variables.dart';
import 'package:shop_app/product_details_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Cart',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ProductDetailsPage(
                    product: {
                      'title': cart[index]['title'].toString(),
                      'id': cart[index]['id'].toString(),
                      'price': int.parse(cart[index]['price'].toString()),
                      'imageUrl': cart[index]['imageUrl'].toString(),
                      'company': cart[index]['company'].toString(),
                      'sizes': products[int.parse(cart[index]['id'].toString())]
                          ['sizes'] as List,
                    },
                    sizeDetect: int.parse(cart[index]['sizes'].toString()),
                  );
                }));
              },
              leading: CircleAvatar(
                backgroundImage: AssetImage(cart[index]['imageUrl'].toString()),
              ),
              title: Text(
                cart[index]['title'].toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              subtitle: Text('Size: ${cart[index]['sizes'].toString()}'),
              trailing: IconButton(
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false)
                      .removeProduct(index);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            );
          },
        ));
  }
}
