import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kmshoppy/provider/slider_provider.dart';
import 'package:provider/provider.dart';

import '../models/detils_model.dart';
import '../provider/feturedItem_provider.dart';
import '../resources/urls.dart';

class DioHelper {
  Dio dio = Dio();

  DioHelper() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {"vendorUrlKey": "kmshoppy"},
      connectTimeout: 3000000,
      receiveTimeout: 1000000,
      followRedirects: true,
      responseType: ResponseType.json,
      receiveDataWhenStatusError: true,
      contentType: ResponseType.plain.toString(),
    ));
    dio.interceptors.add(InterceptorsWrapper(
      onError: (e, handler) {
        print(e);
        Response res = _handleDioError(e);
        handler.resolve(res);
      },
    ));
  }

  Response _handleDioError(DioError dioError) {
    String message;
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.other:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        switch (dioError.response!.statusCode) {
          case 400:
            message = 'Bad request';
            break;
          case 404:
            message = "404 bad request";
            break;
          case 422:
            message = "422 bad request";
            break;
          case 500:
            message = 'Internal server error';
            break;
          default:
            message = 'Oops something went wrong';
            break;
        }
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
    return Response(
        requestOptions: RequestOptions(path: ""),
        data: dioError.response?.data,
        statusMessage: message,
        statusCode: dioError.response?.statusCode ?? 500);
  }

  // Future getCategories(context, int branchId) async {
  //   final state = Provider.of<CategoryProvider>(context, listen: false);
  //   final response = await dio
  //       .get(categoriesListUrl, queryParameters: {"branch_id": branchId});
  //   // final decode = jsonDecode(response);
  //   if (response.data['status'] == responseOk) {
  //     state.addCategory(jsonEncode(response.data));
  //   } else {
  //     showMessage(response.data['message'], Colors.redAccent, context);
  //   }
  // }
   Future<List<VariantModel>> getData() async {
    try {
      Response response = await dio.get(productDetails);
      print("response=$response");
      Map<String, dynamic> result = json.decode(response.data);
      print("result=$result");
      if (result['Message'] == "Product Details  ") {
        List collection = result['Data']['ProdDetails']['ProdImages'];
        print("list=$collection");
        return [];
        return collection.map((s) => VariantModel.fromJson(s)).toList();
      } else {
        throw Exception("Internal Server Error");
      }
    } on DioError catch (e) {
      throw Exception(e.response);
    }
  }
  Future getFeaturedItems(context, int categoryId) async {
    //final userState = Provider.of<UserProvider>(context, listen: false);
    // final state = Provider.of<BranchProvider>(context, listen: false);
    final state = Provider.of<ItemProvider>(context, listen: false);
    final response = await dio.get(productDetails);
    state.addFrequentItems(jsonEncode(response.data));
  }
  Future getSample(context,urlKey) async {
    //final userState = Provider.of<UserProvider>(context, listen: false);
    // final state = Provider.of<BranchProvider>(context, listen: false);
    final state = Provider.of<ItemProvider>(context, listen: false);
    final response = await dio.get("${baseUrl}ProductDetails?urlKey=$urlKey&custId=''&guestId=4653631114&pincode='kmshoppy'&vendorUrlKey='kmshoppy'");
    state.addVariants(jsonEncode(response.data));

    // final parsedJson = json.decode(response.data);
    // print("privilege=$privilege");
    // final privilege = parsedJson['Data']['ProdDetails']['variationJson'];
    // print("privilege=$privilege");
  }
  Future getProductDetails(
      context,urlKey
      ) async {
    print('state1');
    final state = Provider.of<ItemProvider>(context, listen: false);
    // progressDialogue(context);
    final response = await dio.get("${baseUrl}ProductDetails?urlKey=$urlKey&custId=''&guestId=4653631114&pincode='kmshoppy'&vendorUrlKey='kmshoppy'");
    print('state2');
     print('dtails; $response');
    if (response.data['Message'] == "Product Details  ") {
      print("true");
      state.addDetails(jsonEncode(response.data));
      // state.setBranch(context);
      // print(
      //     'state.selectedBranchId ${state.selectedBranchId} ${state.branchesList.length}');
    } else {
      //showMessage(response.data['message'], Colors.redAccent, context);
    }
  }
  Future getSliders(
    context,
  ) async {
    // Future getBranches(context, {bool isLogged = false}) async {
    print('state1');
    final state = Provider.of<SliderProvider>(context, listen: false);
    // progressDialogue(context);
    final response = await dio.get(getBannerAndCategories);
    print('state2');
   // print('state2; $response');
    if (response.data['Message'] == "") {
      state.addSliders(jsonEncode(response.data));
      // state.setBranch(context);
      // print(
      //     'state.selectedBranchId ${state.selectedBranchId} ${state.branchesList.length}');
    } else {
      //showMessage(response.data['message'], Colors.redAccent, context);
    }
  }



}
