import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';


void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherApp',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController _searchController = TextEditingController();

  String searchText = '';
  String geolocation = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    // libérer les ressources et éviter les leaks lorsqu'un widget est supprimé
    // car des objects peuvent encore écouter des événements en arrière-plan
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildTabContent(String tabName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          tabName,
          style: TextStyle(fontSize: 24),
        ),
        Text(
          searchText,
          style: TextStyle(fontSize: 24),
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Rechercher...',
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            IconButton(
              icon: Icon(Icons.location_on),
              onPressed: () {},
            ),
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabContent('Currently'),
          _buildTabContent('Today'),
          _buildTabContent('Weekly'),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.cloud_outlined), text: 'Currently'),
            Tab(icon: Icon(Icons.today), text: 'Today'),
            Tab(icon: Icon(Icons.calendar_today), text: 'Weekly'),
          ],
        ),
      ),
    );
  }
}
