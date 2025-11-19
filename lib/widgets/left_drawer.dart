import 'package:flutter/material.dart';
import 'package:aaron_kickstore/screens/menu.dart';
import 'package:aaron_kickstore/screens/productslist_form.dart';
import 'package:aaron_kickstore/screens/products_entry_list.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:aaron_kickstore/screens/login.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.purple,
            ),
            child: Column(
              children: [
                Text(
                  'Aaron Kickstore',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Belanja perlengkapan sepak bola favoritmu di sini!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),

          // === Halaman Utama ===
          ListTile(
            leading: const Icon(Icons.home_outlined, color: Colors.purple),
            title: const Text('Halaman Utama',
                style: TextStyle(color: Colors.purple)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),

          // === Tambah Produk ===
          ListTile(
            leading: const Icon(Icons.add_box_outlined, color: Colors.purple),
            title:
                const Text('Tambah Produk', style: TextStyle(color: Colors.purple)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductFormPage(),
                ),
              );
            },
          ),

          // === Product List ===
          ListTile(
            leading: const Icon(Icons.shopping_bag, color: Colors.purple),
            title:
                const Text('Product List', style: TextStyle(color: Colors.purple)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductEntryListPage()),
              );
            },
          ),

          // === Logout ===
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.purple),
            title: const Text('Logout', style: TextStyle(color: Colors.purple)),
            onTap: () async {
              final request = context.read<CookieRequest>();
              await request.logout("http://localhost:8000/auth/logout/");

              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
