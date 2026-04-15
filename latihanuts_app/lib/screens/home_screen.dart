import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../models/narapidana_model.dart';
import '../widgets/narapidana_card.dart';
import 'add_narapidana_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = FirebaseService();

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Lapas App"),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),

      body: Column(
        children: [
          // 🔵 HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue[900],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Row(
              children: const [
                Icon(Icons.security, color: Colors.white, size: 40),
                SizedBox(width: 12),
                Text(
                  "Data Narapidana",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 📋 LIST DATA
          Expanded(
            child: StreamBuilder<List<Narapidana>>(
              stream: service.getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("Belum ada data"),
                  );
                }

                final data = snapshot.data!;

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return NarapidanaCard(data: data[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),

      // ➕ BUTTON TAMBAH
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddNarapidanaScreen(),
            ),
          );
        },
      ),
    );
  }
}