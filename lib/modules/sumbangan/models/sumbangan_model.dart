import 'dart:convert';
import 'dart:core';

class Donasi {
  final String donatur;
  final String date;
  final String jenis;
  final String berat;
  final int poin;
  final String bank_sampah;


  Donasi({
    required this.donatur,
    required this.date,
    required this.jenis,
    required this.berat,
    required this.poin,
    required this.bank_sampah,
  });

  Map<String, dynamic> toMap() {
    return {
      'donatur': donatur,
      'date': date,
      'jenis': jenis,
      'berat': berat,
      'poin': poin,
      'bank_sampah': bank_sampah,
    };
  }

  factory Donasi.fromJson(Map<String, dynamic> map) {
    return Donasi(
      donatur: map['donatur'],
      date: map['date'],
      jenis: map['jenis'],
      berat: map['berat'],
      poin: map['poin'],
      bank_sampah: map['bank_sampah'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Donasi(donatur: $donatur, date: $date, jenis: $jenis, berat: $berat, poin: $poin, bank_sampah: $bank_sampah)';
  }
}
