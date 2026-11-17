import 'package:flutter/material.dart';
import 'package:campus_care/pages/account_settings_page.dart';
import 'package:campus_care/pages/login_student_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
String _name = 'Puput Cuking'; //[cite: 4]
String _nim = '73050250002'; //[cite: 4]
String _email = 'puput2020@gmail.com'; //[cite: 4]
String _classInfo = 'Teknologi Informasi • Kelas 3A'; //[cite: 4]

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Profil Saya',
          style: TextStyle(
            color: Color(0xFF203A5F),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFF0D47A1),
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Puput Cuking',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF203A5F)),
                  ),
                  SizedBox(height: 4),
                  Text('NIM: 73050250002', style: TextStyle(fontSize: 14, color: Colors.grey)),
                  SizedBox(height: 4),
                  Text('Teknologi Informasi • Kelas 3A', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Informasi Akademik', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF203A5F))),
                  const Divider(height: 20),
                  _buildInfoRow(Icons.email_outlined, 'Email', 'puput2020@gmail.com'),
                  const SizedBox(height: 12),
                  _buildInfoRow(Icons.school_outlined, 'Fakultas', 'Sains dan Teknologi'),
                  const SizedBox(height: 12),
                  _buildInfoRow(Icons.location_city_outlined, 'Kampus', 'UIN Salatiga'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings_outlined, color: Color(0xFF0D47A1)),
                    title: const Text('Pengaturan Akun'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                    onTap: () async {
                      final updatedData = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccountSettingsPage(
                            currentName: _name,
                            currentNim: _nim,
                            currentEmail: _email,
                            currentClass: _classInfo,
                          ),
                        ),
                      );
                  if (updatedData != null && updatedData is Map<String, String>) {
                        setState(() {
                          _name = updatedData['name'] ?? _name;
                          _nim = updatedData['nim'] ?? _nim;
                          _email = updatedData['email'] ?? _email;
                          _classInfo = updatedData['class'] ?? _classInfo;
                        });
                      }
                    },
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      'Keluar',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      // Hapus semua halaman sebelumnya dan kembali ke halaman Login
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginStudentPage()),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 12),
        Text('$label: ', style: const TextStyle(fontSize: 13, color: Colors.grey)),
        Expanded(
          child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500), textAlign: TextAlign.end),
        ),
      ],
    );
  }
}
