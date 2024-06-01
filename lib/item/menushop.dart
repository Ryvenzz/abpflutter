class Menu {
  final int id;
  final String namaMenu;
  final int hargaMenu;
  final int stokMenu;
  final String deskripsiMenu;
  final String namaToko;
  final String? imageMenu;
  final String? imageToko;

  Menu({
    required this.id,
    required this.namaMenu,
    required this.hargaMenu,
    required this.stokMenu,
    required this.deskripsiMenu,
    required this.namaToko,
    this.imageMenu,
    this.imageToko,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      namaMenu: json['namaMenu'],
      hargaMenu: json['hargaMenu'],
      stokMenu: json['stokMenu'],
      deskripsiMenu: json['deskripsiMenu'],
      namaToko: json['namaToko'],
      imageMenu: json['imageMenu'],
      imageToko: json['imageToko'],
    );
  }
}
