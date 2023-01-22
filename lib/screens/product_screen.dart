import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiendaapp/providers/product_form_provider.dart';
import 'package:tiendaapp/services/services.dart';
import 'package:tiendaapp/ui/input_decorations.dart';
import 'package:tiendaapp/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductsServices>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectProduct) ,
      child: _productScreenBody(productService: productService));
  }
}

class _productScreenBody extends StatelessWidget {
  const _productScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsServices productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
        body: Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(imagenproducto: productService.selectProduct.imagen),
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 40,
                        color: Colors.white,
                      ),
                    )),
                Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                      onPressed: () async {
                              final ImagePicker _picker = ImagePicker();
                              final PickedFile? pickedFile = await _picker.getImage(source: ImageSource.camera, imageQuality: 100);

                              if(pickedFile == null){
                                return;

                              }

                              print('Imagen tomada ${pickedFile.path}');
                              productService.ActualizarImagenSeleccionada(pickedFile.path);
                      },
                      icon: Icon(
                        Icons.camera_alt_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
            _ProductForm(),
            SizedBox(height: 100)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: productService.isSaving 
        ? CircularProgressIndicator():Icon(Icons.save_outlined),
        onPressed: 
        productService.isSaving 
        ? null :
        ()async {
          if(!productForm.isValidForm()) return;

          final String? imagenUrl = await productService.SubirImagen();

          if( imagenUrl != null) productForm.product.imagen = imagenUrl;

          await productService.saveOrCreateProduct(productForm.product);
        },
      ),
    ));
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5,
              )
            ]),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: product.codigo,
              onChanged:(value) => product.codigo = value ,
              validator: ((value) {
                if(value==null || value.length < 1)
                return 'El codigo es obligatorio';
              }),
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Codigo del producto',
                labelText: 'Codigo',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            
            TextFormField(
              initialValue: product.descripcion,
              onChanged:(value) => product.descripcion = value ,
              validator: ((value) {
                if(value==null || value.length < 1)
                return 'El nombre es obligatorio';
              }),
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Nombre del producto',
                labelText: 'Nombre',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              initialValue: product.precioVenta.toString(),
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Precio venta',
                labelText: 'Precio',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              initialValue: product.stock.toString(),
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Stock',
                labelText: 'Stock',
              ),
            ),
            SizedBox(
              height: 30,
            ),

          ],
        )),
      ),
    );
  }
}
