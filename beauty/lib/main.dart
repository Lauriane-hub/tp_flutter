import 'package:flutter/material.dart';

void main() {
  runApp(const SkincareApp());
}

// --- 1. MODÈLE DE DONNÉES ---
class Product {
  final String name;
  final String brand;
  final double price;
  final String description;
  final String imageUrl;
  final String size;
  final String category;

  Product({
    required this.name,
    required this.brand,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.category,
    this.size = "30ml",
  });
}

// Données dynamiques
final List<Product> demoProducts = [
  Product(
    name: "Green Grape",
    brand: "Re:dence",
    price: 160.0,
    category: "Women",
    description: "Green Grape Pore Zero Ampoule by Re:dence is a lightweight facial serum designed to refine pores, balance oil, and hydrate skin. 30ml bottle for daily skincare use for glowing skin.",
    imageUrl: "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?q=80&w=500", 
  ),
  Product(
    name: "Greenling",
    brand: "Natural Serum",
    price: 150.0,
    category: "Women",
    description: "A natural cleanser for delicate skin designed to refresh and protect your natural skin barrier while providing deep hydration.",
    imageUrl: "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?q=80&w=500",
  ),
  Product(
    name: "Glowish",
    brand: "Vitamin C",
    price: 120.0,
    category: "Man",
    description: "Brightening serum for a natural glow and even skin tone. Formulated with pure Vitamin C and antioxidants.",
    imageUrl: "https://images.unsplash.com/photo-1612817288484-6f916006741a?q=80&w=500",
  ),
];

// --- 2. THEME ---
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
      theme: ThemeData(fontFamily: 'sans-serif'),
      home: const OnboardingScreen(),
    );
  }
}

// --- 3. ÉCRAN 1 : ONBOARDING ---
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1552046122-03184de85e08?q=80&w=1000', 
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(color: Colors.grey),
            ),
          ),
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
                    width: double.infinity, height: 65,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen())),
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

// --- 4. ÉCRAN 2 : ACCUEIL ---
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "All";
  int selectedNavIndex = 0;
  bool isSearching = false;
  String searchQuery = "";
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose(); // Bonne pratique : on libère la mémoire
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filtrage dynamique combiné
    List<Product> filteredProducts = demoProducts.where((p) {
      bool categoryMatch = selectedCategory == "All" || p.category == selectedCategory;
      bool searchMatch = p.name.toLowerCase().contains(searchQuery.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header dynamique
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (!isSearching)
                      const Text("Best Skincare", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
                    else
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: "Search products...",
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  isSearching = false;
                                  searchQuery = "";
                                  searchController.clear();
                                });
                              },
                            ),
                          ),
                          onChanged: (value) => setState(() => searchQuery = value),
                        ),
                      ),
                    if (!isSearching)
                      Row(
                        children: [
                          IconButton(icon: const Icon(Icons.search, size: 28), onPressed: () => setState(() => isSearching = true)),
                          IconButton(icon: const Icon(Icons.shopping_bag_outlined, size: 28), onPressed: () {}),
                        ],
                      )
                  ],
                ),
              ),
              // Bannière Promo
              Container(
                width: double.infinity, height: 160,
                decoration: BoxDecoration(color: AppColors.primaryLime, borderRadius: BorderRadius.circular(25)),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("New Collection for\nDelicate skin", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                            child: const Text("Shop Now", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),
                    Positioned(right: 10, bottom: 0, top: 10, child: Image.network('https://www.pngmart.com/files/12/Cosmetic-Products-PNG-Clipart.png', errorBuilder: (c,e,s) => const SizedBox())),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Text("Collections", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              // Catégories
              SizedBox(
                height: 45,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: ["All", "Women", "Man", "Kids"].map((cat) => _buildCategoryChip(cat)).toList(),
                ),
              ),
              const SizedBox(height: 25),
              // Grille de produits
              filteredProducts.isEmpty 
                ? const Center(child: Padding(padding: EdgeInsets.all(40), child: Text("No results found")))
                : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 15, mainAxisSpacing: 15),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(product: product))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(20)),
                            child: Stack(
                              children: [
                                Center(child: Hero(tag: product.name, child: Image.network(product.imageUrl, fit: BoxFit.contain))),
                                const Positioned(top: 12, right: 12, child: Icon(Icons.favorite_border, size: 22)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(product.brand, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Text("\$${product.price.toInt()}", style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20)]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(4, (index) {
            IconData icon = [Icons.home_filled, Icons.search, Icons.favorite_border, Icons.person_outline][index];
            return IconButton(
              icon: Icon(icon, color: selectedNavIndex == index ? Colors.black : Colors.grey),
              onPressed: () {
                setState(() => selectedNavIndex = index);
                if(index == 1) setState(() => isSearching = true);
              },
            );
          }),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    bool isSelected = selectedCategory == label;
    return GestureDetector(
      onTap: () => setState(() => selectedCategory = label),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Center(child: Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold))),
      ),
    );
  }
}

// --- 5. ÉCRAN 3 : DÉTAILS ---
class DetailScreen extends StatefulWidget {
  final Product product;
  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Center(
              child: Hero(
                tag: widget.product.name,
                child: Image.network(widget.product.imageUrl, fit: BoxFit.contain, width: MediaQuery.of(context).size.width * 0.7),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.product.name, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(color: AppColors.primaryLime, shape: BoxShape.circle),
                        child: const Icon(Icons.favorite, color: Colors.white, size: 24),
                      ),
                    ],
                  ),
                  Text(widget.product.size, style: const TextStyle(color: Colors.grey, fontSize: 18)),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          children: [
                            IconButton(onPressed: () => setState(() => quantity > 1 ? quantity-- : null), icon: const Icon(Icons.remove)),
                            Text("$quantity", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            IconButton(onPressed: () => setState(() => quantity++), icon: const Icon(Icons.add)),
                          ],
                        ),
                      ),
                      Text("\$${widget.product.price.toInt()}", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 35),
                  const Text("Product Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(widget.product.description, style: TextStyle(color: Colors.grey.shade600, fontSize: 15, height: 1.5)),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity, height: 65,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryLime, foregroundColor: Colors.black, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35))),
                      child: const Text("Buy Now", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}