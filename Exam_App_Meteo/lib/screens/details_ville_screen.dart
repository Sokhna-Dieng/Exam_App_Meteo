import 'package:flutter/material.dart';

class DetailsVilleScreen extends StatelessWidget {
  final Map<String, dynamic> villeDetails;

  DetailsVilleScreen({required this.villeDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la ville'),
      ),
      body: Container(
          decoration: const BoxDecoration(
          image: DecorationImage(
          image: AssetImage('assets/images/ciel_nuageux.jpg'), // Image d'arrière-plan
          fit: BoxFit.cover,
          ),
          ),
       child:  Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Nom de la ville: ${villeDetails['nom']}'),
              Text('Température: ${villeDetails['temperature']}°C'),
              Text('Couverture nuageuse: ${villeDetails['couvertureNuageuse']}'),
              // Ajoutez d'autres informations de la ville ici si nécessaire
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Bouton retour pour revenir à l'écran précédent
                },
                child: Text('Retour'),
              ),
          ],
        ),
      ),
      ),
    );
  }
}
