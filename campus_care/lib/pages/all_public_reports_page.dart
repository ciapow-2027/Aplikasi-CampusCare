import 'package:flutter/material.dart';

class AllPublicReportsPage extends StatelessWidget {
  final List<Map<String, dynamic>> publicReports;

  const AllPublicReportsPage({super.key, required this.publicReports});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Semua Laporan Kampus',
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
      body: publicReports.isEmpty
          ? const Center(
              child: Text(
                'Belum ada laporan publik dari mahasiswa lain.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: publicReports.length,
              itemBuilder: (context, index) {
                final report = publicReports[index];
                
                Color statusColor = Colors.blue;
                if (report['status'] == 'Menunggu') {
                  statusColor = Colors.orange;
                } else if (report['status'] == 'Selesai') {
                  statusColor = Colors.green;
                }

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(
                      report['title'] ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF203A5F)),
                    ),
                    subtitle: Text('${report['category'] ?? ''} • ${report['date'] ?? ''}'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        report['status'] ?? 'Diproses',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
