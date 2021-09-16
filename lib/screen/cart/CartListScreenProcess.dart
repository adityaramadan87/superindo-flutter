import 'package:superindo/api/resnreq/cart/CartTask.dart';
import 'package:superindo/screen/cart/CartListScreen.dart';

class CartListScreenProcess {
  CartListScreenProcess(this.screen);
  CartListScreenState screen;

  init() {
    this.screen.setState(() {
      this.screen.isLoading = !this.screen.isLoading;
    });
    CartTask cartTask = new CartTask(returnedMain: this.screen);
    cartTask.fetch();
  }

  void cartDelete(int userId, int productId) {
    this.screen.setState(() {
      this.screen.isLoading = !this.screen.isLoading;
    });
    CartTask cartTask = new CartTask(returnedMain: this.screen);
    cartTask.delete(userId, productId);
  }

  void cartAllDelete(int userId) {
    this.screen.setState(() {
      this.screen.isLoading = !this.screen.isLoading;
    });

    CartTask cartTask = new CartTask(returnedMain: this.screen);
    cartTask.deleteAll(userId);
  }
}