import 'package:flutter/material.dart';
import 'package:superindo/api/resnreq/base/BaseResponse.dart';
import 'package:superindo/api/resnreq/cart/CartRequest.dart';
import 'package:superindo/api/service/RestApi.dart';
import 'package:superindo/constant/Constant.dart';
import 'package:superindo/constant/SharedPreferencesKey.dart';
import 'package:superindo/helper/SharedPreferencesHelper.dart';
import 'package:superindo/helper/SizeConfig.dart';
import 'package:superindo/model/Products.dart';
import 'package:superindo/screen/component/ButtonMain.dart';
import 'package:superindo/screen/component/HeroContainer.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen({this.products});

  Products products;

  @override
  ProductDetailScreenState createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  SharedPreferencesHelper preferencesHelper = new SharedPreferencesHelper();
  int userId;

  @override
  void initState() {
    this.init();
    super.initState();
  }

  init() async {
    var id = await preferencesHelper.get(SharedPreferencesKey.USER_ID, -1);
    setState(() {
      this.userId = id;
    });
    print(userId);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.swatch.PRIMARY,
        title: Image.asset(
          "assets/logo-superindo.png",
          width: 50,
          height: 50,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Column(
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 80,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeroContainer(
                      heroTag: "products" + widget.products.id.toString(),
                      height: SizeConfig.blockSizeVertical * 30,
                      width: SizeConfig.screenWidth,
                      child: Image.network(
                        Constant.url.PICTURE_URL + widget.products.picture,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Text(
                        widget.products.itemName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        "Condition : " + widget.products.stockCondition,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        "Stock : " + widget.products.stock,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          "Rp. " + widget.products.price.toString(),
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Constant.swatch.PRIMARY),
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      width: SizeConfig.screenWidth,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        widget.products.description,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            this.userId == widget.products.idSeller
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonMain(
                        onTap: () {
                          Navigator.pushNamed(context, Pages.PRODUCT_ADD_SCREEN, arguments: widget.products).then((value) {
                            if ((value as int) == 1) {
                              Navigator.pop(context);
                            }
                          });
                        },
                        text: "Edit",
                        width: SizeConfig.blockSizeHorizontal * 45,
                        textColor: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        backgroundColor: Colors.green,
                        isLoading: false,
                        textSize: 18,
                        textWeight: FontWeight.bold,
                      ),
                      ButtonMain(
                        onTap: () {
                          this.removeProduct();
                        },
                        text: "Remove",
                        width: SizeConfig.blockSizeHorizontal * 45,
                        textColor: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        backgroundColor: Constant.swatch.PRIMARY,
                        isLoading: false,
                        textSize: 18,
                        textWeight: FontWeight.bold,
                      )
                    ],
                  )
                : ButtonMain(
                    onTap: () {
                      this.addToCart();
                    },
                    text: "Add to Cart",
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
    );
  }

  void removeProduct() {
    RestApi restApi = new RestApi();

    restApi.productsDelete(widget.products.id).then((value) {
      BaseResponse response = value;
      if (response.requestCode == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Success delete product"),
          ),
        );
        Navigator.pop(context);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${response.message}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }).catchError((err) {
      print(err);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error $err , contact dev"),
          backgroundColor: Colors.red,
        ),
      );
    }).timeout(Duration(seconds: 30), onTimeout: () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Connection Timeout"),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  void addToCart() {
    RestApi restApi = new RestApi();

    CartRequest request = new CartRequest();
    request.userId = this.userId;
    request.productId = widget.products.id;

    restApi.addToCart(request).then((value) {
      BaseResponse response = value;
      if (response.requestCode == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Success add to cart"),
          ),
        );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${response.message}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }).catchError((err) {
      print(err);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error $err , contact dev"),
          backgroundColor: Colors.red,
        ),
      );
    }).timeout(Duration(seconds: 30), onTimeout: () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Connection Timeout"),
          backgroundColor: Colors.red,
        ),
      );
    });
  }
}
