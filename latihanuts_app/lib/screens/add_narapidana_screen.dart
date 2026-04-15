import 'package:flutter/material.dart';
import '../models/narapidana_model.dart';
import '../services/firebase_service.dart';

class AddNarapidanaScreen extends StatefulWidget {
  const AddNarapidanaScreen({super.key});

  @override
  State<AddNarapidanaScreen> createState() =>
      _AddNarapidanaScreenState();
}

class _AddNarapidanaScreenState
    extends State<AddNarapidanaScreen> {
  final FirebaseService service = FirebaseService();

  final namaController = TextEditingController();
  final umurController = TextEditingController();
  final kasusController = TextEditingController();

  String jk = "Laki-laki";

  @override
  void dispose() {
    namaController.dispose();
    umurController.dispose();
    kasusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Tambah Narapidana"),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔵 HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade900,
                    Colors.blue.shade700,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: const [
                  Icon(Icons.person_add,
                      color: Colors.white, size: 40),
                  SizedBox(width: 12),
                  Text(
                    "Input Data",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 📄 FORM
            _inputField(
              controller: namaController,
              label: "Nama",
              icon: Icons.person,
            ),

            _dropdownField(),

            _inputField(
              controller: umurController,
              label: "Umur",
              icon: Icons.calendar_today,
              isNumber: true,
            ),

            _inputField(
              controller: kasusController,
              label: "Kasus",
              icon: Icons.gavel,
            ),

            const SizedBox(height: 20),

            // 💾 BUTTON
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text("Simpan Data"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _simpanData,
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 INPUT FIELD
  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        keyboardType:
            isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue[900]),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // 🔹 DROPDOWN
  Widget _dropdownField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField<String>(
        value: jk,
        items: ["Laki-laki", "Perempuan"]
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            jk = value!;
          });
        },
        decoration: InputDecoration(
          labelText: "Jenis Kelamin",
          prefixIcon:
              Icon(Icons.people, color: Colors.blue[900]),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // 🔥 FUNCTION SIMPAN
  void _simpanData() async {
    if (namaController.text.isEmpty ||
        umurController.text.isEmpty ||
        kasusController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Semua field wajib diisi!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await service.tambahData(
      Narapidana(
        id: '',
        nama: namaController.text,
        jk: jk,
        umur: umurController.text,
        kasus: kasusController.text,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Data berhasil ditambahkan!"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }
}