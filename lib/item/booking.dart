class Booking {
  final int id;
  final String metodePembayaran;
  final int bookingId;
  final String statusLengkap;
  final String userId;
  final int? nomorMeja;
  final String? jamAmbil;
  final int totalHarga;
  final String? statusAmbil;
  final String statusSelesai;
  final int bookingUserId;

  Booking({
    required this.id,
    required this.metodePembayaran,
    required this.bookingId,
    required this.statusLengkap,
    required this.userId,
    required this.nomorMeja,
    required this.jamAmbil,
    required this.totalHarga,
    required this.statusAmbil,
    required this.statusSelesai,
    required this.bookingUserId,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      metodePembayaran: json['metodePembayaran'],
      bookingId: json['booking_id'],
      statusLengkap: json['statusLengkap'],
      userId: json['user_id'],
      nomorMeja: json['nomorMeja'],
      jamAmbil: json['jamAmbil'],
      totalHarga: json['totalHarga'],
      statusAmbil: json['statusAmbil'],
      statusSelesai: json['statusSelesai'],
      bookingUserId: json['booking_user_id'],
    );
  }
}