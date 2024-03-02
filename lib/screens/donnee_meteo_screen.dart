import 'package:flutter/material.dart';
import 'package:exam_app_meteo/screens/details_ville_screen.dart';

class DonneeMeteoScreen extends StatelessWidget {
  final List<Map<String, dynamic>> resultats;

  DonneeMeteoScreen({required this.resultats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prévisions météo',
           style: TextStyle(fontFamily: 'Roboto'),
        ),
        backgroundColor: Colors.blueAccent, // Couleur de la barre de navigation
        elevation: 0, // Supprime l'ombre sous la barre de navigation
      ),
      backgroundColor: Colors.blue.shade50, // Couleur de fond de l'écran
      body: Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/images/comment-prevoir-meteo-scaled.jpg'), // Image d'arrière-plan
        fit: BoxFit.cover,
        ),
       ),
       child: ListView.builder(
          itemCount: resultats.length,
          itemBuilder: (context, index) {
            final resultat = resultats[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsVilleScreen(villeDetails: resultat),
                  ),
                );
              },
            splashColor: Colors.blue, // Couleur du ripple lors du clic
            child: Card(
              elevation: 3, // Ajoute une ombre aux cartes
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.white.withOpacity(0.8), // Fond de la carte avec opacité
              child: ListTile(
                leading: getWeatherIcon(resultat['couvertureNuageuse']),
                title: Text(resultat['ville'],
                  style: const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    'Nom de la ville: ${resultat['ville']}, Température: ${resultat['temperature']}°C, Couverture nuageuse: ${resultat['couvertureNuageuse']}',
                     style: const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
      ),
    );
  }

  Icon getWeatherIcon(String weatherCondition) {
    switch (weatherCondition) {
      case 'Ensoleillé':
        return const Icon(Icons.wb_sunny, color: Colors.orange);
      case 'Nuageux':
        return const Icon(Icons.cloud, color: Colors.grey);
      case 'Partiellement nuageux':
        return const Icon(Icons.wb_cloudy, color: Colors.lightBlue);
      case 'Pluvieux':
        return const Icon(Icons.beach_access, color: Colors.blue);
      case 'Ciel dégagé':
        return const Icon(Icons.brightness_5, color: Colors.yellow);
      default:
        return const Icon(Icons.error);
    }
  }
}
