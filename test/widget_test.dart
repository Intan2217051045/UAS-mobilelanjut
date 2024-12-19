// File: widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// Pastikan path file utama sudah benar

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Bangun aplikasi kita dan memicu frame pertama.
    await tester.pumpWidget(MyApp()); // Hapus 'const' jika MyApp tidak menggunakan const constructor

    // Verifikasi bahwa counter dimulai pada nilai 0.
    expect(find.text('0'), findsOneWidget); // Verifikasi bahwa angka 0 ada
    expect(find.text('1'), findsNothing); // Verifikasi bahwa angka 1 belum ada

    // Ketuk ikon '+' dan memicu frame berikutnya.
    await tester.tap(find.byIcon(Icons.add)); // Temukan ikon dan lakukan tap
    await tester.pump(); // Memicu frame berikutnya untuk memperbarui UI

    // Verifikasi bahwa nilai counter meningkat menjadi 1.
    expect(find.text('0'), findsNothing); // Verifikasi bahwa angka 0 tidak ada
    expect(find.text('1'), findsOneWidget); // Verifikasi bahwa angka 1 ada
  });
}