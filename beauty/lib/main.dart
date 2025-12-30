import 'package:flutter/material.dart';

void main() {
  runApp(const SkincareApp());
}

// 1. LE MODÈLE DE DONNÉES (L'aspect dynamique commence ici)
class Product {
  final String id;
  final String name;
  final String brand;
  final String description;
  final double price;
  final String imageUrl;
  final String size;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.size = "30ml",
  });
}

// 2. TA BASE DE DONNÉES DE TEST
final List<Product> demoProducts = [
  Product(
    id: "1",
    name: "Pore Zero Ampoule",
    brand: "Re:dence",
    description: "Green Grape Pore Zero Ampoule by Re:dence is a lightweight facial serum designed to refine pores, balance oil, and hydrate skin. 30ml bottle for daily skincare use for glowing skin.",
    price: 160.0,
    imageUrl: "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?q=80&w=3087&auto=format&fit=crop",
  ),
  Product(
    id: "2",
    name: "Facial Cleanser",
    brand: "Greenling",
    description: "Deep cleansing formula for delicate and sensitive skin. Provides a 24h moisture barrier while removing impurities.",
    price: 150.0,
    imageUrl: "https://images.unsplash.com/photo-1556228720-195a672e8a03?q=80&w=3087&auto=format&fit=crop",
  ),
];

// 3. STRUCTURE DE L'APPLICATION ET THÈME
class SkincareApp extends StatelessWidget {
  const SkincareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skincare App',
      theme: ThemeData(
        // On définit la couleur primaire pour l'utiliser partout facilement
        primaryColor: const Color(0xFFC4EF64),
        scaffoldBackgroundColor: const Color(0xFFF9F9F7),
        fontFamily: 'Georgia', // On utilise une police élégante par défaut
      ),
      // On pointe vers un écran temporaire pour que ça compile
      home: const Scaffold(body: Center(child: Text("Étape 1 terminée"))),
    );
  }
}