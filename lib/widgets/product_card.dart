// lib/widgets/product_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_app_pdm/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: const EdgeInsets.all(8.0),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10.00),
          child: Column(
            children: [
              // Imagem quadrada
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10.0)),
                child: product.imagePath.isNotEmpty
                    ? Image.file(
                        File(product.imagePath),
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.contain,
                      )
                    : Container(
                        width: double.infinity,
                        height: 150,
                        color: Colors.grey[300],
                        child: Icon(Icons.image,
                            size: 50, color: Colors.grey[700]),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'R\$ ${product.price.toStringAsFixed(2)}',
                            style: TextStyle(color: Colors.green, fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.description,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .addItem(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Produto adicionado ao carrinho!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF9A4FCE),
                      disabledForegroundColor: Colors.white.withOpacity(0.38),
                      disabledBackgroundColor: Colors.white.withOpacity(0.12),
                      fixedSize: const Size(380, 40)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart),
                      SizedBox(width: 10),
                      Text('Adicionar ao Carrinho'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
