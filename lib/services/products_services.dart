
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tiendaapp/models/model.dart';
import 'package:http/http.dart' as http;
class ProductsServices extends ChangeNotifier{
  final String _baseUrl = '10.0.2.2:3000';

  final List<Product> productos = [];

  late Product selectProduct;
  File? newPictureFile;
  bool isLoading = true;
  bool isSaving = false;
  ProductsServices(){

    loadProducts();
    
  }

  Future<List<Product>> loadProducts() async{
    this.isLoading = true;
    notifyListeners();
    var url = Uri.http(_baseUrl, 'api/productos');
    final resp = await http.get(url);

    final productosresp = productFromJson(resp.body);
    productos.addAll(productosresp);

    this.isLoading = false;
    notifyListeners();

    

    return productos;

  }

  Future saveOrCreateProduct(Product product) async{
    this.isSaving = true;
    notifyListeners();
    if(product.id != null){
       var url = Uri.http(_baseUrl, 'api/Productos/${product.id}');
       product.imagen = 'View/img/productos/' + product.imagen!;
       var body = product.toJson();
       final resp = await http.put(url,body:body,headers:{"Content-Type": "application/json"});
        final decodeData = resp.body;
        print(decodeData);
    }else{

    }

    this.isSaving = false;
    notifyListeners();
  }



  void ActualizarImagenSeleccionada(String path){

    this.selectProduct.imagen = path;
    this.newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();

  }

  Future<String?>  SubirImagen() async{
    if(this.newPictureFile == null) return null;
    this.isSaving = true;
    notifyListeners();

    final url = Uri.http(_baseUrl, 'api/subirImagen');

    final imagenUploadRequest = http.MultipartRequest('POST',url);

    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imagenUploadRequest.files.add(file);

    final streamResponse = await imagenUploadRequest.send();

    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode != 200 && resp.statusCode != 201){
      print(resp.body);
      return null;
    }

    this.newPictureFile = null;

  final decodeData = jsonDecode(resp.body);

  return decodeData['url'];

  }
}