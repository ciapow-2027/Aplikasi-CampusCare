import 'package:flutter/material.dart';
import 'package:campus_care/pages/student_create_report_page.dart';
import 'package:campus_care/pages/all_public_reports_page.dart';
import 'package:campus_care/pages/profile_student_page.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  int _currentIndex = 0;

  final List<Map<String, String>> _myReports = [
    {'title': 'AC tidak dingin - Gedung A', 'category': 'Fasilitas Kelas', 'date': '12 Mei 2026', 'status': 'Diproses'},
    {'title': 'Kursi Patah - Gedung B', 'category': 'Inventaris', 'date': '10 Mei 2026', 'status': 'Menunggu'},
    {'title': 'Papan Tulis Pecah - Gedung C', 'category': 'Fasilitas Kelas', 'date': '5 Mei 2026', 'status': 'Selesai'},
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      BerandaContent(
        reports: _myReports,
        onReportAdded: (newReport) {
          setState(() {
            _myReports.insert(0, newReport);
          });
        },
      ),
      HistoryReportPage(reports: _myReports),
      const ProfilePage(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF0D47A1),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Laporan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}


class BerandaContent extends StatelessWidget {
  final List<Map<String, String>> reports;
  final Function(Map<String, String>) onReportAdded;

  const BerandaContent({
    super.key,
    required this.reports,
    required this.onReportAdded,
  });

  @override
  Widget build(BuildContext context) {
    int totalLaporan = reports.length;
    int totalDiproses = reports.where((item) => item['status'] == 'Diproses').length;
    int totalSelesai = reports.where((item) => item['status'] == 'Selesai').length;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryCard('Laporan', totalLaporan.toString(), Colors.blue),
                _buildSummaryCard('Diproses', totalDiproses.toString(), Colors.orange),
                _buildSummaryCard('Selesai', totalSelesai.toString(), Colors.green),
              ],
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final newReport = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateReportPage()),
                  );

                  if (newReport != null && newReport is Map<String, String>) {
                    onReportAdded(newReport);
                  }
                },
                icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                label: const Text('Buat Laporan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D47A1),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Laporan Terbaru', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF203A5F))),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllPublicReportsPage(publicReports: reports)),
                    );
                  },
                  child: const Text('Lihat semua >', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            const SizedBox(height: 16),

            reports.isEmpty
                ? const Center(child: Padding(padding: EdgeInsets.all(32.0), child: Text('Belum ada riwayat laporan', style: TextStyle(color: Colors.grey))))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reports.length > 3 ? 3 : reports.length,
                    itemBuilder: (context, index) {
                      final item = reports[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(item['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('${item['category']} • ${item['date']}'),
                          trailing: Text(item['status'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String count, Color color) {
    return Container(
      width: 105,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        children: [
          Text(count, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87)),
        ],
      ),
    );
  }
}

// HALAMAN TAB RIWAYAT LAPORAN
class HistoryReportPage extends StatelessWidget {
  final List<Map<String, String>> reports;
  const HistoryReportPage({super.key, required this.reports});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Laporan', style: TextStyle(color: Color(0xFF203A5F), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: reports.isEmpty
          ? const Center(child: Text('Belum ada laporan'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final item = reports[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(item['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${item['category']} • ${item['date']}'),
                    trailing: Text(item['status'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                  ),
                );
              },
            ),
    );
  }
}
