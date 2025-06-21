import 'package:bloc_todo/api/repositories/repository.dart';
import 'package:bloc_todo/components/response.modal.dart';
import 'package:bloc_todo/constants/keys.dart';
import 'package:bloc_todo/dtos/auth.request.dto.dart';
import 'package:bloc_todo/dtos/http.request.dto.dart';
import 'package:bloc_todo/enums/dialog.variants.dart';
import 'package:bloc_todo/models/auth.response.dart';
import 'package:bloc_todo/routes/app.routes.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final Repository repository;

  AuthController({required this.repository});

  //
  var loading = false;
  AuthResponse? authResponse;

  //handle sign in
  Future<void> handleSignIn(AuthRequestDto authRequest) async {
    try {
      loading = true;
      update();
      var data = authRequest.toJson();
      var httpRequest = HttpRequestDto("/api/authentication/login", data: data);
      var res = await repository.postAsync(httpRequest);
      if (!res.isSuccessful) {
        loading = false;
        update();
        Get.dialog(
          ResponseModal(message: res.message, variant: DialogVariant.Error),
        );
        return;
      }
      authResponse = AuthResponse.fromJson(res.data);
      loading = false;
      update();
      if (authResponse != null) {
        await repository.saveAuthUser(authResponse!);
        Get.offAllNamed(AppRoutes.home);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error during sign in: $e");
      }
      loading = false;
      update();
      Get.dialog(
        ResponseModal(
          message: "Sorry,an error occurred",
          variant: DialogVariant.Error,
        ),
      );
    }
  }

  //handle sign out
  Future<void> handleSignOut() async {
    try {
      loading = true;
      update();
      var authUser = await repository.getAuthUser();

      var request = HttpRequestDto(
        "/api/authentication/logout",
        token: authUser?.token,
      );
      await repository.postAsync(request);
      await repository.removeFromLocalStorage(Keys.User);
      authResponse = null;
      loading = false;
      update();

      Get.offAllNamed(AppRoutes.welcomeScreen);
    } catch (e) {
      if (kDebugMode) {
        print("Error during sign out: $e");
      }
      loading = false;
      update();
      await repository.removeFromLocalStorage(Keys.User);
      Get.offAllNamed(AppRoutes.welcomeScreen);
    }
  }

  //handle sign up
  Future<void> handleSignUp(AuthRequestDto authRequest) async {
    try {
      loading = true;
      update();
      var data = authRequest.toJson();
      var httpRequest = HttpRequestDto(
        "/api/authentication/register",
        data: data,
      );
      var res = await repository.postAsync(httpRequest);
      if (!res.isSuccessful) {
        loading = false;
        update();
        Get.dialog(
          ResponseModal(message: res.message, variant: DialogVariant.Error),
        );
        return;
      }
      authResponse = AuthResponse.fromJson(res.data);
      loading = false;
      update();
      if (authResponse != null) {
        await repository.saveAuthUser(authResponse!);
        Get.offAllNamed(AppRoutes.home);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error during sign up: $e");
      }
      loading = false;
      update();
      Get.dialog(
        ResponseModal(
          message: "Sorry, an error occurred",
          variant: DialogVariant.Error,
        ),
      );
    }
  }
}
