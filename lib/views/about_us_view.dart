import 'package:flutter/material.dart';
import 'package:point_sale/widgets/app_drawer.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.black.withOpacity(0.1),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xFFE5E7EB), height: 1),
        ),
        leading: Builder(
          builder: (context) => Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.menu, color: Color(0xFF4A5565), size: 24),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        title: const Text(
          'About Us',
          style: TextStyle(
            fontFamily: 'Arimo',
            fontSize: 20,
            color: Color(0xFF4A5565),
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // App Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0F7FA), // Soft cyan bg
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text('🏪', style: TextStyle(fontSize: 36)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'PointSale',
                    style: TextStyle(
                      fontFamily: 'Arimo',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // About Our App section
                  const Text(
                    'About Our App',
                    style: TextStyle(
                      fontFamily: 'Arimo',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'POS Mobile App is a comprehensive point-of-sale solution designed for small to medium businesses. Our platform streamlines checkout, manages inventory, and tracks your daily performance effectively.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Color(0xFF4B5563),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Features section
                  const Text(
                    'Features',
                    style: TextStyle(
                      fontFamily: 'Arimo',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureItem(
                    icon: Icons.flash_on,
                    title: 'Fast & Efficient',
                    desc: 'Lightning-fast checkout and inventory management',
                  ),
                  _buildFeatureItem(
                    icon: Icons.security,
                    title: 'Secure',
                    desc: 'Bank-level security for your business data',
                  ),
                  _buildFeatureItem(
                    icon: Icons.touch_app,
                    title: 'Easy to Use',
                    desc: 'Intuitive interface designed for everyone',
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Contact section
                  const Text(
                    'Contact Us',
                    style: TextStyle(
                      fontFamily: 'Arimo',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildContactItem(icon: Icons.email_outlined, title: 'Email', value: 'support@posapp.com'),
                  _buildContactItem(icon: Icons.phone_outlined, title: 'Phone', value: '+1 (555) 123-4567'),
                  _buildContactItem(icon: Icons.language, title: 'Website', value: 'www.posapp.com'),
                  _buildContactItem(icon: Icons.location_on_outlined, title: 'Address', value: '123 Business St, Tech City, TC 12345'),
                  
                  const SizedBox(height: 32),
                  
                  // Follow Us section
                  const Text(
                    'Follow Us',
                    style: TextStyle(
                      fontFamily: 'Arimo',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildSocialButton(icon: Icons.facebook, label: 'Facebook'),
                      const SizedBox(width: 8),
                      _buildSocialButton(icon: Icons.telegram, label: 'Telegram'),
                      const SizedBox(width: 8),
                      _buildSocialButton(icon: Icons.business, label: 'LinkedIn'), // using business icon for linkedin as it's built-in
                    ],
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Footer section
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: const Text('Privacy Policy', style: TextStyle(color: Color(0xFF6B7280), fontWeight: FontWeight.w500)),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('•', style: TextStyle(color: Color(0xFF6B7280))),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Text('Terms of Service', style: TextStyle(color: Color(0xFF6B7280), fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text('© 2025 POS Mobile App. All rights reserved.', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13)),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({required IconData icon, required String title, required String desc}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F7FA).withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF00B8D0), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF111827)),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(color: Color(0xFF4B5563), fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({required IconData icon, required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.grey.shade600, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Color(0xFF6B7280)),
                ),
                Text(
                  value,
                  style: const TextStyle(color: Color(0xFF111827), fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({required IconData icon, required String label}) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(icon, size: 18, color: const Color(0xFF4B5563)),
        label: Text(label, style: const TextStyle(color: Color(0xFF4B5563), fontSize: 13, fontWeight: FontWeight.w600)),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          side: BorderSide(color: Colors.grey.shade300),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
