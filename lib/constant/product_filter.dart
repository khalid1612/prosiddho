import 'package:get/get.dart';
import 'package:prosiddho/constant/constant_export.dart';
import 'package:prosiddho/controller/products_controller.dart';
import 'package:prosiddho/model/product_model/product_model.dart';

class ProductFilter {
  //!special for you
//simillar product user last buy
//তার বিভাগের কেউ যদি কোন পন্য কিনে
//product form other division

// inittially we have no user
// and order is null
// so show a random prduct
  static List<ProductModel> specialForYou() => _randomProduct(3);

  //! hot products
  //*last sell + new product
  static List<ProductModel> hotProducts() => _randomProduct(5);

  static List<ProductModel> recentlyUpdated() => _randomProduct(10);

  static List<ProductModel> mostPopular() => _randomProduct(20);

  static List<ProductModel> _randomProduct(int maxItem) {
    List<ProductModel> temp = List();
    for (int i = 0; i < maxItem; i++) {
      temp.add(
        Get.find<ProductController>().allProducts[Util.random(
                min: 1, max: Get.find<ProductController>().totalProducts) -
            1],
      );
    }

    return temp;
  }
}
