import 'package:flutter/material.dart';
import 'package:tiendaapp/models/model.dart';

class ProductCard extends StatelessWidget {
  final Product producto;

  const ProductCard({super.key, required this.producto}); 
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _backgroundImage( producto.imagen),
            _ProductDetails(codigo: producto.codigo! , nombre:  producto.descripcion!,),
            Positioned(child: _PriceTag(producto.precioVenta!), top: 0, right: 0),
            Positioned(child: _NotAvailabel(stock: producto.stock), top: 0, left: 0)
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() =>
      BoxDecoration(borderRadius: BorderRadius.circular(25), boxShadow: [
        BoxShadow(color: Colors.black12, offset: Offset(0, 5), blurRadius: 10)
      ]);
}

class _NotAvailabel extends StatelessWidget {
  final int? stock;

  const _NotAvailabel({this.stock});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.green[800],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('$stock piezas',
                style: TextStyle(fontSize: 20, color: Colors.white))),
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {

  final double precio;

  const _PriceTag(this.precio);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), bottomLeft: Radius.circular(25))),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('\$$precio',
              style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final String nombre;
  final String codigo;

  const _ProductDetails({required this.nombre, required this.codigo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Column(
          children: [
            Text(
              nombre,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              codigo,
              style: TextStyle(fontSize: 15, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
      color: Colors.indigo,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25), topRight: Radius.circular(25)));
}

class _backgroundImage extends StatelessWidget {
  final String? url;

  const _backgroundImage(this.url);


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: url == null 
        ? Image(
            image: AssetImage('assets/no-image.png'),
            fit: BoxFit.cover,
            )
        : FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage('https://via.placeholder.com/400x300/f6f6f6'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
