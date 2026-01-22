import 'package:flutter/foundation.dart';
import 'package:mapollege/core/utility/snackbar_utility.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ErrorUtility {
  static void handleGoogleSignInException(
    GoogleSignInException e, {
    bool showCancelMessage = true,
  }) {
    debugPrint('Google error ${e.toString()}');
    switch (e.code) {
      case GoogleSignInExceptionCode.canceled:
        if (showCancelMessage) {
          SnackbarUtility.error(
            title: 'แจ้งเตือน',
            message: 'คุณได้ยกเลิกการเข้าสู่ระบบ',
          );
        }
        break;
      case GoogleSignInExceptionCode.unknownError:
        SnackbarUtility.error(
          title: 'เกิดข้อผิดพลาด',
          // message: 'ไม่สามารถเข้าสู่ระบบด้วย Google ได้ กรุณาลองใหม่อีกครั้ง',
          message: '${e.description}',
        );
        break;
      default:
        SnackbarUtility.error(
          title: 'เกิดข้อผิดพลาด',
          message: 'ไม่สามารถเข้าสู่ระบบด้วย Google ได้: ${e.description}',
        );
    }
  }

  static void handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'account-exists-with-different-credential':
        SnackbarUtility.error(
          title: 'บัญชีมีอยู่แล้ว',
          message: 'อีเมลนี้ถูกใช้งานแล้ว กรุณาเข้าสู่ระบบด้วยวิธีที่คุณเคยใช้',
        );
        break;
      case 'invalid-credential':
        SnackbarUtility.error(
          title: 'ข้อมูลไม่ถูกต้อง',
          message: 'ข้อมูลการเข้าสู่ระบบไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง',
        );
        break;
      case 'user-disabled':
        SnackbarUtility.error(
          title: 'บัญชีถูกระงับ',
          message: 'บัญชีของคุณถูกระงับการใช้งาน กรุณาติดต่อผู้ดูแลระบบ',
        );
        break;
      case 'too-many-requests':
        SnackbarUtility.error(
          title: 'พยายามหลายครั้งเกินไป',
          message: 'กรุณารอสักครู่แล้วลองเข้าสู่ระบบใหม่อีกครั้ง',
        );
        break;
      case 'operation-not-allowed':
        SnackbarUtility.error(
          title: 'ไม่รองรับวิธีนี้',
          message: 'ขณะนี้ยังไม่รองรับการเข้าสู่ระบบด้วย Google',
        );
        break;
      default:
        SnackbarUtility.error(
          title: 'เกิดข้อผิดพลาด',
          message: 'ไม่สามารถยืนยันตัวตนได้: ${e.message}',
        );
    }
  }

  static void handleDioException(DioException e) {
    if (e.type == DioExceptionType.badResponse) {
      final statusCode = e.response?.statusCode;
      if (statusCode != null) {
        switch (statusCode) {
          case 400:
            SnackbarUtility.error(
              title: 'ข้อมูลไม่ถูกต้อง',
              message: 'กรุณาตรวจสอบข้อมูลและลองใหม่อีกครั้ง',
            );
            break;
          case 401:
            SnackbarUtility.error(
              title: 'กรุณาเข้าสู่ระบบใหม่',
              message: 'เซสชันของคุณหมดอายุแล้ว',
            );
            break;
          case 403:
            SnackbarUtility.error(
              title: 'ไม่มีสิทธิ์เข้าถึง',
              message: 'คุณไม่มีสิทธิ์ในการเข้าถึงข้อมูลนี้',
            );
            break;
          case 404:
            SnackbarUtility.error(
              title: 'ไม่พบข้อมูล',
              message: 'ไม่พบข้อมูลที่คุณต้องการ',
            );
            break;
          case 500:
            SnackbarUtility.error(
              title: 'เกิดข้อผิดพลาด',
              message: 'เกิดปัญหาที่เซิร์ฟเวอร์ กรุณาลองใหม่ภายหลัง',
            );
            break;
          default:
            SnackbarUtility.error(
              title: 'เกิดข้อผิดพลาด',
              message:
                  'เกิดข้อผิดพลาดในการเชื่อมต่อ (รหัส: ${e.response?.statusCode})',
            );
            break;
        }
      }
    } else if (e.type == DioExceptionType.connectionTimeout) {
      SnackbarUtility.error(
        title: 'หมดเวลาการเชื่อมต่อ',
        message: 'การเชื่อมต่อใช้เวลานานเกินไป กรุณาลองใหม่อีกครั้ง',
      );
    } else if (e.type == DioExceptionType.sendTimeout) {
      SnackbarUtility.error(
        title: 'หมดเวลาส่งข้อมูล',
        message: 'การส่งข้อมูลใช้เวลานานเกินไป กรุณาลองใหม่อีกครั้ง',
      );
    } else if (e.type == DioExceptionType.receiveTimeout) {
      SnackbarUtility.error(
        title: 'หมดเวลารับข้อมูล',
        message: 'การรับข้อมูลใช้เวลานานเกินไป กรุณาลองใหม่อีกครั้ง',
      );
    } else if (e.type == DioExceptionType.cancel) {
      SnackbarUtility.error(
        title: 'ยกเลิกการร้องขอ',
        message: 'คำขอถูกยกเลิกแล้ว',
      );
    } else if (e.type == DioExceptionType.connectionError) {
      SnackbarUtility.error(
        title: 'ไม่มีการเชื่อมต่ออินเทอร์เน็ต',
        message: 'กรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ตของคุณ',
      );
    }
  }
}
