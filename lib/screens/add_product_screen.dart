import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/product_database_helper.dart';
import '../models/product.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo/logo.png', height: 40),
        backgroundColor: Color.fromARGB(255, 54, 54, 54),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Adicionar um produto'),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do produto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o preço do produto';
                  }
                  try {
                    value = value.replaceAll(',', '.');
                    double.parse(value);
                  } catch (e) {
                    return 'Por favor, insira um valor válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição do produto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _image == null
                  ? Text('Nenhuma Imagem selecionada.')
                  : Padding(
                      padding: EdgeInsets.all(5),
                      child: Image.file(
                        File(_image!.path),
                        width: double.infinity,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
              ElevatedButton(
                onPressed: () async {
                  final pickedImage =
                      await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    _image = pickedImage;
                  });
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                    disabledForegroundColor: Colors.white.withOpacity(0.38),
                    disabledBackgroundColor: Colors.white.withOpacity(0.12),
                    fixedSize: const Size(400, 40)),
                child: Text('Selecionar Imagem'),
              ),
              const SizedBox(height: 10, width: double.infinity),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveProduct();
                  }
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF9A4FCE),
                    disabledForegroundColor: Colors.white.withOpacity(0.38),
                    disabledBackgroundColor: Colors.white.withOpacity(0.12),
                    fixedSize: const Size(400, 40)),
                child: const Text(
                  'Salvar Produto',
                  selectionColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveProduct() async {
    final name = _nameController.text;
    final price = double.tryParse(_priceController.text) ?? 0.0;
    final description = _descriptionController.text;
    final imagePath = _image?.path ?? '';

    final product = Product(
      id: 0,
      name: name,
      price: price,
      description: description,
      imagePath: imagePath,
    );
    await ProductDatabaseHelper().insertProduct(product);

    Navigator.pop(context);
  }
}
