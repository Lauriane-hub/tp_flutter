import 'package:flutter/material.dart';

void main() {
  runApp(const SkincareApp());
}

// --- 1. MODÈLE DE DONNÉES UNIQUE ---
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

// --- 2. DONNÉES DYNAMIQUES (Source de vérité) ---
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
    brand: "Natural Serum",
    price: 150.0,
    description: "A natural cleanser for delicate skin.",
    imageUrl: "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?q=80&w=500",
  ),
  Product(
    name: "Glowish",
    brand: "Vitamin C",
    price: 120.0,
    description: "Brightening serum for a natural glow.",
    imageUrl: "https://images.unsplash.com/photo-1612817288484-6f916006741a?q=80&w=500",
  ),
];

// --- 3. THEME GLOBAL ---
class AppColors {
  static const Color primaryLime = Color(0xFFCEFE1C);
  static const Color background = Color(0xFFFDFDFD);
  static const Color lightGrey = Color(0xFFF5F5F5);
}

class SkincareApp extends StatelessWidget {
  const SkincareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skincare App',
      theme: ThemeData(fontFamily: 'sans-serif'),
      home: const OnboardingScreen(),
    );
  }
}

// --- 4. ÉCRAN 1 : ONBOARDING ---
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image de fond
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1552046122-03184de85e08?q=80&w=1000',
              fit: BoxFit.cover,
            ),
          ),
          // Dégradé noir pour la lisibilité
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                ),
              ),
            ),
          ),
          // Contenu
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Skincare Product\n& Cosmetics",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold, height: 1.1),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Beauty gives you the confidence\nyou deserve",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 65,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryLime,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                        elevation: 0,
                      ),
                      child: const Text("Get Started", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- 5. ÉCRAN 2 : ACCUEIL (HOME) ---
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Best Skincare", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        const Icon(Icons.search, size: 28),
                        const SizedBox(width: 15),
                        const Icon(Icons.shopping_bag_outlined, size: 28),
                      ],
                    )
                  ],
                ),
              ),

              // Bannière Promotionnelle
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  color: AppColors.primaryLime,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("New Collection for\nDelicate skin",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                            child: const Text("Shop Now", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 10, bottom: 0, top: 10,
                      child: Image.network('https://www.pngmart.com/files/12/Cosmetic-Products-PNG-Clipart.png', 
                      errorBuilder: (c,e,s) => const SizedBox()),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 25),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Collections", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("See all", style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 15),
              
              // Filtres horizontaux
              SizedBox(
                height: 45,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryChip("All", isSelected: true),
                    _buildCategoryChip("Women"),
                    _buildCategoryChip("Man"),
                    _buildCategoryChip("Kids"),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Grille de Produits
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: demoProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  final product = demoProducts[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              Center(child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image.network(product.imageUrl, fit: BoxFit.contain),
                              )),
                              const Positioned(top: 12, right: 12, child: Icon(Icons.favorite_border, size: 22)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(product.brand, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 4),
                      Text("\$${product.price}", style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  );
                },
              ),
              const SizedBox(height: 100), // Espace pour ne pas cacher par la barre de menu
            ],
          ),
        ),
      ),
      
      // Barre de navigation flottante
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, spreadRadius: 2)],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.home_filled, color: Colors.black, size: 28),
            Icon(Icons.search, color: Colors.grey, size: 28),
            Icon(Icons.favorite_border, color: Colors.grey, size: 28),
            Icon(Icons.person_outline, color: Colors.grey, size: 28),
          ],
        ),
      ),
    );
  }

  // Widget pour les petites bulles de catégorie
  Widget _buildCategoryChip(String label, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Center(
        child: Text(
          label, 
          style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold)
        ),
      ),
    );
  }
}