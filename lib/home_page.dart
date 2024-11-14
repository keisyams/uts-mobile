import 'package:flutter/material.dart';
import 'package:lagi/bmi.dart';
import 'package:lagi/calculator.dart';
import 'package:lagi/splashcreen.dart';
import 'package:lagi/todolist.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<MenuCard> _menuItems = [
    MenuCard(
      title: "BMI Calculator",
      icon: Icons.monitor_weight_outlined,
      color: Colors.blue,
      route: BMI(),
      description: "Calculate your Body Mass Index",
    ),
    MenuCard(
      title: "To-Do List",
      icon: Icons.checklist_rounded,
      color: Colors.green,
      route: const Todo(),
      description: "Manage your daily tasks",
    ),
    MenuCard(
      title: "Calculator",
      icon: Icons.calculate_outlined,
      color: Colors.orange,
      route: const Calculator(),
      description: "Perform quick calculations",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Splashscreen'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade100,
              Colors.purple.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom App Bar
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          icon: const Icon(Icons.apps_rounded, size: 30),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          color: Colors.black,
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      "Welcome Key!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Menu Description
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Menu Cards
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: _menuItems.length,
                    itemBuilder: (context, index) {
                      return _buildMenuCard(_menuItems[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(MenuCard menu) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => menu.route),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: menu.color.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Background Design
              Positioned(
                right: -20,
                top: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: menu.color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: menu.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        menu.icon,
                        color: menu.color,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      menu.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      menu.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuCard {
  final String title;
  final IconData icon;
  final Color color;
  final Widget route;
  final String description;

  MenuCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
    required this.description,
  });
}
