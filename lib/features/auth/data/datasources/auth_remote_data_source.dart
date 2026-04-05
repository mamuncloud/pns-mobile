import 'package:dio/dio.dart';
import 'package:pns_mobile/core/constants/app_constants.dart';
import 'package:pns_mobile/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> requestLogin(String identifier);
  Future<Map<String, dynamic>> verifyLogin(String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<void> requestLogin(String identifier) async {
    try {
      await dio.post(
        AppConstants.requestLoginEndpoint,
        data: {'identifier': identifier},
      );
    } on DioException catch (e) {
      throw ServerException(e.response?.data['message'] ?? 'Gagal mengirim tautan login');
    }
  }

  @override
  Future<Map<String, dynamic>> verifyLogin(String token) async {
    try {
      final response = await dio.get(
        AppConstants.verifyLoginEndpoint,
        queryParameters: {'token': token},
      );
      
      final data = response.data;
      return {
        'access_token': data['access_token'],
        'user': UserModel.fromJson(data['user']),
      };
    } on DioException catch (e) {
      throw ServerException(e.response?.data['message'] ?? 'Verifikasi gagal');
    }
  }
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}
