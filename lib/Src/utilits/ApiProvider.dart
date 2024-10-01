import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/CandidateProfileModel.dart';

import 'ApiService.dart';


final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.read(dioProvider);
  return ApiService(dio);
});



//SIGNUP
final profileApiProvider = FutureProvider.autoDispose<CandidateProfileModel>((ref) async {
  return ref.watch(apiServiceProvider).CandiateProfileApiService();
});

