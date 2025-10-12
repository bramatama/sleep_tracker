// models/dummy_data.dart

// Ini adalah kelas sederhana untuk merepresentasikan data kita.
// Nantinya, ini akan digantikan oleh kelas Model dari Drift.

class DummyUser {
  final String name;
  DummyUser({required this.name});
}

class DummyFactor {
  final String name;
  final String icon; // emoji icon
  DummyFactor({required this.name, required this.icon});
}

class DummySleepSession {
  final DateTime startTime;
  final DateTime endTime;
  final int quality; // 1-5
  final List<DummyFactor> factors;

  Duration get duration => endTime.difference(startTime);

  DummySleepSession({
    required this.startTime,
    required this.endTime,
    required this.quality,
    required this.factors,
  });
}

// --- DATABASE DUMMY ---

final dummyUser = DummyUser(name: "Pengguna");

final allFactors = [
  DummyFactor(name: "Minum Kopi", icon: "☕"),
  DummyFactor(name: "Olahraga", icon: "🏋️"),
  DummyFactor(name: "Makan Berat", icon: "🍔"),
  DummyFactor(name: "Stres", icon: "😥"),
  DummyFactor(name: "Layar HP", icon: "📱"),
  DummyFactor(name: "Kerja Lembur", icon: "💻"),
];

final lastSleepSession = DummySleepSession(
  startTime: DateTime.now().subtract(const Duration(hours: 9, minutes: 15)),
  endTime: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
  quality: 4,
  factors: [allFactors[0], allFactors[4]],
);

final weeklySleepData = [
  6.5, // Senin
  7.0, // Selasa
  8.0, // Rabu
  6.0, // Kamis
  7.5, // Jumat
  9.0, // Sabtu
  lastSleepSession.duration.inHours.toDouble(), // Minggu (hari ini)
];

final factorAnalysis = [
  {
    "factor": allFactors[0], // Kopi
    "avgWith": "6j 15m",
    "avgWithout": "7j 30m",
    "insight": "Tidur Anda 1j 15m lebih singkat.",
    "isNegative": true,
  },
  {
    "factor": allFactors[1], // Olahraga
    "avgWith": "7j 45m",
    "avgWithout": "7j 5m",
    "insight": "Tidur Anda 40m lebih lama.",
    "isNegative": false,
  },
];
