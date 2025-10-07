import 'package:smride_app/res/constants/app_constants.dart';
import 'package:smride_app/data/network/baseApiServices.dart';
import 'package:smride_app/data/network/networkApiServices.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> sendOtp(dynamic data) async {
    try {
      dynamic response = await _apiServices.postApiResponse(
          '${AppConstants.userUrl}/${AppConstants.sendOtp}', data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> verifyOtp(dynamic data) async {
    try {
      dynamic response = await _apiServices.postApiResponse(
          "${AppConstants.userUrl}/${AppConstants.veifyOtp}", data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> submitUserDetails(dynamic data) async {
    try {
      dynamic response = await _apiServices.postApiResponse(
          "${AppConstants.userUrl}/complete-profile", data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
