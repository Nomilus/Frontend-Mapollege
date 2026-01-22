import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapollege/core/api/people/auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mapollege/core/api/people/user_api.dart';
import 'package:mapollege/core/model/people/user_model.dart';
import 'package:mapollege/core/service/dio_service.dart';
import 'package:mapollege/core/utility/error_utility.dart';
import 'package:mapollege/core/utility/snackbar_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final AuthApi _authApi = AuthApi(Get.find<DioService>());
  final UserApi _userApi = UserApi(Get.find<DioService>());

  late final SharedPreferences _prefs;

  final List<String> _scopes = ['email', 'profile'];
  bool _isGoogleSignInInitialized = false;

  final Rxn<UserModel> currentUser = Rxn<UserModel>();
  final RxBool isLoggedIn = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isChecking = false.obs;

  @override
  void onInit() {
    super.onInit();
    SharedPreferences.getInstance().then((p) {
      _prefs = p;
      _initialize();
    });
  }

  Future<void> _initialize() async {
    isChecking(true);
    await _initializeService();
    await _refreshToken();
    isChecking(false);
  }

  Future<void> _refreshToken() async {
    final String? refreshToken = _prefs.getString('refresh_token');

    if (refreshToken == null) {
      isLoggedIn(false);
      return;
    }

    final response = await _authApi.refreshToken(refreshToken: refreshToken);

    if (response != null) {
      await _prefs.setString("refresh_token", response.data.refreshToken);
      await _loadProfile(response.data.accessToken);
    } else {
      isLoggedIn(false);
      return;
    }
  }

  Future<void> _verifyToken(String idToken) async {
    final response = await _authApi.verifyToken(firebaseToken: idToken);

    if (response != null) {
      await _prefs.setString("refresh_token", response.data.refreshToken);
      await _loadProfile(response.data.accessToken);
      isLoading(false);
    } else {
      isLoggedIn(false);
      isLoading(false);
      return;
    }
  }

  Future<void> _loadProfile(String accessToken) async {
    await _prefs.setString("access_token", accessToken);
    final user = await _userApi.getProfile();
    currentUser(user?.data);
    isLoggedIn(true);
  }

  Future<void> _initializeService() async {
    if (!_isGoogleSignInInitialized) {
      try {
        await _googleSignIn.initialize(
          clientId: dotenv.env['GOOGLE_CLIENT_ID'],
        );
        _isGoogleSignInInitialized = true;
      } catch (e) {
        SnackbarUtility.error(
          title: 'เริ่มต้นระบบไม่สำเร็จ',
          message: 'กรุณาลองเปิดแอปใหม่อีกครั้ง',
        );
      }
    }
  }

  Future<void> _firebaseSignIn(GoogleSignInAccount? account) async {
    try {
      if (account == null) {
        return;
      }

      final authorizationClient = account.authorizationClient;
      GoogleSignInClientAuthorization? authorization = await authorizationClient
          .authorizationForScopes(_scopes);

      final idToken = account.authentication.idToken;
      final accessToken = authorization?.accessToken;

      if (accessToken == null) {
        try {
          final authorizationAgain = await account.authorizationClient
              .authorizeScopes(_scopes);
          authorization = authorizationAgain;
        } catch (e) {
          SnackbarUtility.error(
            title: 'ต้องการสิทธิ์การเข้าถึง',
            message: 'กรุณาอนุญาตสิทธิ์ที่จำเป็นเพื่อเข้าสู่ระบบ',
          );
        }
      }

      if (idToken == null) {
        SnackbarUtility.error(
          title: 'เกิดข้อผิดพลาด',
          message: 'ไม่สามารถยืนยันตัวตนได้ กรุณาลองใหม่อีกครั้ง',
        );
        return;
      }

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );

      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);

      await _verifyToken(await userCredential.user?.getIdToken() ?? '');
    } on GoogleSignInException catch (e) {
      ErrorUtility.handleGoogleSignInException(e);
    } on FirebaseAuthException catch (e) {
      ErrorUtility.handleFirebaseAuthException(e);
    } catch (e) {
      SnackbarUtility.error(
        title: 'เกิดข้อผิดพลาด',
        message: 'ไม่สามารถเข้าสู่ระบบได้ กรุณาลองใหม่อีกครั้ง',
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> signInGoogle() async {
    await _initializeService();
    await _googleSignIn.disconnect().catchError((_) => null);
    if (!_googleSignIn.supportsAuthenticate()) {
      SnackbarUtility.error(
        title: 'ไม่รองรับ',
        message: 'อุปกรณ์ของคุณไม่รองรับการเข้าสู่ระบบด้วย Google',
      );
      return;
    }

    isLoading(true);
    try {
      if (_scopes.isEmpty) {
        SnackbarUtility.info(
          title: 'แจ้งเตือน',
          message: 'การเข้าสู่ระบบถูกยกเลิก',
        );
      }

      final GoogleSignInAccount account = await _googleSignIn.authenticate(
        scopeHint: _scopes,
      );

      await _firebaseSignIn(account);
    } on GoogleSignInException catch (e) {
      ErrorUtility.handleGoogleSignInException(e);
    } on FirebaseAuthException catch (e) {
      ErrorUtility.handleFirebaseAuthException(e);
    } catch (e) {
      SnackbarUtility.error(
        title: 'เกิดข้อผิดพลาด',
        message: 'ไม่สามารถเข้าสู่ระบบได้ กรุณาลองใหม่อีกครั้ง',
      );
    }
  }

  Future<void> signInEmail({
    required String email,
    required String password,
  }) async {
    isLoading(true);
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      await _verifyToken(await userCredential.user?.getIdToken() ?? '');
    } on GoogleSignInException catch (e) {
      ErrorUtility.handleGoogleSignInException(e);
    } on FirebaseAuthException catch (e) {
      ErrorUtility.handleFirebaseAuthException(e);
    } catch (e) {
      SnackbarUtility.error(
        title: 'เกิดข้อผิดพลาด',
        message: 'ไม่สามารถเข้าสู่ระบบได้ กรุณาลองใหม่อีกครั้ง',
      );
    }
  }

  Future<void> signOutGoogle() async {
    isLoading(true);
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      await _prefs.remove('refresh_token');
      await _prefs.remove('access_token');
      currentUser(null);
    } on GoogleSignInException catch (e) {
      ErrorUtility.handleGoogleSignInException(e);
    } on FirebaseAuthException catch (e) {
      ErrorUtility.handleFirebaseAuthException(e);
    } catch (e) {
      SnackbarUtility.error(
        title: 'เกิดข้อผิดพลาด',
        message: 'ไม่สามารถออกจากระบบได้ กรุณาลองใหม่อีกครั้ง',
      );
    } finally {
      isLoggedIn(false);
      isLoading(false);
    }
  }
}
