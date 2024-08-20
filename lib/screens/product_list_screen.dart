import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app_pdm/screens/cart_screen.dart';
import '../services/product_database_helper.dart';
import '../models/product.dart';
import '../widgets/product_card.dart'; // Importa o ProductCard
import 'add_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = ProductDatabaseHelper().products();
  }

  void _refreshProducts() {
    setState(() {
      _products = ProductDatabaseHelper().products();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/logo/logo.png', height: 40),
             IconButton(
          icon: const Icon(Icons.add),
          tooltip: 'Adicionar um produto',
          onPressed: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductScreen()),
          ).then((_) => _refreshProducts());
          },
        ),

          ],
        ),
         backgroundColor: Color.fromARGB(255, 54, 54, 54),
        foregroundColor: Colors.white,
        ),
       
      body: Container(color: Color.fromARGB(255, 252, 245, 237), child: FutureBuilder<List<Product>>(
       
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Não foi possível encontrar os produtos.'));
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                );
              },
            );
          }
        },
      ),), 
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartScreen())).then((_) => _refreshProducts());
          
        },
        tooltip: 'Ver Carrinho',
        backgroundColor: Color(0xFF9A4FCE),
        foregroundColor: Colors.white,
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
