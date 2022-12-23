import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiendaapp/screens/screens.dart';
import 'package:tiendaapp/services/services.dart';
import 'package:tiendaapp/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductsServices>(context);

    if(productService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: productService.productos.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: (){
                productService.selectProduct = productService.productos[index].copy();
                Navigator.pushNamed(context, 'product');
              },
              child: ProductCard(
                producto: productService.productos[index]

              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
