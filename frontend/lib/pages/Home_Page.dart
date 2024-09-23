import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/Companie.dart';
import 'package:flutter_app/model/Produit.dart';
import 'package:flutter_app/pages/QrCode-page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  Future<List<Companie>> fetchCompaniesBoycott() async {
    return _fetchData<Companie>(
      'http://192.168.1.14:8080/api/companies/ListCompanies',
      (data) => Companie.formJson(data),
    );
  }

  Future<List<Produit>> fetchProduitsBoycott() async {
    return _fetchData<Produit>(
      'http://192.168.1.14:8080/api/produits/boycott-produits',
      (data) => Produit.fromJson(data),
    );
  }

  Future<List<T>> _fetchData<T>(
      String url, T Function(Map<String, dynamic>) fromJson) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          _buildHomePage(),
          BarCodeScanner(),
        ],
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, -2), // Shadow above the bar
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavItem(Icons.home_max_sharp, 'Home', 0),
          _buildBottomNavItem(Icons.camera_enhance_outlined, 'QRCode', 1),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Color(0xFF09FBD3) : Colors.red,
            size: 30,
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Color(0xFF09FBD3) : Colors.red,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isSelected)
            Container(
              margin: EdgeInsets.only(top: 5),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Color(0xFF09FBD3),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHomePage() {
    return Stack(
      children: [
        _buildTitle(),
        _buildBoycottedProducts(),
        _buildBoycottedCompanies(),
      ],
    );
  }

  Widget _buildTitle() {
    return Positioned(
      top: 70,
      left: 80,
      child: Column(
        children: [
          Text(
            "Hand with hand to \naid Palestine",
            style: GoogleFonts.flamenco(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'يداً بيد لمساعدة فلسطين',
            style: GoogleFonts.flamenco(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoycottedProducts() {
    return FutureBuilder<List<Produit>>(
      future: fetchProduitsBoycott(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        List<Produit> produits = snapshot.data ?? [];
        return _buildCarousel(
          title:
              'Boycotted products :                              : المنتجات مقاطعة',
          items: produits,
          isProduct: true,
        );
      },
    );
  }

  Widget _buildBoycottedCompanies() {
    return FutureBuilder<List<Companie>>(
      future: fetchCompaniesBoycott(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        List<Companie> companies = snapshot.data ?? [];
        return _buildCarousel(
          title:
              'Boycotted companies :                              : الشركات المقاطعة',
          items: companies,
          isProduct: false,
        );
      },
    );
  }

  Widget _buildCarousel<T>(
      {required String title,
      required List<T> items,
      required bool isProduct}) {
    return Positioned(
      top: isProduct ? 260 : 460,
      left: 20,
      right: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.white)),
          SizedBox(height: 10),
          CarouselSlider(
            options: CarouselOptions(
              height: 150,
              enableInfiniteScroll: true,
              autoPlay: false,
              viewportFraction: 0.69,
            ),
            items: items.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Transform.rotate(
                    angle: 0.001,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.symmetric(horizontal: 7.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.memory(
                                isProduct
                                    ? (item as Produit).imageBytes
                                    : (item as Companie).imageBytes,
                                fit: BoxFit
                                    .cover, // Essayez aussi BoxFit.contain
                                width: MediaQuery.of(context).size.width *
                                    0.8, // Largeur de l'image
                                height: 150, // Hauteur de l'image
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
