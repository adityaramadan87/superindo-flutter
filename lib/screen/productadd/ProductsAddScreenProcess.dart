import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:superindo/api/resnreq/products/ProductsAddRequest.dart';
import 'package:superindo/api/resnreq/products/ProductsAddTask.dart';
import 'package:superindo/api/resnreq/products/ProductsEditRequest.dart';
import 'package:superindo/constant/SharedPreferencesKey.dart';
import 'package:superindo/helper/SharedPreferencesHelper.dart';
import 'package:superindo/screen/productadd/ProductsAddScreen.dart';

class ProductsAddScreenProcess {
  ProductsAddScreenProcess(this.screen);
  ProductsAddScreenState screen;

  File image;

  final form = GlobalKey<FormState>();

  TextEditingController productNameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController stockController = new TextEditingController();
  int stockCondition = -1;

  ImagePicker picker = new ImagePicker();
  var userID;

  init() async {
    this.userID = await SharedPreferencesHelper().get(SharedPreferencesKey.USER_ID, -1);
    if (screen.widget.products != null) {
      productNameController.text = screen.widget.products.itemName;
      priceController.text = screen.widget.products.price.toString();
      descriptionController.text = screen.widget.products.description;
      stockController.text = screen.widget.products.stock.toString();
      screen.setState(() {
        stockCondition = screen.widget.products.stockCondition == "NEW" ? 1 : 2;
      });
    }
  }

  String productNameValidator(String text) {
    if (text.isEmpty) {
      return "Product name can't empty";
    }
    return null;
  }

  String descriptionValidator(String text) {
    if (text.isEmpty) {
      return "Description can't empty";
    }
    return null;
  }

  String priceValidator(String text) {
    if (text.isEmpty) {
      return "Price name can't empty";
    }

    if (text.contains("-")){
      return "can't use negative number";
    }

    if (text.contains(" ")) {
      return "can't use white space in number";
    }

    return null;
  }

  String stockValidator(String text) {
    if (text.isEmpty) {
      return "Stock name can't empty";
    }

    if (text.contains("-")){
      return "can't use negative number";
    }

    if (text.contains(" ")) {
      return "can't use white space in number";
    }

    return null;
  }


  void openGallery() async {
    try {
      var image = await picker.pickImage(source: ImageSource.gallery);
      this.screen.setState(() {
        this.image = File(image.path);
      });
    }catch (e) {
      print(e);
    }
  }

  void publish() {
    if (this.form.currentState.validate()){
      if (this.stockCondition > -1){
        this.screen.setState(() {
          this.screen.isLoading = !this.screen.isLoading;
        });
        ProductsAddRequest request = new ProductsAddRequest();
        request.idSeller = this.userID;
        request.stockCondition = this.stockCondition == 1 ? "NEW" : "SECOND";
        request.stock = this.stockController.text;
        request.price = int.parse(this.priceController.text);
        request.description = this.descriptionController.text;
        request.productName = this.productNameController.text;
        request.picture = this.convertBase64(this.image);

        print(request.picture);

        ProductsAddTask productsAddTask = new ProductsAddTask(returnedMain: this.screen);
        productsAddTask.fetch(request);
      }
    }
  }

  String convertBase64(File rImage) {
    final bytes = rImage.readAsBytesSync();

    var mime = lookupMimeType(rImage.path);
    print(mime);
    // rImage."data:image/png;base64," +
    return "data:$mime;base64," +base64Encode(bytes);
  }

  void update() {
    if (this.form.currentState.validate()){
      if (this.stockCondition > -1){
        this.screen.setState(() {
          this.screen.isLoading = !this.screen.isLoading;
        });
        ProductsEditRequest request = new ProductsEditRequest();
        request.id = this.screen.widget.products.id;
        request.stockCondition = this.stockCondition == 1 ? "NEW" : "SECOND";
        request.stock = this.stockController.text;
        request.price = int.parse(this.priceController.text);
        request.description = this.descriptionController.text;
        request.productName = this.productNameController.text;
        if (this.image != null) {
          request.picture = this.convertBase64(this.image);
        }else {
          request.picture = "";
        }

        print(request.picture);

        ProductsAddTask productsAddTask = new ProductsAddTask(returnedMain: this.screen);
        productsAddTask.update(request);
      }
    }
  }
}