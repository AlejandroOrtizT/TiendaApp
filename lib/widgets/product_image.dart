import 'dart:io';

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
              child: getImage(imagenproducto)),
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

  Widget getImage(String? picture) {
    if (picture == null || picture.isEmpty)
      return Image(image: AssetImage('assets/no-image.png'), fit: BoxFit.cover);

    if (picture.startsWith('http'))
      return  FadeInImage(
          placeholder: NetworkImage('http://10.0.2.2/tienda/img/jar-loading.gif'),
          image: NetworkImage('http://10.0.2.2/tienda/img/imagen-example.png'),
          fit: BoxFit.cover);

    if (picture.startsWith('/data'))
      return Image.file(
          File(picture),
          fit: BoxFit.cover,
        );

    return  FadeInImage(
          placeholder: NetworkImage('http://10.0.2.2/tienda/img/jar-loading.gif'),
          image: NetworkImage('http://10.0.2.2/tienda/'+picture),
          fit: BoxFit.cover);
  }
}
