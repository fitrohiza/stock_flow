import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormatUtils {
  static String formatEventDate(String? dateString, {bool useTime = true}) {
    if (dateString == null || dateString.isEmpty) {
      return "Date not available";
    }

    try {
      final dateTime = DateTime.parse(dateString);
      // Tentukan pola berdasarkan parameter useTime
      final pattern = useTime ? "d MMM yyyy, HH:mm" : "d MMM yyyy";
      return DateFormat(pattern, 'ID').format(dateTime);
    } catch (e) {
      debugPrint("⚠️ Gagal parsing tanggal: $e");
      return "Format tanggal salah";
    }
  }

  static String formatEventDateID(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return "Tanggal tidak tersedia";
    }
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat("d MMMM yyyy", "id_ID").format(dateTime);
    } catch (e) {
      return "Format tanggal salah";
    }
  }

  static String formatTimeOnly(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return "-";
    }
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat("HH:mm").format(dateTime);
    } catch (e) {
      return "-";
    }
  }
}
