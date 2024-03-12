import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router_page_demo/routes/app_routes.dart';

class DashboardScreen extends StatefulWidget {
  final Widget child;
  final String title;
  const DashboardScreen({super.key, required this.child, required this.title});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _BottomNavigationBar(
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        onTap: (int) {
          if (kIsWeb) {
            AppRoutes.router.goNamed(_getScreenName(int));
          } else {
            AppRoutes.router.goNamed(_getScreenName(int));
          }
          setState(() {
            currentIndex = int;
          });
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.title,
          style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(minimum: const EdgeInsets.all(16), child: widget.child),
    );
  }

  String _getScreenName(int index) {
    switch (index) {
      case 0:
        return AppRoutes.home;
      case 1:
        return AppRoutes.settings;
      case 2:
        return AppRoutes.profile;
      default:
        return AppRoutes.home;
    }
  }
}

class _BottomNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final Function(int)? onTap;
  final int? currentIndex;
  const _BottomNavigationBar(
      {required this.items, this.onTap, this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: items,
      onTap: onTap,
      currentIndex: currentIndex ?? 0,
    );
  }
}
