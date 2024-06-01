class Menu {
  final int id;
  final String namaMenu;
  final int hargaMenu;
  final String deskripsiMenu;
  final int stokMenu;
  final String shopNamaToko;

  Menu({
    required this.id,
    required this.namaMenu,
    required this.hargaMenu,
    required this.deskripsiMenu,
    required this.stokMenu,
    required this.shopNamaToko,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      namaMenu: json['namaMenu'],
      hargaMenu: json['hargaMenu'],
      deskripsiMenu: json['deskripsiMenu'],
      stokMenu: json['stokMenu'],
      shopNamaToko: json['shop_namaToko'],
    );
  }
}
