import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_app/config.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/login_response_model.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/models/product_filter.dart';
import 'package:grocery_app/models/slider.dart';
import 'package:grocery_app/utils/shared_services.dart';
import 'package:http/http.dart' as http;

final apiService = Provider((ref) => APIService());

class APIService {
  static var client = http.Client();

  Future<List<SliderModel>?> getSliders(page, pageSize) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    Map<String, String> queryString = {
      'page': page.toString(),
      'pageSize': pageSize.toString(),
    };

    var url = Uri.http(Config.apiURL, Config.sliderAPI, queryString);

    try {
      var response = await client.get(url, headers: requestHeaders);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return slidersFromJson(data["data"]);
      } else {
        // Handle the error response
        // ignore: avoid_print
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      // ignore: avoid_print
      print('Exception: $e');
      return null;
    }
  }

  Future<List<Category>?> getCategories(page, pageSize) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    Map<String, String> queryString = {
      'page': page.toString(),
      'pageSize': pageSize.toString(),
    };

    var url = Uri.http(Config.apiURL, Config.categoryAPI, queryString);

    try {
      var response = await client.get(url, headers: requestHeaders);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return categoriesFromJson(data["data"]);
      } else {
        // Handle the error response
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      print('Exception: $e');
      return null;
    }
  }

  Future<List<Product>?> getProducts(
      ProductFilterModel productFilterModel) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    Map<String, String> queryString = {
      'page': productFilterModel.paginationModel.page.toString(),
      'pageSize': productFilterModel.paginationModel.pageSize.toString(),
    };

    if (productFilterModel.categoryId != null) {
      queryString['categoryId'] = productFilterModel.categoryId!;
    }
    if (productFilterModel.sortBy != null) {
      queryString['sort'] = productFilterModel.sortBy!;
    }
    if (productFilterModel.productIds != null) {
      queryString['productIds'] = productFilterModel.productIds!.join(",");
    }

    var url = Uri.http(Config.apiURL, Config.productAPI, queryString);

    try {
      var response = await client.get(url, headers: requestHeaders);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return productFromJson(data["data"]);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Product?>? getProductDetails(String productId) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.productAPI + "/" + productId);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return Product.fromJson(data["data"]);
    } else {
      return null;
    }
  }

  static Future<bool> registerUser(
    String fullName,
    String email,
    String password,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.registerAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
          {"fullName": fullName, "email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      // Handle the error response
      return false;
    }
  }

  static Future<bool> loginUser(
    String email,
    String password,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.loginAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      await SharedServices.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      // Handle the error response
      return false;
    }
  }
}
