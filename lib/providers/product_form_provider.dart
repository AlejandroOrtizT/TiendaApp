import 'package:flutter/material.dart';
import 'package:tiendaapp/models/model.dart';

class ProductFormProvider extends ChangeNotifier{

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Product product;

  ProductFormProvider(this.product);

 bool isValidForm() {
  return formKey.currentState?.validate() ?? false;
 }


}