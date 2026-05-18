import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/scalp_result.dart';

class DailyTask {
  final String name;
  final String duration;
  final String time;
  bool isDone;

  DailyTask({
    required this.name,
    required this.duration,
    required this.time,
    this.isDone = false,
  });
}

class ProgressController extends GetxController {

  // ── SCAN HISTORY ──────────────────────────────────────────────
  final scanHistory = <ScanHistory>[
    ScanHistory(date: DateTime.now().subtract(const Duration(days: 1)),  score: 78, confidence: 0.91, change: 5),
    ScanHistory(date: DateTime.now().subtract(const Duration(days: 8)),  score: 73, confidence: 0.88, change: -3),
    ScanHistory(date: DateTime.now().subtract(const Duration(days: 15)), score: 76, confidence: 0.85, change: 2),
    ScanHistory(date: DateTime.now().subtract(const Duration(days: 22)), score: 74, confidence: 0.82, change: 0),
  ].obs;

  // ── DAILY TASKS ───────────────────────────────────────────────
  // Tugas default — akan di-override oleh tugas dari hasil scan
  final dailyTasks = <DailyTask>[
    DailyTask(name: 'Keramas dengan sampo antiketombe', duration: '5-10 menit', time: 'Pagi'),
    DailyTask(name: 'Pijat kulit kepala',               duration: '3-5 menit',  time: 'Pagi'),
    DailyTask(name: 'Hindari produk rambut berminyak',  duration: 'Sepanjang hari', time: 'Siang'),
    DailyTask(name: 'Minum air putih 8 gelas',          duration: 'Sepanjang hari', time: 'Siang'),
    DailyTask(name: 'Konsumsi makanan bergizi',         duration: 'Saat makan', time: 'Malam'),
    DailyTask(name: 'Istirahat cukup (7-8 jam)',        duration: '7-8 jam',    time: 'Malam'),
  ].obs;

  // Tanggal terakhir tugas di-reset
  String _lastResetDate = '';

  @override
  void onInit() {
    super.onInit();
    _loadAndCheckReset();
  }

  // ── LOAD + AUTO RESET ─────────────────────────────────────────
  Future<void> _loadAndCheckReset() async {
    final prefs = await SharedPreferences.getInstance();
    _lastResetDate = prefs.getString('last_reset_date') ?? '';

    final today = _dateKey(DateTime.now());

    if (_lastResetDate != today) {
      // Hari baru → reset semua tugas
      _resetAllTasks();
      await prefs.setString('last_reset_date', today);
    } else {
      // Hari sama → load status yang tersimpan
      _loadTaskStatus(prefs);
    }
  }

  void _resetAllTasks() {
    for (final task in dailyTasks) {
      task.isDone = false;
    }
    dailyTasks.refresh();
  }

  void _loadTaskStatus(SharedPreferences prefs) {
    for (int i = 0; i < dailyTasks.length; i++) {
      dailyTasks[i].isDone = prefs.getBool('task_$i') ?? false;
    }
    dailyTasks.refresh();
  }

  // ── TOGGLE TASK ───────────────────────────────────────────────
  Future<void> toggleTask(int index) async {
    dailyTasks[index].isDone = !dailyTasks[index].isDone;
    dailyTasks.refresh();

    // Simpan status
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('task_$index', dailyTasks[index].isDone);
  }

  // ── UPDATE TASKS DARI HASIL SCAN ──────────────────────────────
  // Dipanggil dari result setelah scan selesai
  void updateTasksFromDisease(String diseaseKey, String severity) {
    final tasks = _getTasksForDisease(diseaseKey, severity);
    dailyTasks.assignAll(tasks);
    // Simpan tanggal reset
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('last_reset_date', _dateKey(DateTime.now()));
    });
  }

  List<DailyTask> _getTasksForDisease(String key, String severity) {
    switch (key) {
      case 'alopecia':
        return [
          DailyTask(name: 'Pijat kulit kepala lembut',       duration: '5 menit',       time: 'Pagi'),
          DailyTask(name: 'Konsumsi suplemen biotin & zinc',  duration: 'Saat sarapan',  time: 'Pagi'),
          DailyTask(name: 'Gunakan sampo bebas sulfat',       duration: '5-10 menit',    time: 'Pagi'),
          DailyTask(name: 'Hindari styling rambut agresif',   duration: 'Sepanjang hari',time: 'Siang'),
          DailyTask(name: 'Kelola stres (meditasi/olahraga)', duration: '15-30 menit',   time: 'Sore'),
          DailyTask(name: 'Konsumsi protein & sayuran',       duration: 'Saat makan',    time: 'Malam'),
        ];

      case 'folliculitis':
        return [
          DailyTask(name: 'Kompres hangat area meradang',        duration: '10-15 menit',   time: 'Pagi'),
          DailyTask(name: 'Gunakan sampo antibakteri',           duration: '5-10 menit',    time: 'Pagi'),
          DailyTask(name: 'Jangan memencet benjolan',            duration: 'Sepanjang hari',time: 'Siang'),
          DailyTask(name: 'Ganti sarung bantal',                 duration: '5 menit',       time: 'Siang'),
          DailyTask(name: 'Hindari produk rambut baru',          duration: 'Sepanjang hari',time: 'Sore'),
          DailyTask(name: 'Kompres hangat sebelum tidur',        duration: '10 menit',      time: 'Malam'),
        ];

      case 'lice':
        return [
          DailyTask(name: 'Sisir dengan sisir serit',         duration: '10-15 menit',   time: 'Pagi'),
          DailyTask(name: 'Gunakan sampo antiparasit',        duration: '5-10 menit',    time: 'Pagi'),
          DailyTask(name: 'Cuci handuk & sarung bantal',      duration: '30 menit',      time: 'Siang'),
          DailyTask(name: 'Jangan berbagi sisir/topi',        duration: 'Sepanjang hari',time: 'Siang'),
          DailyTask(name: 'Periksa anggota keluarga',         duration: '10 menit',      time: 'Sore'),
          DailyTask(name: 'Sisir serit sebelum tidur',        duration: '10 menit',      time: 'Malam'),
        ];

      case 'seborrheic':
        return [
          DailyTask(name: 'Keramas dengan sampo antiketombe', duration: '5-10 menit',    time: 'Pagi'),
          DailyTask(name: 'Pijat kulit kepala',               duration: '3-5 menit',     time: 'Pagi'),
          DailyTask(name: 'Hindari produk rambut berminyak',  duration: 'Sepanjang hari',time: 'Siang'),
          DailyTask(name: 'Minum air putih 8 gelas',          duration: 'Sepanjang hari',time: 'Siang'),
          DailyTask(name: 'Konsumsi makanan bergizi',         duration: 'Saat makan',    time: 'Malam'),
          DailyTask(name: 'Istirahat cukup (7-8 jam)',        duration: '7-8 jam',       time: 'Malam'),
        ];

      case 'tinea':
        return [
          DailyTask(name: 'Gunakan sampo antijamur',          duration: '5-10 menit',    time: 'Pagi'),
          DailyTask(name: 'Keringkan rambut setelah keramas', duration: '5-10 menit',    time: 'Pagi'),
          DailyTask(name: 'Jangan berbagi sisir & handuk',    duration: 'Sepanjang hari',time: 'Siang'),
          DailyTask(name: 'Cuci topi & aksesoris rambut',     duration: '20 menit',      time: 'Siang'),
          DailyTask(name: 'Hindari area lembap berlebihan',   duration: 'Sepanjang hari',time: 'Sore'),
          DailyTask(name: 'Ganti sarung bantal',              duration: '5 menit',       time: 'Malam'),
        ];

      default:
        return dailyTasks.toList();
    }
  }

  // ── HELPER ────────────────────────────────────────────────────
  String _dateKey(DateTime date) =>
      '${date.year}-${date.month}-${date.day}';
}