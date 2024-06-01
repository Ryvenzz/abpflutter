class Product {
  int id;
  String namaMenu;
  double hargaMenu;
  String deskripsiMenu;
  int stokMenu;
  int shopId;
  String shopNamaToko;
  String? imageShop;
  String? imageMenu;

  Product({
    required this.id,
    required this.namaMenu,
    required this.hargaMenu,
    required this.deskripsiMenu,
    required this.stokMenu,
    required this.shopId,
    required this.shopNamaToko,
    this.imageShop,
    this.imageMenu,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      namaMenu: json['namaMenu'],
      hargaMenu: json['hargaMenu'].toDouble(),
      deskripsiMenu: json['deskripsiMenu'],
      stokMenu: json['stokMenu'],
      shopId: json['shop_id'],
      shopNamaToko: json['shop_namaToko'],
      imageShop: json['imageShop'],
      imageMenu: json['imageMenu'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'namaMenu': namaMenu,
      'hargaMenu': hargaMenu,
      'deskripsiMenu': deskripsiMenu,
      'stokMenu': stokMenu,
      'shop_id': shopId,
      'shop_namaToko': shopNamaToko,
      'imageShop': imageShop,
      'imageMenu': imageMenu,
    };
  }
}
