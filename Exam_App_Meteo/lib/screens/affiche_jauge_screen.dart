import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:exam_app_meteo/screens/donnee_meteo_screen.dart';
import 'package:exam_app_meteo/screens/details_ville_screen.dart';

class AfficheJaugeScreen extends StatefulWidget {
  bool _jaugeRemplie = false;
  AfficheJaugeScreen({Key? key}) : super(key: key);

  @override
  _AfficheJaugeScreenState createState() => _AfficheJaugeScreenState();
}

class _AfficheJaugeScreenState extends State<AfficheJaugeScreen> {
  bool _jaugeRemplie = false; // Déclaration de _jaugeRemplie
  List<Map<String, dynamic>> _resultats = []; // Déclaration de _resultats
  double _progress = 0.0;
  Timer? _progressTimer;
  Timer? _messageTimer;
  List<String> villes = ['Rennes', 'Paris', 'Nantes', 'Bordeaux', 'Lyon'];
  List<Map<String, dynamic>> meteoData = [];
  bool showResults = false;

  List<String> messages = [
    'Nous téléchargeons les données...',
    'C’est presque fini...',
    'Plus que quelques secondes avant d’avoir le résultat…'
  ];
  int currentMessageIndex = 0;

  @override
  void initState() {
    super.initState();
    _telechargerDonnees();
    List<Map<String, dynamic>> villesDetails = [];
    _progressTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        _progress += 16.67;
        if (_progress >= 100) {
          _progressTimer?.cancel();
          _messageTimer?.cancel();
          _fetchWeatherData();
        }
      });
    });

    _messageTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
      setState(() {
        currentMessageIndex = (currentMessageIndex + 1) % messages.length;
      });
    });

  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    _messageTimer?.cancel();
    super.dispose();
  }

  Future<void> _fetchWeatherData() async {
    const apiKey = 'c266878f495a29c07543c8f9501dd55e'; // Remplacez par votre clé API
    final List<Map<String, dynamic>> data = [];

    for (var ville in villes) {
      final url = 'https://api.openweathermap.org/data/2.5/weather?q=$ville&appid=$apiKey&units=metric';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        data.add({'ville': ville, 'data': jsonData});
      } else {
        data.add({'ville': ville, 'data': null});
      }
    }

    setState(() {
      meteoData = data;
      showResults = true;
    });
  }

  // Méthode pour simuler le téléchargement des données
  void _telechargerDonnees() {

    // Simuler le téléchargement des données
    Future.delayed(Duration(seconds: 60), () {
      // Mettre à jour l'état lorsque la jauge est remplie
      setState(() {
        _jaugeRemplie = true;
        _resultats = [
          {
            'ville': 'Paris',
            'temperature': 25,
            'couvertureNuageuse': 'Ensoleillé'
          },
          {
            'ville': 'Londres',
            'temperature': 20,
            'couvertureNuageuse': 'Nuageux'
          },
          {
            'ville': 'New York',
            'temperature': 28,
            'couvertureNuageuse': 'Partiellement nuageux'
          },
          {
            'ville': 'Tokyo',
            'temperature': 30,
            'couvertureNuageuse': 'Pluvieux'
          },
          {
            'ville': 'Sydney',
            'temperature': 22,
            'couvertureNuageuse': 'Ciel dégagé'
          },
          {
          'ville': 'Dakar',
          'temperature': 22,
          'couvertureNuageuse': 'Pluvieux'
          },
          {
          'ville': 'Dubai',
          'temperature': 22,
          'couvertureNuageuse': 'Ciel dégagé'
        },
        ];
      });
      // Naviguer vers DonneeMeteoScreen lorsque la jauge est remplie
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DonneeMeteoScreen(resultats: _resultats),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progression'),
      ),
      body: Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/images/ciel_bleu.jpg'), // Image d'arrière-plan
        fit: BoxFit.cover,
        ),
        ),
      child: Center(
        child: _jaugeRemplie
            ? ElevatedButton(
                onPressed: () {
                  // Lorsque le bouton "Recommencer" est pressé, réinitialiser l'état et recommencer
                setState(() {
                  _jaugeRemplie = false;
                  // Autres logiques de réinitialisation ici si nécessaire
                });
              },
                child: const Text('Recommencer'),
              )
            : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Text(
                messages[currentMessageIndex],
                style: const TextStyle(fontSize: 20.0),
              ),
              const SizedBox(height: 20.0),
              LinearProgressIndicator(
                value: _progress / 100,
                minHeight: 20.0,
                backgroundColor: Colors.grey,
                semanticsValue: '${_progress.round()}%',
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
          // Code pour la liste des villes dans votre écran AfficheJaugeScreen

            ],
          ),
      ),
      ),
    );
  }
}