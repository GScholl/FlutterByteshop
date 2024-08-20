import 'package:flutter/material.dart';
import 'package:flutter_app_pdm/screens/login_screen.dart';
import '../services/user_database_helper.dart';
import 'package:email_validator/email_validator.dart';
import '../models/user.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final name = _nameController.text;
      final password = _passwordController.text;
      final confirmPassword = _confirmPasswordController.text;

      if(password != confirmPassword){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('As senhas não coincidem')),
        );
        return;
      }
      final user = User(id: 0, email: email, name:name, password: password);
      if(await UserDatabaseHelper().emailExists(email)){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('E-mail já cadastrado')),
        );
        return;
      }
      await UserDatabaseHelper().insertUser(user);

      Navigator.pop(context);
       ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registro Efetuado com sucesso!')),
        );
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
          padding: const EdgeInsets.only(top: 70.00, left: 25.0,right: 25.0,),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0), color: Colors.white),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(0.0),
                  child: Image.asset('assets/images/logo/logo.png', width: 300 ),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    hintText: 'Digite seu nome',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor insira seu nome de usuário';
                    }
                    if (value.length < 3) {
                      return 'O nome de usuário deve ter no mínimo 3 caracteres';
                    }
                    return null;
                  },
                ),
                 Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  child: 
                  TextFormField(
                  controller: _emailController,
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
                      return 'O E-mail deve ter no mínimo 3 caracteres';
                    }
                     if(!EmailValidator.validate(value)){
                      return 'Por favor insira um E-mail válido';
                    }
                    return null;
                  },
                ),
                 ),
                Container(
                  margin: const EdgeInsets.only(top: 8.0),
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
                       Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirme a senha',
                      hintText: 'Confirme sua senha',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por Favor confirme sua senha';
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
                    onPressed: _register,
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
                    child: const Text('Registrar-se'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: const Text('Já Possui conta? Faça Login'),
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
