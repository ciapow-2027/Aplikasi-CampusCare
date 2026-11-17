import 'package:flutter/material.dart';
 
class HistoryReportPage extends StatefulWidget {
  final VoidCallback? onBack;
 
  const HistoryReportPage({super.key, this.onBack});
 
  @override
  State<HistoryReportPage> createState() => _HistoryReportPageState();
}
 
class _HistoryReportPageState extends State<HistoryReportPage> {
  static const Color _navy = Color(0xFF203A5F);
 
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = 'Semua';
  String _searchQuery = '';
 
  // Data dummy laporan (nanti bisa diganti data dari database/API)
  final List<Map<String, String>> _semuaLaporan = [
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
 
  final List<String> _filters = ['Semua', 'Menunggu', 'Diproses', 'Selesai'];
 
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
 
  List<Map<String, String>> get _laporanTersaring {
    return _semuaLaporan.where((laporan) {
      final cocokStatus =
          _selectedStatus == 'Semua' || laporan['status'] == _selectedStatus;
      final cocokCari = laporan['judul']!
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      return cocokStatus && cocokCari;
    }).toList();
  }
 
  @override
  Widget build(BuildContext context) {
    final daftar = _laporanTersaring;
 
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: tombol kembali + judul
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 20, 0),
            child: Row(
              children: [
                IconButton(
                  onPressed: widget.onBack,
                  icon: const Icon(Icons.arrow_back_ios_new,
                      color: _navy, size: 22),
                ),
                const Text(
                  'Semua Laporan',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: _navy,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
 
          // Kolom pencarian
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                isDense: true,
                prefixIcon: const Icon(Icons.search, color: _navy),
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: _navy),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
 
          // Chip filter status
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: _filters.map((status) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: _FilterChip(
                    label: status,
                    selected: _selectedStatus == status,
                    onTap: () => setState(() => _selectedStatus = status),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
 
          // Daftar laporan
          Expanded(
            child: daftar.isEmpty
                ? const Center(child: Text('Laporan tidak ditemukan'))
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: daftar.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final laporan = daftar[index];
                      return _LaporanItem(
                        judul: laporan['judul']!,
                        tanggal: laporan['tanggal']!,
                        status: laporan['status']!,
                        onTap: () {
                          // TODO: buka halaman detail laporan
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
 
Color _statusBgColor(String status) {
  switch (status) {
    case 'Menunggu':
      return const Color(0xFFFFE0B2);
    case 'Selesai':
      return const Color(0xFFC8F0CC);
    case 'Diproses':
      return const Color(0xFFBBDEFB);
    default:
      return const Color(0xFF203A5F); // Semua
  }
}
 
Color _statusTextColor(String status) {
  switch (status) {
    case 'Menunggu':
      return const Color(0xFFEF6C00);
    case 'Selesai':
      return const Color(0xFF2E7D32);
    case 'Diproses':
      return const Color(0xFF1565C0);
    default:
      return Colors.white; // Semua
  }
}
 

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
 
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });
 
  @override
  Widget build(BuildContext context) {
    // Chip "Semua" selalu berwarna navy saat dipilih,
    // chip status lain berwarna sesuai statusnya
    final Color bg;
    final Color fg;
    if (label == 'Semua') {
      bg = selected ? const Color(0xFF203A5F) : const Color(0xFFE3E8F0);
      fg = selected ? Colors.white : const Color(0xFF203A5F);
    } else {
      bg = _statusBgColor(label);
      fg = _statusTextColor(label);
    }
 
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          // Chip status yang dipilih diberi garis tepi agar terlihat aktif
          border: Border.all(
            color: selected && label != 'Semua' ? fg : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: fg,
          ),
        ),
      ),
    );
  }
}
 

class _LaporanItem extends StatelessWidget {
  final String judul;
  final String tanggal;
  final String status;
  final VoidCallback? onTap;
 
  const _LaporanItem({
    required this.judul,
    required this.tanggal,
    required this.status,
    this.onTap,
  });
 
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
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
              color: _statusBgColor(status),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _statusTextColor(status),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
