import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practicle_task/Api/Api.dart';
import 'package:practicle_task/Screen/ProductPage.dart';
import 'package:practicle_task/Screen/RegisterPage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credential to login"),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: emailController,
          onChanged: (value) {
            email = value;
          },
          decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
          onChanged: (value) {
            password = value;
          },
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            print(email);
            print(password);
            email = emailController.text.toString();
            password = passwordController.text.toString();

  print(
                            "password" +
                            password +
                            'email' +
                            email);
                        Loginapi( password, email);

          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.purple,
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20,color: Colors.white),
          ),
        )
      ],
    );
  }

  Loginapi( password, email) async {
     final uri = Uri.parse(Api.BASE_URL + Api.login);
    var verifydata = jsonEncode({
      
      'email': email,
      'password': password,
  
    });
   
    Map<String, String> headers = {
      'Content-type': 'application/json',
    };
  
  //   print("jsonBody"+verifydata);
  //  print("uri"+uri.toString());
    var response = await http.post(
      uri,
      headers: headers,
      body: verifydata,
    );
    var responsed = jsonDecode(response.body);
    print(responsed);
    if(response.statusCode==201){
      if (!mounted) return;
        SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('newLaunch', true);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
    
    
    return const ProductList();}));
    
    }
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Colors.purple),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account? "),
        TextButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SignupPage()));
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Colors.purple),
            ))
      ],
    );
  }
}
