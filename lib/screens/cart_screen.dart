import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/logo/logo.png', height: 40),
            Text("Carrinho")
          ],
        ),
        backgroundColor: Color.fromARGB(255, 54, 54, 54),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cart.items.length,
              itemBuilder: (context, index) {
                final item = cartProvider.cart.items[index];
                return ListTile(
                  leading: item.product.imagePath.isNotEmpty
                      ? Image.file(
                          File(item.product.imagePath),
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 20,
                          color: Colors.grey[300],
                          child: Icon(Icons.image,
                              size: 50, color: Colors.grey[700]),
                        ),
                  title: Text(item.product.name),
                  subtitle: Text("${item.quantity} x R\$${item.product.price.toStringAsFixed(2).replaceAll('.', ',')}"),
                  trailing: 
                 SizedBox(width: 35,height: 35,child:  IconButton(
                    style: IconButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                      iconSize: 19.0,
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      cartProvider.removeItem(item.product);
                    },
                  ),)
                 
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Total: R\$ ${cartProvider.cart.totalAmount.toStringAsFixed(2).replaceAll('.', ',')}"),
          ),
        ],
      ),
    );
  }
}
