import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));



class Product {
    Product({
         this.id,
         this.idCategoria,
         this.codigo,
         this.descripcion,
         this.imagen,
         this.stock,
         this.precioCompra,
         this.precioVenta,
         this.ventas,
         required this.fecha,
    });

    int? id;
    int? idCategoria;
    String? codigo;
    String? descripcion;
    String? imagen;
    int? stock;
    double? precioCompra;
    double? precioVenta;
    int? ventas;
    DateTime fecha;

    String toJson() => json.encode(toMap());

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        idCategoria: json["id_categoria"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        imagen: json["imagen"],
        stock: json["stock"],
        precioCompra: json["precio_compra"].toDouble(),
        precioVenta: json["precio_venta"].toDouble(),
        ventas: json["ventas"],
        fecha: DateTime.parse(json["fecha"]),
    );

    Map<String, dynamic> toMap() => {
        "idCategoria": idCategoria,
        "codigo": codigo,
        "descripcion": descripcion,
        "imagen": imagen,
        "stock": stock,
        "precioCompra": precioCompra,
        "precioVenta": precioVenta,
        "ventas": ventas
    };

     Product copy () =>Product(
        id:  this.id,
        idCategoria:  this.idCategoria,
        codigo:  this.codigo,
        descripcion:  this.descripcion,
        imagen:  this.imagen,
        stock:  this.stock,
        precioCompra:  this.precioCompra,
        precioVenta:  this.precioVenta,
        ventas:  this.ventas,
        fecha: this.fecha
    );
}


