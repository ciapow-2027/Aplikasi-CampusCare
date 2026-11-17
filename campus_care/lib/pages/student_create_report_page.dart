import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

// Model data laporan (bisa ditaruh di sini atau dipisah ke file model)
class ReportItemModel {
  final String title;
  final String date;
  final String status;
  final Color statusColor;
  final Color backgroundColor;

  ReportItemModel({
    required this.title,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.backgroundColor,
  });
}

class StudentCreateReportPage extends StatefulWidget {
  const StudentCreateReportPage({super.key});

  @override
  State<StudentCreateReportPage> createState() => _StudentCreateReportPageState();
}

class _StudentCreateReportPageState extends State<CreateReportPage> {
  // Controller untuk menangkap input teks dari user
  final TextEditingController _fasilitasController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _ruanganController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  String _selectedKategori = 'Kerusakan Ringan'; // Contoh pilihan kategori
   PlatformFile? _pickedFile; // Menyimpan info file yang dipilih
 Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'], // Batasi format file
      );

      if (result != null) {
        setState(() {
          _pickedFile = result.files.first;
        });
      } else {
        // User membatalkan pilihan file
        debugPrint("Pemilihan file dibatalkan.");
      }
    } catch (e) {
      debugPrint("Gagal memilih file: $e");
    }
  }

  // Fungsi untuk mengunggah File

  @override
  void dispose() {
    _fasilitasController.dispose();
    _lokasiController.dispose();
    _ruanganController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Buat Laporan',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0D47A1),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Upload Foto Kerusakan
            const Text(
              'Upload Foto Kerusakan',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _pickFile(),
              child: Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.camera_alt_outlined, size: 36, color: Colors.grey),
                    const SizedBox(height: 8),
                    Text(
                      _pickedFile?.name ?? 'Tap untuk menambahkan foto',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Input Nama Fasilitas
            _buildTextField(
              label: 'Nama Fasilitas *',
              hint: 'Contoh: AC, Kursi, Proyektor',
              controller: _fasilitasController,
            ),
            const SizedBox(height: 14),

            // Input Lokasi
            _buildTextField(
              label: 'Lokasi *',
              hint: 'Contoh: Gedung A',
              controller: _lokasiController,
            ),
            const SizedBox(height: 14),

            // Input Nomor Ruangan
            _buildTextField(
              label: 'Nomor Ruangan *',
              hint: 'Contoh: Ruang 201',
              controller: _ruanganController,
            ),
            const SizedBox(height: 14),

            // Dropdown Kategori Kerusakan
            const Text(
              'Kategori Kerusakan *',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedKategori,
                  isExpanded: true,
                  items: <String>['Kerusakan Ringan', 'Kerusakan Sedang', 'Kerusakan Berat']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(fontSize: 14)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedKategori = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Input Deskripsi Kerusakan
            _buildTextField(
              label: 'Deskripsi Kerusakan *',
              hint: 'Jelaskan detail kerusakan...',
              controller: _deskripsiController,
              maxLines: 3,
            ),
            const SizedBox(height: 28),

            // Tombol Kirim Laporan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D47A1), // Warna Biru Utama
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Validasi sederhana agar form tidak kosong
                  if (_fasilitasController.text.isEmpty || _lokasiController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Nama fasilitas dan lokasi wajib diisi!')),
                    );
                    return;
                  }

                  // Membuat objek data laporan baru berdasarkan input user
                  final laporanBaru = ReportItemModel(
                    title: '${_fasilitasController.text} - ${_lokasiController.text}',
                    date: '13 Mei 2026', // Atau sesuaikan format tanggal otomatis
                    status: 'Diproses',
                    statusColor: Colors.blue,
                    backgroundColor: Color(0xFFD6ECFB),
                  );

                  // Mengirim data kembali ke halaman Dashboard dan menutup halaman ini
                  Navigator.pop(context, laporanBaru);
                },
                child: const Text(
                  'Kirim Laporan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget helper untuk membuat TextField agar kodenya lebih rapi
  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }
}
