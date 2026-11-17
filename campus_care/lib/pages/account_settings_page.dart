import 'package:flutter/material.dart';

class AccountSettingsPage extends StatefulWidget {
  final String currentName;
  final String currentNim;
  final String currentEmail;
  final String currentClass;

  const AccountSettingsPage({
    super.key,
    required this.currentName,
    required this.currentNim,
    required this.currentEmail,
    required this.currentClass,
  });

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  late TextEditingController _nameController;
  late TextEditingController _nimController;
  late TextEditingController _emailController;
  late TextEditingController _classController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _nimController = TextEditingController(text: widget.currentNim);
    _emailController = TextEditingController(text: widget.currentEmail);
    _classController = TextEditingController(text: widget.currentClass);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nimController.dispose();
    _emailController.dispose();
    _classController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Pengaturan Akun',
          style: TextStyle(
            color: Color(0xFF203A5F),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF203A5F)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informasi Pribadi',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF203A5F)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nimController,
              decoration: const InputDecoration(
                labelText: 'NIM',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge_outlined),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _classController,
              decoration: const InputDecoration(
                labelText: 'Prodi & Kelas',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.class_outlined),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Kembalikan data yang sudah diedit ke halaman Profil
                  Navigator.pop(context, {
                    'name': _nameController.text,
                    'nim': _nimController.text,
                    'email': _emailController.text,
                    'class': _classController.text,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D47A1),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Simpan Perubahan',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
