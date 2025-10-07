import 'package:smride_app/data/network/baseApiServices.dart';
import 'package:smride_app/data/network/networkApiServices.dart';
import 'package:smride_app/model/accepted_ride_model.dart';
import 'package:smride_app/model/fetch_request_model.dart';
import 'package:smride_app/res/constants/app_constants.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> requestRide(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.postApiResponse(AppConstants.requestUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<FetchRequestModel>> fetchRideRequests(String token) async {
    try {
      final List<dynamic> response = await _apiServices
          .getApiResponse("${AppConstants.requestUrl}/$token");

      List<FetchRequestModel> requestList = response
          .map((request) => FetchRequestModel.fromJson(request))
          .toList();
      return requestList;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getUserDetails(String userId) async {
    try {
      dynamic response = await _apiServices
          .getApiResponse("${AppConstants.userUrl}/info/${userId}");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postOfferRequest(dynamic data, String requesterID) async {
    try {
      dynamic response = await _apiServices.putApiResponse(
          "${AppConstants.userUrl}/accepted-rides/${requesterID}", data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<FetchRequestModel>> fetchMyRequests(String userId) async {
    try {
      List<dynamic> response = await _apiServices
          .getApiResponse("${AppConstants.requestUrl}/myrequest/$userId");
      List<FetchRequestModel> myRequstList = response
          .map((request) => FetchRequestModel.fromJson(request))
          .toList();
      return myRequstList;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteRequest(String requestId) async {
    try {
      dynamic response = await _apiServices
          .deleteApiResponse("${AppConstants.requestUrl}/$requestId");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AcceptedRide>> fetchMyRides(String token) async {
    try {
      dynamic response = await _apiServices.getApiResponse(
          "${AppConstants.userUrl}/${AppConstants.acceptedRides}/$token");
      List<AcceptedRide> myRides = (response['acceptedRides'] as List<dynamic>)
          .map((ride) => AcceptedRide.fromJson(ride))
          .toList();
      return myRides;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateVehicleNumber(String token, dynamic data) async {
    try {
      dynamic response = await _apiServices.patchApiResponse(
          "${AppConstants.userUrl}/update-vehicle/$token", data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
