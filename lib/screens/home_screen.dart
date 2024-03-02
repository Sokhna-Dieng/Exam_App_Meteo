import 'package:exam_app_meteo/screens/affiche_jauge_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
      ),
      body:  Container(
          decoration: const BoxDecoration(
          image: DecorationImage(
          image: AssetImage('assets/images/comment-prevoir-meteo-scaled.jpg'), // Image d'arrière-plan
          fit: BoxFit.cover,
          ),
          ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Bienvenue dans l\'application météo',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AfficheJaugeScreen()),
                );
              },
              child: const Text('Obtenir la météo'),
            ),
          ],
        ),
      ),
      ),
    );
  }
}