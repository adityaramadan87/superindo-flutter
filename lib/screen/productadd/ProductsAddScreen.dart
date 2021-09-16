import 'dart:io';

import 'package:flutter/material.dart';
import 'package:superindo/api/resnreq/base/BaseResponse.dart';
import 'package:superindo/constant/Constant.dart';
import 'package:superindo/helper/SharedPreferencesHelper.dart';
import 'package:superindo/helper/SizeConfig.dart';
import 'package:superindo/interface/ReturnedMain.dart';
import 'package:superindo/model/Products.dart';
import 'package:superindo/screen/component/ButtonMain.dart';
import 'package:superindo/screen/component/InputFieldArea.dart';
import 'package:superindo/screen/productadd/ProductsAddScreenProcess.dart';

class ProductsAddScreen extends StatefulWidget {
  ProductsAddScreen({this.products});

  Products products;

  @override
  ProductsAddScreenState createState() => ProductsAddScreenState();
}

class ProductsAddScreenState extends State<ProductsAddScreen> implements ReturnedMain {
  ProductsAddScreenProcess process;
  bool isLoading;

  @override
  void initState() {
    this.process = new ProductsAddScreenProcess(this);
    this.process.init();
    this.isLoading = false;

    super.initState();
  }

  @override
  void onError(String message) {
    // TODO: implement onError
    setState(() {
      this.isLoading = !this.isLoading;
    });
    print(message);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Have an error, Contact dev"),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  bool onProgress(bool isLoading) {
    // TODO: implement onProgress
    setState(() {
      this.isLoading = isLoading;
    });

    return isLoading;
  }

  @override
  void onSuccess(Object data, {flag}) {
    // TODO: implement onSuccess
    setState(() {
      this.isLoading = !this.isLoading;
    });
    if (data is BaseResponse) {
      BaseResponse baseResponse = data;
      if (baseResponse.requestCode == 0) {
        print("SUCCESS");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(baseResponse.message),
          ),
        );

        Navigator.pop(context, 1);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(baseResponse.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.swatch.PRIMARY,
        title: Text(
          widget.products != null ? "Edit Product" : "Add Product",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context, 0);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: this.process.form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: this.process.openGallery,
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 70,
                        height: SizeConfig.blockSizeVertical * 30,
                        decoration: BoxDecoration(border: Border.fromBorderSide(BorderSide(width: 1, color: Colors.grey))),
                        child: this.process.image == null
                            ? this.widget.products != null
                                ? Image.network(Constant.url.PICTURE_URL + this.widget.products.picture)
                                : Icon(
                                    Icons.add,
                                    size: 62,
                                    color: Colors.grey,
                                  )
                            : Image.file(this.process.image ?? new File("")),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    new InputFieldArea(
                      textInputType: TextInputType.text,
                      controller: this.process.productNameController,
                      hint: "Product Name",
                      validator: this.process.productNameValidator,
                      obscure: false,
                      fillColor: Colors.transparent,
                      borderColor: Colors.black54,
                      focusBorderColor: Colors.black54,
                      textColor: Colors.black54,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    new InputFieldArea(
                      textInputType: TextInputType.number,
                      controller: this.process.priceController,
                      hint: "Price",
                      validator: this.process.priceValidator,
                      obscure: false,
                      fillColor: Colors.transparent,
                      borderColor: Colors.black54,
                      focusBorderColor: Colors.black54,
                      textColor: Colors.black54,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    new InputFieldArea(
                      textInputType: TextInputType.number,
                      controller: this.process.stockController,
                      hint: "Stock",
                      validator: this.process.stockValidator,
                      obscure: false,
                      fillColor: Colors.transparent,
                      borderColor: Colors.black54,
                      focusBorderColor: Colors.black54,
                      textColor: Colors.black54,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Stock Condition",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 40,
                          child: Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: this.process.stockCondition,
                                onChanged: (value) {
                                  setState(() {
                                    this.process.stockCondition = value;
                                  });
                                },
                                activeColor: Constant.swatch.PRIMARY,
                              ),
                              Text("NEW"),
                            ],
                          ),
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 40,
                          child: Row(
                            children: [
                              Radio(
                                value: 2,
                                groupValue: this.process.stockCondition,
                                onChanged: (value) {
                                  setState(() {
                                    this.process.stockCondition = value;
                                  });
                                },
                                activeColor: Constant.swatch.PRIMARY,
                              ),
                              Text("SECOND"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    new InputFieldArea(
                      textInputType: TextInputType.multiline,
                      controller: this.process.descriptionController,
                      hint: "Description",
                      validator: this.process.descriptionValidator,
                      obscure: false,
                      textInputAction: TextInputAction.newline,
                      maxLines: 4,
                      fillColor: Colors.transparent,
                      borderColor: Colors.black54,
                      focusBorderColor: Colors.black54,
                      textColor: Colors.black54,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ButtonMain(
                      onTap: () {
                        if (widget.products == null) {
                          this.process.publish();
                        } else {
                          this.process.update();
                        }
                      },
                      text: "Publish Product",
                      width: SizeConfig.blockSizeHorizontal * 90,
                      textColor: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      backgroundColor: Constant.swatch.PRIMARY,
                      isLoading: false,
                      textSize: 18,
                      textWeight: FontWeight.bold,
                    )
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: this.isLoading,
            child: Container(
              color: Colors.white.withOpacity(0.5),
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Constant.swatch.PRIMARY),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
