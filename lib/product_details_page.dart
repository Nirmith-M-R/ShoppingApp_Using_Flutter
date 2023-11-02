import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/cart_provider.dart';
import 'package:shop_app/global_variables.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;
  int sizeDetect;

  ProductDetailsPage(
      {super.key, required this.product, required this.sizeDetect});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.product['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(widget.product['imageUrl'] as String),
          ),
          const Spacer(
            flex: 2,
          ),
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(245, 247, 249, 1),
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            child: Column(
              children: [
                const Spacer(),
                Text(
                  '₹${widget.product['price']}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Size',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.product["sizes"] as List<int>).length,
                    itemBuilder: (context, index) {
                      int size = (widget.product['sizes'] as List<int>)[index];

                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: GestureDetector(
                          onTap: () {
                            widget.sizeDetect = size;
                            setState(() {});
                          },
                          child: Chip(
                            label: Text(size.toString()),
                            backgroundColor: widget.sizeDetect == size
                                ? Colors.yellow
                                : Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    if (widget.sizeDetect != 0) {
                      print(widget.product['id']);
                      Provider.of<CartProvider>(context, listen: false)
                          .addProduct({
                        'title': widget.product['title'].toString(),
                        'id': widget.product['id'].toString(),
                        'price': int.parse(widget.product['price'].toString()),
                        'imageUrl': widget.product['imageUrl'].toString(),
                        'company': widget.product['company'].toString(),
                        'sizes': widget.sizeDetect.toString(),
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text('Product added successfully.')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text('Please select a size.')));
                    }

                    print(
                        Provider.of<CartProvider>(context, listen: false).cart);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_cart_sharp,
                        color: Colors.black,
                      ),
                      Text(
                        'Check Out',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
