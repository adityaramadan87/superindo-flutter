import 'package:superindo/api/resnreq/products/ProductsTask.dart';
import 'package:superindo/screen/productspublished/ProductsPublishedScreen.dart';

class ProductsPublishedScreenProcess {
  ProductsPublishedScreenProcess(this.screen);
  ProductsPublishedScreenState screen;

  init() {
    ProductsTask task = new ProductsTask(returnedMain: this.screen);
    task.byUserId();
  }

}