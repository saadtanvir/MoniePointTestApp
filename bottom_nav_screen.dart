import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moniepoint_test_app/home_screen.dart';
import 'package:moniepoint_test_app/map_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 2;
  final screens = [
    const MapScreen(),
    const SizedBox(),
    const HomeScreen(),
    const SizedBox(),
    const SizedBox(),
  ];
  late AnimationController animationController;
  late Animation<Offset> offset;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    offset = Tween<Offset>(begin: const Offset(0.0, 2.0), end: Offset.zero)
        .animate(animationController);
    Future.delayed(const Duration(seconds: 2), () {
      animationController.forward();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreen(selectedIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SlideTransition(
        position: offset,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(45),
            ),
            child: BottomNavigationBar(
              currentIndex: selectedIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black87,
              selectedIconTheme: const IconThemeData(color: Colors.white),
              unselectedIconTheme: const IconThemeData(color: Colors.white),
              selectedFontSize: 0.0,
              unselectedFontSize: 0.0,
              onTap: (index) {
                if (index == 1 || index == 3 || index == 4) return;
                setState(() {
                  selectedIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: _iconBuilder(
                    Icons.search,
                    selectedIndex == 0 ? Colors.orange : Colors.black,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _iconBuilder(
                    Icons.business,
                    selectedIndex == 1 ? Colors.orange : Colors.black,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _iconBuilder(
                    Icons.home,
                    selectedIndex == 2 ? Colors.orange : Colors.black,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _iconBuilder(
                    Icons.favorite,
                    selectedIndex == 1 ? Colors.orange : Colors.black,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _iconBuilder(
                    Icons.person,
                    selectedIndex == 1 ? Colors.orange : Colors.black,
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getScreen(int index) {
    {
      return screens[index];
    }
  }

  Widget _iconBuilder(IconData icon, Color? backgroundColor) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Icon(icon),
      ),
    );
  }
}
