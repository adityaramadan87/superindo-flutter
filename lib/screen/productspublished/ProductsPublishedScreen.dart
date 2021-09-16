import 'package:flutter/material.dart';
import 'package:superindo/api/resnreq/products/ProductsResponse.dart';
import 'package:superindo/constant/Constant.dart';
import 'package:superindo/interface/ReturnedMain.dart';
import 'package:superindo/model/Products.dart';
import 'package:superindo/screen/component/HeroContainer.dart';
import 'package:superindo/screen/productspublished/ProductsPublishedScreenProcess.dart';

class ProductsPublishedScreen extends StatefulWidget {
  @override
  ProductsPublishedScreenState createState() => ProductsPublishedScreenState();
}

class ProductsPublishedScreenState extends State<ProductsPublishedScreen> implements ReturnedMain {
  ProductsPublishedScreenProcess process;
  List<Products> productsList = [];
  bool isLoading = false;

  @override
  void initState() {
    this.process = new ProductsPublishedScreenProcess(this);
    this.process.init();

    super.initState();
  }

  @override
  void onError(String message) {
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
    setState(() {
      this.isLoading = isLoading;
    });
  }

  @override
  void onSuccess(Object data, {flag}) {
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
        body: !this.isLoading
            ? this.productsList != null && this.productsList.isNotEmpty
                ? GridView.builder(
                    padding: EdgeInsets.all(16),
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
                                  heroTag: "products-published" + this.productsList[index].id.toString(),
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
                : Center(
                    child: Text("Not have product published"),
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
              ));
  }
}
