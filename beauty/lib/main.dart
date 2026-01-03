import 'package:flutter/material.dart';

void main() {
  runApp(const SkincareApp());
}

// --- MODÈLE DYNAMIQUE ---
class Product {
  final String name;
  final String brand;
  final double price;
  final String description;
  final String imageUrl;

  Product({
    required this.name,
    required this.brand,
    required this.price,
    required this.description,
    required this.imageUrl,
  });
}

// --- COULEURS ET STYLE ---
class AppTheme {
  static const Color primaryLime = Color(0xFFCEFE1C); // Le vert lime de l'image
  static const Color textWhite = Colors.white;
}

class SkincareApp extends StatelessWidget {
  const SkincareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'sans-serif'),
      home: const OnboardingScreen(),
    );
  }
}

// --- ÉCRAN 1 : ONBOARDING ---
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. IMAGE DE FOND (L'image de la femme)
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1552046122-03184de85e08?q=80&w=1000&auto=format&fit=crop',
              fit: BoxFit.cover,
              // Gestionnaire d'erreur si l'image ne charge pas
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.grey[300]);
              },
            ),
          ),

          // 2. LE DÉGRADÉ (Essentiel pour le look de l'image originale)
          // On met un léger dégradé noir en bas pour la lisibilité
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.5, 0.9],
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ),

          // 3. LE CONTENU (Texte et Bouton)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Skincare Product\n& Cosmetics",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.textWhite,
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Beauty gives you the confidence\nyou deserve",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.textWhite.withOpacity(0.8),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // BOUTON "GET STARTED"
                  SizedBox(
                    width: double.infinity,
                    height: 65,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigation vers l'étape suivante (Home)
                        print("Direction vers l'accueil");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryLime,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                      child: const Text(
                        "Get Started",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30), // Espace en bas de l'écran
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}