import 'package:superindo/api/resnreq/products/ProductsTask.dart';
import 'package:superindo/screen/home/HomeScreen.dart';

class HomeScreenProcess {
  HomeScreenProcess(this.screen);
  HomeScreenState screen;

  init() {
    screen.setState(() {
      this.screen.isLoading = !this.screen.isLoading;
    });
    ProductsTask productsTask = new ProductsTask(returnedMain: this.screen);
    productsTask.fetch();
  }

}