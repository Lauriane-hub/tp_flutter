import 'package:flutter/material.dart';

void main() {
  runApp(const SkincareApp());
}

// --- 1. MODÈLE DE DONNÉES DYNAMIQUE ---
// Cela permet de gérer tes produits facilement
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

// --- 2. SOURCE DE DONNÉES (SIMULATION API/DATABASE) ---
final List<Product> demoProducts = [
  Product(
    name: "Green Grape",
    brand: "Re:dence",
    price: 160.0,
    description: "Green Grape Pore Zero Ampoule by Re:dence is a lightweight facial serum designed to refine pores, balance oil, and hydrate skin.",
    imageUrl: "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?q=80&w=500", 
  ),
  Product(
    name: "Greenling",
    brand: "Natural",
    price: 150.0,
    description: "A natural cleanser for delicate skin.",
    imageUrl: "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?q=80&w=500",
  ),
];

// --- 3. THEME DE L'APPLICATION ---
class AppColors {
  static const Color primaryGreen = Color(0xFFC1F124); // Le vert lime exact
  static const Color background = Color(0xFFFDFDFD);
}

class SkincareApp extends StatelessWidget {
  const SkincareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skincare App',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Sans-serif', // Tu pourras ajouter une police personnalisée plus tard
      ),
      home: const OnboardingScreen(),
    );
  }
}

// --- 4. PREMIER ÉCRAN : ONBOARDING ---
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image de fond (Dynamique via URL ou Asset)
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1596462502278-27bfdc4033c8?q=80&w=1000',
              fit: BoxFit.cover,
            ),
          ),
          
          // Overlay dégradé pour le texte
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),

          // Contenu (Texte et Bouton)
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Skincare Product\n& Cosmetics",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Beauty gives you the confidence\nyou deserve",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 40),
                
                // Bouton Get Started
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      // Nous coderons l'écran suivant à l'étape 2
                      print("Aller vers l'accueil");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
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
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}