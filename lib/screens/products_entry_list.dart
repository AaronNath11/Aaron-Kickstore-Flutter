import 'package:flutter/material.dart';
import 'package:aaron_kickstore/models/products_entry.dart';
import 'package:aaron_kickstore/widgets/left_drawer.dart';
import 'package:aaron_kickstore/screens/products_detail.dart';
import 'package:aaron_kickstore/widgets/products_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:aaron_kickstore/screens/products_detail.dart';

class ProductEntryListPage extends StatefulWidget {
  final bool showMine;

  const ProductEntryListPage({super.key, this.showMine = false});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  Future<List<ProductEntry>> fetchProducts(CookieRequest request) async {
    final response = await request.get('http://localhost:8000/json/');

    var data = response;
    List<ProductEntry> listProducts = [];
    for (var d in data) {
      if (d != null) {
        listProducts.add(ProductEntry.fromJson(d));
      }
    }

    final currentUserId = request.jsonData['id'];

    if (widget.showMine) {
      return listProducts.where((p) => p.userId == currentUserId).toList();
    }

    return listProducts;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.showMine ? 'My Products' : 'Products Entry List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            tooltip: widget.showMine ? "Show All Products" : "Show My Products",
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductEntryListPage(
                    showMine: !widget.showMine,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProducts(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    'There are no products in Aaron Kickstore yet.',
                    style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => ProductEntryCard(
                  product: snapshot.data![index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          product: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}

