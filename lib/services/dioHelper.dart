import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kmshoppy/provider/slider_provider.dart';
import 'package:provider/provider.dart';

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

  Future getFeaturedItems(context, int categoryId) async {
    //final userState = Provider.of<UserProvider>(context, listen: false);
    // final state = Provider.of<BranchProvider>(context, listen: false);
    final state = Provider.of<ItemProvider>(context, listen: false);
    final response = await dio.get(getHomeProducts);
    state.addFrequentItems(jsonEncode(response.data));
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

  // Future getCategoryItems(context, int categoryId) async {
  //   final userState = Provider.of<UserProvider>(context, listen: false);
  //   // final state = Provider.of<BranchProvider>(context, listen: false);
  //   final state = Provider.of<ItemProvider>(context, listen: false);
  //   final response = await dio.get(itemsByCategory, queryParameters: {
  //     "category_id": categoryId,
  //     "branch_id": 1,
  //   });
  //   //print("response=${jsonEncode(response.data)}");
  //   state.addItems(jsonEncode(response.data));
  // }

  // Future getSubCategoryItems(context, int subCateId) async {
  //   final userState = Provider.of<UserProvider>(context, listen: false);
  //   // final state = Provider.of<BranchProvider>(context, listen: false);
  //   final state = Provider.of<ItemProvider>(context, listen: false);
  //   final response = await dio.get(itemsListUrl, queryParameters: {
  //     "sub_category_id": subCateId,
  //     "branch_id": 1,
  //     // "token": userState.userModel.token
  //   });
  //   state.addItems(jsonEncode(response.data));
  // }
}
