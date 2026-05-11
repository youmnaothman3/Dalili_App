import 'dart:convert';

import 'package:get/get.dart' hide FormData, Response;
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  // ======================== GET Request ========================
  static Future<dynamic> get({
    required String url,
    String? token,
    bool sendToken = false,
  }) async {
    Map<String, String> headers = {'Accept': 'application/json'};

    if (sendToken) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedToken = prefs.getString('token');
      if (storedToken != null) headers['Authorization'] = 'Bearer $storedToken';
    } else if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    http.Response response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // محاولة استخراج رسالة الخطأ من الـ body إذا كانت موجودة
      var responseBody = response.body.isNotEmpty
          ? jsonDecode(response.body)
          : {};
      String errorMessage =
          responseBody['message'] ?? 'هناك مشكلة في ${response.statusCode}';
      throw Exception(errorMessage);
    }
  }

  // ======================== POST Request ========================
  static Future<dynamic> post({
    required String url,
    required dynamic body,
    String? token,
    bool sendToken = false,
  }) async {
    Map<String, String> headers = {
      // نرسل Body كـ JSON، لذا يجب تحديد هذا الهيدر
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (sendToken) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedToken = prefs.getString('token');
      if (storedToken != null) headers['Authorization'] = 'Bearer $storedToken';
    } else if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    print("📡 إرسال الطلب إلى: $url");
    print("🧾 Body المرسل: $body");

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: headers,
      );

      final responseBody = response.body.isNotEmpty
          ? jsonDecode(response.body)
          : {"message": "الرد كان فارغاً من السيرفر"};

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("📊 بيانات الاستجابة: $responseBody");
        return responseBody;
      } else {
        // إذا كان هناك خطأ (مثل 404, 401, 422, إلخ)، نقوم بإلقاء استثناء مع رسالة الخادم
        final errorMessage =
            responseBody["message"] ??
            "حدث خطأ غير متوقع (${response.statusCode})";
        print("❌ Post error (Server response): $errorMessage");
        throw Exception(errorMessage);
      }
    } catch (e) {
      // في حالة فشل الاتصال بالشبكة أو فك التشفير
      String errorMessage = e.toString().replaceFirst("Exception: ", "").trim();
      print("❌ Post error (Network/Decode): $errorMessage");

      // 💡 لا يتم عرض Get.snackbar هنا. ندع الـ Controller يعرضه.
      throw Exception(errorMessage);
    }
  }

  // ======================== DELETE Request ========================
  static Future<dynamic> delete({
    required String url,
    String? token,
    bool sendToken = false,
  }) async {
    Map<String, String> headers = {'Accept': 'application/json'};

    if (sendToken) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedToken = prefs.getString('token');
      if (storedToken != null) headers['Authorization'] = 'Bearer $storedToken';
    } else if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    try {
      print("🔴 إرسال طلب DELETE إلى: $url");

      final response = await http.delete(Uri.parse(url), headers: headers);

      final responseBody = response.body.isNotEmpty
          ? jsonDecode(response.body)
          : {"message": "الرد كان فارغاً من السيرفر"};

      if (response.statusCode == 200 || response.statusCode == 204) {
        return responseBody;
      } else {
        final errorMessage = responseBody["message"] ?? "حدث خطأ غير متوقع";
        print("❌ Delete error (Server response): $errorMessage");
        throw Exception(errorMessage);
      }
    } catch (e) {
      String errorMessage = e.toString().replaceFirst("Exception: ", "").trim();
      // 💡 يتم عرض SnackBar هنا، ولكن من الأفضل أن يعرضها الـ Controller
      Get.snackbar("خطأ في الحذف", errorMessage);
      print("❌ Delete error (Network/Decode): $errorMessage");
      throw Exception(errorMessage);
    }
  }
}
