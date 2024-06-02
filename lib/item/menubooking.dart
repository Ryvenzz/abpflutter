import 'dart:convert';

class MenuBooking {
  final int id;
  final String namaMenu;
  final int hargaMenu;
  final int quantity;

  MenuBooking({
    required this.id,
    required this.namaMenu,
    required this.hargaMenu,
    required this.quantity,
  });

  factory MenuBooking.fromJson(Map<String, dynamic> json) {
    return MenuBooking(
      id: json['id'],
      namaMenu: json['namaMenu'],
      hargaMenu: json['hargaMenu'],
      quantity: json['quantity'],
    );
  }
}
