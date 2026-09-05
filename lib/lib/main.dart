import 'package:flutter/material.dart';
import 'config.dart';

void main() {
  runApp(const LaPaixDuCoeurChauffeurApp());
}

class LaPaixDuCoeurChauffeurApp extends StatelessWidget {
  const LaPaixDuCoeurChauffeurApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'La Paix du Cœur - Chauffeur',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const ChauffeurHomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChauffeurHomeScreen extends StatefulWidget {
  const ChauffeurHomeScreen({super.key});

  @override
  State<ChauffeurHomeScreen> createState() => _ChauffeurHomeScreenState();
}

class _ChauffeurHomeScreenState extends State<ChauffeurHomeScreen> {
  bool _isOnline = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Espace Chauffeur & Livreur'),
        backgroundColor: Colors.amber[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Serveur : ${Config.serveurUrl}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 20),
            SwitchListTile(
              title: Text(
                _isOnline ? 'Vous êtes EN LIGNE' : 'Vous êtes HORS LIGNE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _isOnline ? Colors.green : Colors.red,
                ),
              ),
              subtitle: const Text('Basculer pour recevoir des courses'),
              value: _isOnline,
              onChanged: (bool value) {
                setState(() {
                  _isOnline = value;
                });
              },
            ),
            const Divider(height: 40),
            const Text('Courses en attente', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: _isOnline
                  ? ListView(
                      children: [
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.directions_car, color: Colors.amber),
                            title: const Text('Course Taxi - 2.5 km'),
                            subtitle: const Text('Départ : Abidjan - Destination : Plateau'),
                            trailing: const Text('1500 FCFA', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                            onTap: () {
                              _showAcceptRideDialog(context);
                            },
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: Text(
                        'Passez en ligne pour commencer à recevoir des demandes de transport.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAcceptRideDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nouvelle course proposée'),
          content: const Text('Voulez-vous accepter cette course de 1500 FCFA ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Refuser', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[800]),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Course acceptée ! Route vers le client...')),
                );
              },
              child: const Text('Accepter', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
