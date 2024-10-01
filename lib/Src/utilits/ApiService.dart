import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/AddProfileDetailModel.dart';
import 'package:getifyjobs/Models/AddProfileModel.dart';
import 'package:getifyjobs/Models/ApplyCampusJobModel.dart';
import 'package:getifyjobs/Models/ApplyDirectJobModel.dart';
import 'package:getifyjobs/Models/CampusCompanyListModel.dart';
import 'package:getifyjobs/Models/CampusEnrolledJobModel.dart';
import 'package:getifyjobs/Models/CampusJobDetailsModel.dart';
import 'package:getifyjobs/Models/CampusJobListModel.dart';
import 'package:getifyjobs/Models/CampusListModel.dart';
import 'package:getifyjobs/Models/CandidateProfileModel.dart';
import 'package:getifyjobs/Models/CandidateUpdateModel.dart';
import 'package:getifyjobs/Models/DirectJobDetailsModel.dart';
import 'package:getifyjobs/Models/DirectJobListModel.dart';
import 'package:getifyjobs/Models/ForgotMobileNumberModel.dart';
import 'package:getifyjobs/Models/GetPaymentIdModel.dart';
import 'package:getifyjobs/Models/InboxModel.dart';
import 'package:getifyjobs/Models/JobFeedBackModel.dart';
import 'package:getifyjobs/Models/LoginModel.dart';
import 'package:getifyjobs/Models/NotificationModel.dart';
import 'package:getifyjobs/Models/PaymentSuccessModel.dart';
import 'package:getifyjobs/Models/ResetPasswordModel.dart';
import 'package:getifyjobs/Models/StudentCampusMyAppliesListModel.dart';
import 'package:getifyjobs/Models/StudentDirectMyAppliesListModel.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/MakeApiCall.dart';
import 'package:getifyjobs/Src/utilits/loading_overlay.dart';

import '../../Models/CollegePrfileModel.dart';
import '../../Models/OtpModel.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.interceptors.add(LogInterceptor(responseBody: true)); // For debugging
  return dio;
});

// final apiServiceProvider = Provider<ApiService>((ref) {
//   final dio = ref.read(dioProvider);
//   return ApiService(dio);
// });
//
// class ApiService {
//   final Dio _dio;
//   ApiService(this._dio);
//
// }

class ApiService {
  final Dio _dio;
  ApiService(this._dio);

  T _fromJson<T>(dynamic json) {
    if (json != null) {
    } else {
      final jsonResponse = {
        'status': false,
        'message': ConstantApi.SOMETHING_WRONG, //Server not responding
      };
      json = jsonResponse;
    }

    if (T == OtpModel) {
      return OtpModel.fromJson(json) as T;
    } else if (T == LoginModel) {
      return LoginModel.fromJson(json) as T;
    } else if (T == Collage_Profile) {
      return Collage_Profile.fromJson(json) as T;
    } else if (T == CampusListModel) {
      return CampusListModel.fromJson(json) as T;
    } else if (T == CampusJobListModel) {
      return CampusJobListModel.fromJson(json) as T;
    } else if (T == DirectJobListModel) {
      return DirectJobListModel.fromJson(json) as T;
    } else if (T == Job_details_model) {
      return Job_details_model.fromJson(json) as T;
    } else if (T == CampusCompanyListModel) {
      return CampusCompanyListModel.fromJson(json) as T;
    } else if (T == CampusJobDetailsModel) {
      return CampusJobDetailsModel.fromJson(json) as T;
    } else if (T == ApplyDirectJobModel) {
      return ApplyDirectJobModel.fromJson(json) as T;
    } else if (T == ApplyCampusJobModel) {
      return ApplyCampusJobModel.fromJson(json) as T;
    } else if (T == StudentDirectMyAppliesListModel) {
      return StudentDirectMyAppliesListModel.fromJson(json) as T;
    } else if (T == StudentCampusMyAppliesListModel) {
      return StudentCampusMyAppliesListModel.fromJson(json) as T;
    } else if (T == AddProfileDetailModel) {
      return AddProfileDetailModel.fromJson(json) as T;
    } else if (T == CandidateProfileModel) {
      return CandidateProfileModel.fromJson(json) as T;
    } else if (T == AddProfileModel) {
      return AddProfileModel.fromJson(json) as T;
    } else if (T == InboxModel) {
      return InboxModel.fromJson(json) as T;
    }else if (T == CandidateUpdateModel) {
      return CandidateUpdateModel.fromJson(json) as T;
    }else if (T == JobFeedBackModel) {
      return JobFeedBackModel.fromJson(json) as T;
    }else if (T == CampusEnrolledJobModel) {
      return CampusEnrolledJobModel.fromJson(json) as T;
    }else if (T == ForgotMobileNumber) {
      return ForgotMobileNumber.fromJson(json) as T;
    }else if (T == ResetPasswordModel) {
      return ResetPasswordModel.fromJson(json) as T;
    }else if (T == GetPaymentIdModel) {
      return GetPaymentIdModel.fromJson(json) as T;
    }else if (T == PaymentSuccessModel) {
      return PaymentSuccessModel.fromJson(json) as T;
    }else if (T == NotificationModel) {
      return NotificationModel.fromJson(json) as T;
    }

    // Add more conditionals for other model classes as needed
    throw Exception("Unknown model type");
  }

  Future<T?> loginUser<T>(
      FormData dict, T Function(Map<String, dynamic>) fromJson) async {
    final result = await requestPOST(
        url: ConstantApi.candidateLogin, formData: dict, dio: _dio);

    if (result["success"] == true) {
      final response = fromJson(json.decode(result["response"]));
      return response;
    }

    return null; // Return null if login was not successful
  }

  Future<T> _requestGET<T>(
    BuildContext context,
    String path,
  ) async {
    LoadingOverlay.show(context);

    try {
      final response = await _dio.get(path);

      // Future.delayed(const Duration(seconds: 2), () {
      LoadingOverlay.hide();
      // });

      return _fromJson<T>(response.data);
    } on SocketException {
      final jsonResponse = {
        'status': false,
        'message': ConstantApi.NO_INTERNET
      };
      return _fromJson<T>(jsonResponse);
    } on FormatException {
      final jsonResponse = {
        'status': false,
        'message': ConstantApi.BAD_RESPONSE
      };
      return _fromJson<T>(jsonResponse);
    } on HttpException {
      final jsonResponse = {
        'status': false,
        'message': ConstantApi.SOMETHING_WRONG //Server not responding
      };
      return _fromJson<T>(jsonResponse);
    } on DioException catch (e) {
      // Handle DioError, you can log or display an error message.
      // Future.delayed(const Duration(seconds: 2), () {
      LoadingOverlay.hide();
      // });
      return _fromJson<T>(e.response?.data);
    } catch (e) {
      // Handle other exceptions here
      // Future.delayed(const Duration(seconds: 2), () {
      LoadingOverlay.hide();
      // });
      throw e;
    }
  }

  Future<T> _requestPOST<T>(
    BuildContext context,
    String path, {
    FormData? data,
  }) async {
    LoadingOverlay.show(context);

    try {
      final response = await _dio.post(path, data: data);

      Future.delayed(const Duration(seconds: 1), () {
      LoadingOverlay.hide();
      });

      return _fromJson<T>(response.data);
    } on SocketException {
      final jsonResponse = {
        'success': false,
        'response': ConstantApi.NO_INTERNET
      };
      return _fromJson<T>(jsonResponse);
    } on FormatException {
      final jsonResponse = {
        'success': false,
        'response': ConstantApi.BAD_RESPONSE
      };
      return _fromJson<T>(jsonResponse);
    } on HttpException {
      final jsonResponse = {
        'success': false,
        'response': ConstantApi.SOMETHING_WRONG //Server not responding
      };
      return _fromJson<T>(jsonResponse);
    } on DioException catch (e) {
      LoadingOverlay.hide();

      // Handle other exceptions here
      // Future.delayed(const Duration(seconds: 2), () {
      return _fromJson<T>(e.response?.data);
      // Handle DioError, access e.response for more details

      // });
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> get<T>(BuildContext context, String path) async {
    return _requestGET<T>(context, path);
  }

  Future<T> post<T>(BuildContext context, String path, FormData data) async {
    return _requestPOST<T>(context, path, data: data);
  }



  Future<CandidateProfileModel> CandiateProfileApiService () async {
    var formData = FormData.fromMap({
      "candidate_id": await getcandidateId(),
    });
    final result = await requestPOST2(
        url: ConstantApi.candidateProfileUrl, formData: formData, dio: _dio);
    if (result["success"] == true) {
      print("PROFILE RESPONSE:$result");
      print("resultOTPsss:${result["success"]}");
      return CandidateProfileModel?.fromJson(result["response"]);
    } else {
      try {
        var resultval = CandidateProfileModel.fromJson(result["response"]);
        // Toast.show(resultval.message.toString(), context);
        print(result["response"]);
        return resultval;
      } catch (e) {
        print(result["response"]);
        // Toast.show(result["response"], context);
      }
    }
    return CandidateProfileModel();
  }

}


