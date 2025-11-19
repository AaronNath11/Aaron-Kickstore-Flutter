import 'package:flutter/material.dart';
import 'package:aaron_kickstore/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:aaron_kickstore/screens/menu.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  int _price = 0;
  String _description = "";
  String _thumbnail = "";
  String _category = "";
  bool _isFeatured = false;

  final List<String> _categories = [
    'Shoes',
    'Jersey',
    'Accessories',
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Form Tambah Produk")),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Product Name ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.shopping_bag_outlined),
                    hintText: "Nama Produk",
                    labelText: "Nama Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => setState(() => _name = value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nama produk tidak boleh kosong!";
                    }
                    if (value.length < 3) {
                      return "Nama produk minimal 3 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // === Price ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.attach_money_outlined),
                    hintText: "Harga Produk",
                    labelText: "Harga Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      setState(() => _price = int.tryParse(value) ?? 0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Harga produk tidak boleh kosong!";
                    }
                    final price = int.tryParse(value);
                    if (price == null) {
                      return "Harga harus berupa angka!";
                    }
                    if (price <= 0) {
                      return "Harga tidak boleh nol atau negatif!";
                    }
                    return null;
                  },
                ),
              ),

              // === Description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.description_outlined),
                    hintText: "Deskripsi Produk",
                    labelText: "Deskripsi Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => setState(() => _description = value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Deskripsi tidak boleh kosong!";
                    }
                    if (value.length < 10) {
                      return "Deskripsi minimal 10 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // === Thumbnail ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.image_outlined),
                    hintText: "URL Gambar Produk",
                    labelText: "Thumbnail (URL)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => setState(() => _thumbnail = value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "URL thumbnail tidak boleh kosong!";
                    }
                    final uri = Uri.tryParse(value);
                    if (uri == null || !uri.isAbsolute) {
                      return "Masukkan URL yang valid!";
                    }
                    return null;
                  },
                ),
              ),

              // === Category Dropdown ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.category_outlined),
                    labelText: "Kategori",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  value: _category.isNotEmpty ? _category : null,
                  items: _categories.map((cat) {
                    return DropdownMenuItem(
                      value: cat,
                      child: Text(cat),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _category = value!),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Kategori harus dipilih!" : null,
                ),
              ),

              // === Featured Switch ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title: const Text("Tampilkan sebagai Produk Unggulan"),
                  value: _isFeatured,
                  onChanged: (value) =>
                      setState(() => _isFeatured = value),
                ),
              ),

              // === Save Button ===
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(140, 45),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await request.postJson(
                          "http://localhost:8000/create-flutter/",
                          jsonEncode({
                            "name": _name,
                            "price": _price,
                            "description": _description,
                            "thumbnail": _thumbnail,
                            "category": _category,
                            "is_featured": _isFeatured,
                          }),
                        );

                        if (!mounted) return;

                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Product successfully saved!"),
                            ),
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Something went wrong, please try again."),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text("Simpan"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}