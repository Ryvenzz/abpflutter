class MenuCart {
  final int id;
  final String namaMenu;
  final int hargaMenu;
  final int stokMenu;
  final int quantity;

  MenuCart({
    required this.id,
    required this.namaMenu,
    required this.hargaMenu,
    required this.stokMenu,
    required this.quantity,
  });

  factory MenuCart.fromJson(Map<String, dynamic> json) {
    return MenuCart(
      id: json['Menu']['id'],
      namaMenu: json['Menu']['namaMenu'],
      hargaMenu: json['Menu']['hargaMenu'],
      stokMenu: json['Menu']['stokMenu'],
      quantity: json['quantity'],
    );
  }
}
