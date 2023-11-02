import 'package:flutter/material.dart';
import 'package:shop_app/global_variables.dart';
import 'package:shop_app/product_card.dart';
import 'package:shop_app/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const [
    'All',
    'Addidas',
    'Nike',
    'Bata',
    'Puma',
    'VKC'
  ];
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        bottomLeft: Radius.circular(50),
      ),
    );

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                child: Text(
                  'Shoes\nCollection',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ListView.builder(
                itemCount: filters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      top: 0,
                      bottom: 0,
                      right: 8.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        selectedFilter = filter;
                        setState(() {});
                      },
                      child: Chip(
                        label: Text(filter),
                        backgroundColor: selectedFilter != filter
                            ? const Color.fromRGBO(245, 247, 249, 1)
                            : Theme.of(context).colorScheme.primary,
                        side: const BorderSide(
                          color: Color.fromRGBO(245, 247, 249, 1),
                        ),
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ProductDetailsPage(
                            product: products[index],
                            sizeDetect: 0,
                          );
                        },
                      ),
                    );
                  },
                  child: ProductCard(
                    title: products[index]['title'].toString(),
                    price: double.parse(products[index]['price'].toString()),
                    url: products[index]['imageUrl'].toString(),
                    count: index,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
