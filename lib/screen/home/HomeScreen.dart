import 'package:flutter/material.dart';
import 'package:superindo/api/resnreq/products/ProductsResponse.dart';
import 'package:superindo/constant/Constant.dart';
import 'package:superindo/helper/SizeConfig.dart';
import 'package:superindo/interface/ReturnedMain.dart';
import 'package:superindo/model/Products.dart';
import 'package:superindo/screen/component/HeroContainer.dart';
import 'package:superindo/screen/component/InputFieldArea.dart';
import 'package:superindo/screen/home/HomeScreenProcess.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> implements ReturnedMain {
  HomeScreenProcess process;
  bool isLoading = false;
  List<Products> productsList = [];

  @override
  void initState() {
    this.process = new HomeScreenProcess(this);
    this.process.init();

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
        content: Text("Error $message , contact dev"),
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
  }

  @override
  void onSuccess(Object data, {flag}) {
    // TODO: implement onSuccess
    if (data is ProductResponse) {
      ProductResponse productResponse = data;
      if (productResponse.requestCode == 0) {
        setState(() {
          this.productsList = productResponse.productsList;
          this.isLoading = !this.isLoading;
        });
      } else {
        setState(() {
          this.isLoading = !this.isLoading;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(productResponse.message),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              // height: SizeConfig.blockSizeVertical *  10,
              // margin: EdgeInsets.only(top: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 75,
                    child: InputFieldArea(
                      hint: "Search products...",
                      readOnly: true,
                      onTap: () {},
                      borderColor: Colors.white,
                      obscure: false,
                      textColor: Colors.black87,
                      icon: Icons.search,
                      fillColor: Colors.white,
                      focusBorderColor: Constant.swatch.PRIMARY,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Pages.CART_SCREEN);
                    },
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Constant.swatch.PRIMARY,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            !this.isLoading
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200, childAspectRatio: 2 / 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: this.productsList.length,
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Pages.PRODUCT_DETAIL_SCREEN, arguments: this.productsList[index]).then((value) {
                            this.process.init();
                          });
                        },
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            children: [
                              HeroContainer(
                                  width: double.infinity,
                                  height: double.infinity,
                                  heroTag: "products" + this.productsList[index].id.toString(),
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              Constant.url.PICTURE_URL + this.productsList[index].picture,
                                            ),
                                            fit: BoxFit.cover)),
                                  )),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
                                  child: Column(
                                    children: [
                                      Text(
                                        this.productsList[index].itemName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                      Text(
                                        this.productsList[index].stockCondition,
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                      Text(
                                        "Rp. " + this.productsList[index].price.toString(),
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.yellow),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                        ),
                      );
                    },
                  )
                : Container(
                    height: SizeConfig.blockSizeVertical * 80,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Constant.swatch.PRIMARY),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
