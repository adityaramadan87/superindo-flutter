import 'dart:math';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:superindo/constant/Constant.dart';
import 'package:superindo/helper/SizeConfig.dart';
import 'package:superindo/model/Cart.dart';

class ReceiptScreen extends StatefulWidget {
  ReceiptScreen({this.cartList});
  List<Cart> cartList;

  @override
  _ReceiptScreenState createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {

  Random rnd = new Random();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String totalBayar() {
    int data = this.widget.cartList.fold(0, (previousValue, element) {
      return previousValue + (element.price*element.qty);
    });

    return data.toString();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacementNamed(context, Pages.BOTTOMBAR_SCREEN);
      },
      child: Scaffold(
        backgroundColor: Constant.swatch.PRIMARY,
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
          floatingActionButton: FloatingActionButton.extended(
            label: Text("Back", style: TextStyle(color: Colors.white,),),
            backgroundColor: Constant.swatch.PRIMARY,
            onPressed: () {
              Navigator.pushReplacementNamed(context, Pages.BOTTOMBAR_SCREEN);
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 16),
            width: SizeConfig.blockSizeHorizontal * 90,
            height: SizeConfig.blockSizeVertical * 80,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(
                          0,12
                      ),
                      color: Color(0x80AC1818),
                      blurRadius: 20,
                      spreadRadius: 8
                  )
                ]
            ),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 60,
                    // padding: EdgeInsets.all(16),
                    child: Text(
                      "Super Indo",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Invoice :",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Nunito"
                      ),
                    ),
                    Text(
                      "INV/2021/SPRINDO/${rnd.nextInt(100)}",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Nunito"
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Date Checkout :",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Nunito"
                      ),
                    ),
                    Text(
                      "${DateFormat("dd-MM-yyyy HH:mm:ss").format(DateTime.now())}",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Nunito"
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                DottedLine(
                  dashColor: Constant.swatch.PRIMARY,
                  lineLength: SizeConfig.blockSizeHorizontal * 80,
                  lineThickness: 1,
                ),
                SizedBox(height: 10,),
                Container(
                    height: SizeConfig.blockSizeVertical * 25,
                    child: Scrollbar(
                      child:ListView.builder(
                        itemCount: this.widget.cartList.length,
                        itemBuilder: (ctx, index) {
                          return ListTile(
                            contentPadding: EdgeInsets.only(left: 0, right: 0),
                            title: Text(
                              "${this.widget.cartList[index].itemName}",
                              style: TextStyle(color: Colors.black87, fontFamily: "Nunito",fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            subtitle: Text(
                              "${this.widget.cartList[index].price}\n${this.widget.cartList[index].qty}",
                              style: TextStyle(color: Colors.black87, fontFamily: "Nunito", fontSize: 14),
                            ),
                            trailing: Text(
                              "${NumberFormat.simpleCurrency(name: "Rp. ",decimalDigits: 0).format((this.widget.cartList[index].price*this.widget.cartList[index].qty))}",
                              style: TextStyle(color: Colors.black87, fontFamily: "Nunito", fontSize: 14),
                            ),
                          );
                        },
                      ),
                    )
                ),
                SizedBox(height: 10,),
                DottedLine(
                  dashColor: Constant.swatch.PRIMARY,
                  lineLength: SizeConfig.blockSizeHorizontal * 80,
                  lineThickness: 1,
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Total :",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Nunito"
                      ),
                    ),
                    Text(
                      "${NumberFormat.simpleCurrency(name: "Rp. ",decimalDigits: 0).format(int.tryParse(this.totalBayar()))}",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Nunito",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        )
      ),
    );
  }
}
