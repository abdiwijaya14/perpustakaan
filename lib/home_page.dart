import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'insert.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  List<Map<String, dynamic>> Buku = [];

  @override
  void initState() {
    super.initState();
    fetchBuku();
  }

  Future<void> fetchBuku() async {
    final response = await Supabase.instance.client.from('Buku').select();

    setState(() {
      Buku = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA), // Light background
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent, // Modern AppBar color
        title: const Text(
          'Perpustakaan',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: fetchBuku,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Buku.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: Buku.length,
                itemBuilder: (context, index) {
                  final dataBuku = Buku[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFE0B2), Color(0xFFFFCC80)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: const Icon(
                        Icons.book_rounded,
                        size: 40,
                        color: Colors.brown,
                      ),
                      title: Text(
                        dataBuku['title'] ?? 'No Title',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          color: Colors.brown,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            'Penulis: ${dataBuku['author'] ?? 'Unknown'}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.brown,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            dataBuku['description'] ?? 'No Description',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.brown,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddBookPage(),
            ),
          );
        },
        backgroundColor: Colors.deepOrangeAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
