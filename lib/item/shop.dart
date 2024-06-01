class Shop {
  final int id;
  final String namaToko;
  final String nomorToko;
  final String lokasiToko;
  final int userId;
  final String userFullName;
  final String? image;

  Shop({
    required this.id,
    required this.namaToko,
    required this.nomorToko,
    required this.lokasiToko,
    required this.userId,
    required this.userFullName,
    this.image,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      namaToko: json['namaToko'],
      nomorToko: json['nomorToko'],
      lokasiToko: json['lokasiToko'],
      userId: json['user_id'],
      userFullName: json['user_fullName'],
      image: json['image'],
    );
  }
}
