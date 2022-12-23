import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {

  final String? imagenproducto;

  const ProductImage({super.key, this.imagenproducto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: Container(
        width: double.infinity,
        height: 450,
        decoration: _buildBoxDecoration(),
        child: Opacity(
          opacity: 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            child: this.imagenproducto == null 
            ?Image(
                image: AssetImage('assets/no-image.png'),
                fit: BoxFit.cover
                )
            :         
            FadeInImage(
                placeholder: AssetImage('assets/jar-loading.gif'),
                image: NetworkImage('https://via.placeholder.com/400x300/green'),
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
      color: Colors.black,
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5))
      ],
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45), topRight: Radius.circular(45)));
}
