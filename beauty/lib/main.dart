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
  final String category;

  Product({
    required this.name,
    required this.brand,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.category,
  });
}

// --- 2. DONNÉES (Image Sun Kids rectifiée avec une huile bébé) ---
final List<Product> demoProducts = [
  Product(
    name: "Green Grape", brand: "Re:dence", price: 160.0, category: "Women",
    description: "Sérum pour affiner les pores et lisser le grain de peau.",
    imageUrl: "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?auto=format&fit=crop&q=80&w=500", 
  ),
  Product(
    name: "Pure Cleanser", brand: "Natural", price: 150.0, category: "Women",
    description: "Nettoyant doux protecteur pour un usage quotidien.",
    imageUrl: "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?auto=format&fit=crop&q=80&w=500",
  ),
  Product(
    name: "Vitamin C", brand: "Glowish", price: 120.0, category: "Man",
    description: "Sérum antioxydant puissant pour un teint éclatant.",
    imageUrl: "https://images.unsplash.com/photo-1612817288484-6f916006741a?auto=format&fit=crop&q=80&w=500",
  ),
  Product(
    name: "Ocean Mask", brand: "Deep Blue", price: 75.0, category: "Man",
    description: "Masque détox à l'argile marine pour purifier les pores.",
    imageUrl: "https://images.unsplash.com/photo-1594434296621-5135131430b5?auto=format&fit=crop&q=80&w=500",
  ),
  Product(
    name: "Sun Kids Oil", brand: "Kids Soft", price: 55.0, category: "Kids",
    description: "Huile apaisante et hydratante type Johnson, idéale pour les bébés.",
    // RECTIFICATION : Image d'huile pour bébé appropriée
    imageUrl: "https://images.unsplash.com/photo-1619451422372-957dad041764?q=80&w=500",
  ),
];

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

// --- ÉCRAN 0 : ONBOARDING ---
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
            ),
          ),
          Positioned.fill(child: Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.8)])))),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Skincare Product\n& Cosmetics", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold, height: 1.1)),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity, height: 65,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNavigation())),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryLime, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)), elevation: 0),
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

// --- NAVIGATION PRINCIPALE ---
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final Set<String> favoriteNames = {};

  void toggleFavorite(String name) {
    setState(() {
      if (favoriteNames.contains(name)) favoriteNames.remove(name);
      else favoriteNames.add(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(favs: favoriteNames, onToggle: toggleFavorite),
      SearchScreen(favs: favoriteNames, onToggle: toggleFavorite),
      FavoritesScreen(favs: favoriteNames, onToggle: toggleFavorite),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 25),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navIcon(Icons.home_filled, 0),
            _navIcon(Icons.search, 1),
            _navIcon(Icons.favorite, 2),
            _navIcon(Icons.person, 3),
          ],
        ),
      ),
    );
  }

  Widget _navIcon(IconData icon, int index) {
    bool isSelected = _currentIndex == index;
    return IconButton(
      icon: Icon(icon, color: isSelected ? Colors.black : Colors.grey),
      onPressed: () => setState(() => _currentIndex = index),
    );
  }
}

// --- ÉCRAN : ACCUEIL ---
class HomeScreen extends StatefulWidget {
  final Set<String> favs;
  final Function(String) onToggle;
  const HomeScreen({super.key, required this.favs, required this.onToggle});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    List<Product> products = demoProducts.where((p) => selectedCategory == "All" || p.category == selectedCategory).toList();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Best Skincare", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildPromoBanner(),
            const SizedBox(height: 30),
            const Text("Collections", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            _buildCategoryChips(),
            const SizedBox(height: 25),
            _buildProductGrid(products),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity, height: 160,
      decoration: BoxDecoration(color: AppColors.primaryLime, borderRadius: BorderRadius.circular(25)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("New Collection\nDelicate Skin", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ElevatedButton(
                  // RECTIFICATION : Activation du bouton Shop Now
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NewCollectionPage())),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black, shape: const StadiumBorder(), elevation: 0),
                  child: const Text("Shop Now", style: TextStyle(fontSize: 12)),
                )
              ],
            ),
          ),
          Positioned(right: -10, bottom: 0, child: Image.network("https://www.pngmart.com/files/12/Cosmetic-Products-PNG-Clipart.png", height: 120, errorBuilder: (c,e,s) => const SizedBox())),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: ["All", "Women", "Man", "Kids"].map((cat) {
          bool isSelected = selectedCategory == cat;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ChoiceChip(
              label: Text(cat),
              selected: isSelected,
              onSelected: (_) => setState(() => selectedCategory = cat),
              selectedColor: Colors.black,
              labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProductGrid(List<Product> list) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 15, mainAxisSpacing: 15),
      itemBuilder: (context, index) {
        final p = list[index];
        bool isFav = widget.favs.contains(p.name);
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(product: p))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(20)),
                  child: Stack(
                    children: [
                      Center(child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.network(p.imageUrl, fit: BoxFit.cover, width: double.infinity, height: double.infinity, errorBuilder: (c,e,s) => const Icon(Icons.image)))),
                      Positioned(top: 5, right: 5, child: IconButton(icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red : Colors.black), onPressed: () => widget.onToggle(p.name))),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
              Text("\$${p.price.toInt()}", style: const TextStyle(color: Colors.grey)),
            ],
          ),
        );
      },
    );
  }
}

// --- ÉCRAN : DÉTAILS DU PRODUIT (Prix actualisé) ---
class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.product.price * quantity;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, foregroundColor: Colors.black),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: ClipRRect(borderRadius: BorderRadius.circular(30), child: Image.network(widget.product.imageUrl, height: 300, fit: BoxFit.cover))),
                  const SizedBox(height: 30),
                  Text(widget.product.brand, style: const TextStyle(color: Colors.grey, fontSize: 16)),
                  const SizedBox(height: 5),
                  Text(widget.product.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(widget.product.description, style: const TextStyle(color: Colors.grey, fontSize: 16, height: 1.5)),
                  const SizedBox(height: 30),
                  const Text("Quantity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      _qtyBtn(Icons.remove, () { if(quantity > 1) setState(() => quantity--); }),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Text("$quantity", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                      _qtyBtn(Icons.add, () => setState(() => quantity++)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Total Price", style: TextStyle(color: Colors.grey)),
                      Text("\$${totalPrice.toInt()}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60, width: 180,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryLime, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), elevation: 0),
                    child: const Text("Buy Now", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback action) => GestureDetector(
    onTap: action,
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(10)),
      child: Icon(icon),
    ),
  );
}

// --- RECHERCHE ---
class SearchScreen extends StatefulWidget {
  final Set<String> favs;
  final Function(String) onToggle;
  const SearchScreen({super.key, required this.favs, required this.onToggle});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "";
  @override
  Widget build(BuildContext context) {
    List<Product> results = demoProducts.where((p) => p.name.toLowerCase().contains(query.toLowerCase())).toList();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(padding: const EdgeInsets.symmetric(horizontal: 15), decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(15)), child: TextField(onChanged: (v) => setState(() => query = v), decoration: const InputDecoration(hintText: "Search...", border: InputBorder.none, icon: Icon(Icons.search)))),
            const SizedBox(height: 20),
            Expanded(child: GridView.builder(itemCount: results.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 15, mainAxisSpacing: 15), itemBuilder: (c, i) => _buildGridItem(results[i], context))),
          ],
        ),
      ),
    );
  }
  Widget _buildGridItem(Product p, context) => GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => ProductDetailPage(product: p))), child: Column(children: [Expanded(child: Container(decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(20)), child: Center(child: Image.network(p.imageUrl, fit: BoxFit.cover)))), Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold))]));
}

// --- FAVORIS ---
class FavoritesScreen extends StatelessWidget {
  final Set<String> favs;
  final Function(String) onToggle;
  const FavoritesScreen({super.key, required this.favs, required this.onToggle});
  @override
  Widget build(BuildContext context) {
    List<Product> list = demoProducts.where((p) => favs.contains(p.name)).toList();
    return SafeArea(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("My Favorites", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)), const SizedBox(height: 20), Expanded(child: GridView.builder(itemCount: list.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 15, mainAxisSpacing: 15), itemBuilder: (c, i) => _buildGridItem(list[i], context)))])));
  }
  Widget _buildGridItem(Product p, context) => GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => ProductDetailPage(product: p))), child: Column(children: [Expanded(child: Container(decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(20)), child: Center(child: Image.network(p.imageUrl, fit: BoxFit.cover)))), Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold))]));
}

// --- PROFIL ---
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(children: [const SizedBox(height: 40), const CircleAvatar(radius: 50, backgroundColor: AppColors.primaryLime, child: Icon(Icons.person, size: 50, color: Colors.black)), const SizedBox(height: 15), const Text("User Name", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), const SizedBox(height: 30), _item(Icons.shopping_bag_outlined, "Orders"), _item(Icons.logout, "Logout")]));
  }
  Widget _item(IconData icon, String title) => ListTile(leading: Icon(icon), title: Text(title), trailing: const Icon(Icons.chevron_right));
}

// --- PAGE COLLECTION ---
class NewCollectionPage extends StatelessWidget {
  const NewCollectionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Collection"), backgroundColor: Colors.white, foregroundColor: Colors.black, elevation: 0),
      body: const Center(child: Text("Welcome to the Limited Edition Collection!")),
    );
  }
}