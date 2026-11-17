import 'package:flutter/material.dart';
import 'package:campus_care/pages/admin_report_page.dart';
import 'package:campus_care/pages/admin_profile_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _selectedIndex = 0;

  static const Color _navy = Color(0xFF203A5F);

  // Data dummy laporan terbaru (nanti bisa diganti data dari database/API)
  final List<Map<String, dynamic>> _laporanTerbaru = [
    {
      'judul': 'AC tidak dingin - Gedung A',
      'tanggal': '12 Mei 2026',
      'status': 'Diproses',
    },
    {
      'judul': 'Kursi Patah - Gedung B',
      'tanggal': '12 Mei 2026',
      'status': 'Menunggu',
    },
    {
      'judul': 'Proyektor Mati - Gedung A',
      'tanggal': '12 Mei 2026',
      'status': 'Diproses',
    },
    {
      'judul': 'Papan Tulis Pecah - Gedung C',
      'tanggal': '12 Mei 2026',
      'status': 'Selesai',
    },
    {
      'judul': 'Meja Rusak - Gedung C',
      'tanggal': '12 Mei 2026',
      'status': 'Diproses',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _buildBody(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: Colors.white,
        selectedItemColor: _navy,
        unselectedItemColor: _navy,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30),
            activeIcon: Icon(Icons.home, size: 30),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined, size: 30),
            activeIcon: Icon(Icons.description, size: 30),
            label: 'Laporan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 30),
            activeIcon: Icon(Icons.person, size: 30),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  // Isi halaman berdasarkan tab yang dipilih
  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildBeranda();
      case 1:
        return const AdminReportPage(); // <-- Sudah memanggil halaman laporan
      case 2:
        return const AdminProfilePage(); // <-- Sudah memanggil halaman profil
      default:
        return _buildBeranda();
    }
  }

  Widget _buildBeranda() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selamat Datang!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _navy,
            ),
          ),
          const SizedBox(height: 16),

          // Kartu ringkasan (2 x 2)
          Row(
            children: const [
              Expanded(
                child: _SummaryCard(
                  title: 'Total Laporan',
                  count: 12,
                  icon: Icons.description,
                  color: Color(0xFF757575),
                  backgroundColor: Color(0xFFE8F1FB),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _SummaryCard(
                  title: 'Menunggu',
                  count: 4,
                  icon: Icons.folder_open,
                  color: Color(0xFFEF6C00),
                  backgroundColor: Color(0xFFFFF3DC),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: _SummaryCard(
                  title: 'Diproses',
                  count: 5,
                  icon: Icons.find_in_page,
                  color: Color(0xFF1565C0),
                  backgroundColor: Color(0xFFD6ECFB),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _SummaryCard(
                  title: 'Selesai',
                  count: 3,
                  icon: Icons.task,
                  color: Color(0xFF2E7D32),
                  backgroundColor: Color(0xFFDDF5E0),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),
          const Text(
            'Laporan Terbaru',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _navy,
            ),
          ),
          const SizedBox(height: 12),

          // Daftar laporan terbaru
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _laporanTerbaru.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final laporan = _laporanTerbaru[index];
              return _LaporanItem(
                judul: laporan['judul']!,
                tanggal: laporan['tanggal']!,
                status: laporan['status']!,
              );
            },
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Widget kartu ringkasan (Total Laporan, Menunggu, Diproses, Selesai)
// ---------------------------------------------------------------------------
class _SummaryCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color color;
  final Color backgroundColor;

  const _SummaryCard({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Widget satu baris laporan terbaru
// ---------------------------------------------------------------------------
class _LaporanItem extends StatelessWidget {
  final String judul;
  final String tanggal;
  final String status;

  const _LaporanItem({
    required this.judul,
    required this.tanggal,
    required this.status,
  });

  // Warna label status
  Color get _statusBg {
    switch (status) {
      case 'Menunggu':
        return const Color(0xFFFFE0B2);
      case 'Selesai':
        return const Color(0xFFC8F0CC);
      default: // Diproses
        return const Color(0xFFBBDEFB);
    }
  }

  Color get _statusText {
    switch (status) {
      case 'Menunggu':
        return const Color(0xFFEF6C00);
      case 'Selesai':
        return const Color(0xFF2E7D32);
      default:
        return const Color(0xFF1565C0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Placeholder gambar laporan
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFF424242),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.image, color: Colors.white, size: 34),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                judul,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                tanggal,
                style: const TextStyle(fontSize: 11, color: Colors.black87),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: _statusBg,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            status,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: _statusText,
            ),
          ),
        ),
      ],
    );
  }
}
