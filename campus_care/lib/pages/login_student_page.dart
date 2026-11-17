import 'student_home_page.dart'; 
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'register_page.dart';

class LoginStudentPage extends StatefulWidget {
  const LoginStudentPage({super.key});

  @override
  State<LoginStudentPage> createState() => _LoginStudentPageState();
}

class _LoginStudentPageState extends State<LoginStudentPage> {
bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Masuk sebagai Mahasiswa',
          style: TextStyle(fontSize: 12),
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Icon atau Logo 
            Image.asset(
              'assets/logo_campuscare.png',
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 8),
            const Text(
              'Silahkan login dengan akun mahasiswa yang kamu miliki',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: Color(0xFF203A5F),
              ),
            ),
            const SizedBox(height: 30),
            
            const TextField(
              decoration: InputDecoration(
                labelText: 'NIM',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
             TextField(
              obscureText: _isPasswordHidden,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordHidden = !_isPasswordHidden;
                    });
                  },
                  icon: Icon( _isPasswordHidden ?Icons.visibility_off_sharp :Icons.visibility ),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
                foregroundColor: const Color(0xFFFFFFFF),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StudentHomePage(),
                  ),
                );
              },
              child: const Text('Login', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Belum punya akun? ',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: 'Daftar di sini',
                        style: const TextStyle(
                          color: Color(0xFF0D47A1),
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ); 
  }
}
