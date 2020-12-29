import 'package:prosiddho/controller/products_controller.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'package:get/get.dart';

class ProductSearch {
  var _allProducts = Get.find<ProductController>().allProducts;

  List<ProductModel> searchProductByCategory(String category) {
    List<ProductModel> temp = List();
    category = category.trim().toLowerCase();

    for (ProductModel productModel in _allProducts) {
      if (productModel.type.trim().toLowerCase() == category) {
        temp.add(productModel);
      } else {
        print(productModel.id);
      }
    }

    return temp;
  }

  List<ProductModel> searchProductByDistrict(String division, String district) {
    List<ProductModel> temp = List();

    division = division.trim().toLowerCase();
    district = district.trim().toLowerCase();

    for (ProductModel productModel in _allProducts) {
      if (productModel.birthPlace.division.trim().toLowerCase() == division) {
        if (district == "all") {
          temp.add(productModel);
        } else {
          for (String dis in productModel.birthPlace.districts) {
            if (dis.trim().toLowerCase() == district) {
              temp.add(productModel);
            }
          }
        }
      }
    }

    return temp;
  }
}
