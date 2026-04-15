import 'package:flutter/material.dart';
import '../models/narapidana_model.dart';

class NarapidanaCard extends StatelessWidget {
  final Narapidana data;

  const NarapidanaCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade800,
            Colors.blue.shade600,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
          )
        ],
      ),
      child: Row(
        children: [
          // 👤 ICON
          const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Colors.blue),
          ),

          const SizedBox(width: 12),

          // 📄 DATA
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.nama,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${data.jk} • ${data.umur} tahun",
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 4),
                Text(
                  "Kasus: ${data.kasus}",
                  style: const TextStyle(
                    color: Colors.yellowAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // ⚖️ ICON KASUS
          const Icon(Icons.gavel, color: Colors.white)
        ],
      ),
    );
  }
}