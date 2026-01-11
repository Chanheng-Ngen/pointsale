import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header Section with Gradient
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF4A5565),
                  Color(0xFF00B8DB),
                ],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Menu Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Menu',
                        style: TextStyle(
                          fontFamily: 'Arimo',
                          fontSize: 20,
                          color: Colors.white,
                          height: 1.4,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // User Profile Card
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Admin User',
                                style: TextStyle(
                                  fontFamily: 'Arimo',
                                  fontSize: 16,
                                  color: Colors.white,
                                  height: 1.5,
                                ),
                              ),
                              Text(
                                'admin@pos.com',
                                style: TextStyle(
                                  fontFamily: 'Arimo',
                                  fontSize: 14,
                                  color: Colors.white70,
                                  height: 1.43,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Navigation Section
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              children: [
                // Navigation Label
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    'NAVIGATION',
                    style: TextStyle(
                      fontFamily: 'Arimo',
                      fontSize: 12,
                      color: Color(0xFF6A7282),
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                
                // Navigation Items
                _buildMenuItem(
                  icon: Icons.home,
                  label: 'Home',
                  isActive: true,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.shopping_cart,
                  label: 'Checkout',
                  onTap: () {
                    // Handle Checkout navigation
                    Navigator.pop(context);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.receipt_long,
                  label: 'Orders',
                  onTap: () {
                    // Handle Orders navigation
                    Navigator.pop(context);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.inventory_2,
                  label: 'Products',
                  onTap: () {
                    // Handle Products navigation
                    Navigator.pop(context);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.inventory,
                  label: 'Stock Management',
                  onTap: () {
                    // Handle Stock Management navigation
                    Navigator.pop(context);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.swap_horiz,
                  label: 'Transactions',
                  onTap: () {
                    // Handle Transactions navigation
                    Navigator.pop(context);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.bar_chart,
                  label: 'Analytics',
                  onTap: () {
                    // Handle Analytics navigation
                    Navigator.pop(context);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.settings,
                  label: 'Settings',
                  onTap: () {
                    // Handle Settings navigation
                    Navigator.pop(context);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.info,
                  label: 'About Us',
                  onTap: () {
                    // Handle About Us navigation
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          
          // Sign Out Button
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xFFE5E7EB),
                  width: 1.15,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
            child: InkWell(
              onTap: () {
                // Handle sign out
                Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(14),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout,
                      color: Color(0xFFE7000B),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Sign Out',
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 16,
                        color: Color(0xFFE7000B),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF00B8DB).withOpacity(0.16) : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Icon(
          icon,
          size: 20,
          color: const Color(0xFF4A5565),
        ),
        title: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Arimo',
            fontSize: 16,
            color: Color(0xFF364153),
            height: 1.5,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          size: 16,
          color: Color(0xFF4A5565),
        ),
        onTap: onTap,
      ),
    );
  }
}
