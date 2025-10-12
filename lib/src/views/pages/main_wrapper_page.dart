import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainWrapperPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainWrapperPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomAppBar(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildNavItem(context, icon: Icons.home, label: 'Home', index: 0),
            _buildNavItem(
              context,
              icon: Icons.analytics,
              label: 'Analisis',
              index: 1,
            ),
            _buildStartSessionButton(context), 
            _buildNavItem(
              context,
              icon: Icons.list_alt,
              label: 'Faktor',
              index: 2,
            ),
            _buildNavItem(
              context,
              icon: Icons.person,
              label: 'Profil',
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartSessionButton(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/active-session'),
      customBorder: const CircleBorder(),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.nights_stay_outlined,
            color: Colors.white,
            size: 32, 
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = navigationShell.currentIndex == index;
    final color = isSelected ? Theme.of(context).primaryColor : Colors.grey;

    return Expanded(
      child: InkWell(
        onTap: () => navigationShell.goBranch(index),
        borderRadius: BorderRadius.circular(
          20,
        ), // Memberi efek ripple yang lebih baik
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24), // Ukuran ikon sedikit dikurangi
            const SizedBox(height: 2), // Jarak antara ikon dan teks dikurangi
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11, // Ukuran font sedikit dikurangi
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
