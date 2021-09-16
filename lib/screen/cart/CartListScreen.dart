import 'package:flutter/material.dart';
import 'package:superindo/api/resnreq/base/BaseResponse.dart';
import 'package:superindo/api/resnreq/cart/CartResponse.dart';
import 'package:superindo/constant/Constant.dart';
import 'package:superindo/helper/SizeConfig.dart';
import 'package:superindo/interface/ReturnedMain.dart';
import 'package:superindo/model/Cart.dart';
import 'package:superindo/screen/cart/CartListScreenProcess.dart';

class CartListScreen extends StatefulWidget {
  @override
  CartListScreenState createState() => CartListScreenState();
}

class CartListScreenState extends State<CartListScreen> implements ReturnedMain {
  CartListScreenProcess process;
  bool isLoading = false;
  List<Cart> cartList = [];

  @override
  void initState() {
    this.process = new CartListScreenProcess(this);
    this.process.init();

    super.initState();
  }

  @override
  void onError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error $message , contact dev"),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  bool onProgress(bool isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }

  @override
  void onSuccess(Object data, {flag}) {
    if (data is CartResponse) {
      CartResponse cartResponse = data;
      if (cartResponse.rc == 0) {
        setState(() {
          this.cartList = cartResponse.cart;
          this.isLoading = !this.isLoading;
        });
      } else {
        setState(() {
          this.isLoading = !this.isLoading;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(cartResponse.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    }else if (data is BaseResponse) {
      BaseResponse response = data;
      if (response.requestCode == 0) {
        setState(() {
          this.isLoading = !this.isLoading;
        });
        if ((flag as int) == 0) {
          Navigator.pushNamed(context, Pages.RECEIPT_SCREEN, arguments: this.cartList);
        }else {
          this.process.init();
        }
      } else {
        setState(() {
          this.isLoading = !this.isLoading;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message),
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
      floatingActionButton: Visibility(
        visible: this.cartList != null,
        child: FloatingActionButton.extended(
          label: Text("Checkout", style: TextStyle(color: Colors.white,),),
          backgroundColor: Constant.swatch.PRIMARY,
          onPressed: () {
            this.process.cartAllDelete(this.cartList[0].userId);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: !this.isLoading
          ? this.cartList != null && this.cartList.isNotEmpty
              ? ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: this.cartList.length,
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      leading: Container(
                        height: 100,
                        width: 100,
                        child: Image.network(
                          Constant.url.PICTURE_URL + this.cartList[index].picture,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      title: Text(
                        this.cartList[index].itemName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text("Rp. ${this.cartList[index].price}\nQuantity : ${this.cartList[index].qty}"),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Constant.swatch.PRIMARY,
                        ),
                        onPressed: () {
                          this.process.cartDelete(this.cartList[index].userId, this.cartList[index].productId);
                        },
                      ),
                    );
                  },
                )
              : Center(
                  child: Text("Not have product in cart"),
                )
          : Visibility(
              visible: this.isLoading,
              child: Container(
                color: Colors.white.withOpacity(0.5),
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Constant.swatch.PRIMARY),
                  ),
                ),
              ),
            ),
    );
  }
}
