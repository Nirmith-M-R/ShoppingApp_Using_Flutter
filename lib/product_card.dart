import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String? title;
  final String url;
  final double? price;
  final int count;
  const ProductCard(
      {super.key,
      required this.title,
      required this.price,
      required this.url,
      required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: (count % 2 == 0)
            ? const Color.fromRGBO(216, 240, 250, 1)
            : const Color.fromRGBO(245, 247, 249, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '₹$price',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: Image.asset(
              url,
              height: 175,
            ),
          )
        ],
      ),
    );
  }
}
