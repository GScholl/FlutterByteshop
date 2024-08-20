import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/user_database_helper.dart';
import 'product_list_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      final user = await UserDatabaseHelper().getUser(username, password);

      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProductListScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('E-mail ou senha inválidos')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: 
      Container(
            decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0.67, 0.53), 
              radius: 1.0, 
              colors: [
                Color(0xFF9A4FCE), 
                Colors.transparent, 
              ],
              stops: [0.0, 2.5], 
            ),
           
          ),
        child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 100.0),
        child: Container(
          padding: const EdgeInsets.only(top: 70.00, left: 25.0,right: 25.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0), color: Colors.white),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset('assets/images/logo/logo.png'),
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    hintText: 'Digite seu E-mail',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor insira seu E-mail';
                    }
                    if (value.length < 3) {
                      return 'O seu E-mail deve ter no mínimo 3 caracteres';
                    }
                    return null;
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      hintText: 'Digite sua senha',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por Favor insira sua senha';
                      }
                      if (value.length < 6) {
                        return 'A senha deve ter no mínimo 6 caracteres';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80.0, vertical: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 5,
                    ),
                    child: const Text('Login'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: const Text('Crie Sua Conta'),
                ),
              ],
            ),
          ),
        ),
      ),
      ),
     
    );
  }
}
