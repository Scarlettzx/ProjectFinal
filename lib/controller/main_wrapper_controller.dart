import 'package:project/controller/profile_controller.dart';
import 'package:project/view/band_tab.dart';
import 'package:project/view/message_tab.dart';
import 'package:project/view/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/authentication_manager.dart';
import '../pages/login_screen.dart';
import '../view/home_tab.dart';

class MainWrapperController extends GetxController {
  late PageController pageController;
  // late TabController tabController;
  // final AuthenticationManager _authManager = Get.find();

  // ? Varaible for changing index of Bottom AppBar
  // RxInt currentHomeTab = 0.obs;
  RxString token = ''.obs;
  // var isLogged = false.obs;
  RxInt currentPage = 0.obs;
  RxBool isDarkTheme = false.obs;
  final ProfileController profileController = Get.put(ProfileController());
  List<Widget> pages = [
    const HomeTab(),
    const BandTab(),
    const MessageTab(),
    const ProfileTab(),
  ];
  ThemeMode get theme => Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void switchTheme(ThemeMode mode) {
    Get.changeThemeMode(mode);
  }

  void setToken(String newToken) {
    token.update((value) {
      value = newToken;
      token.value = value;
    });
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    // _authManager.logOut();
    Get.offAll(const LoginScreen());
  }

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  void animateToTab(int page) {
    currentPage.value = page;
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  //! เมื่อเริ่มต้น MainWrapperController จะทำงาน
  void onInit() {
    pageController = PageController(initialPage: 0);
    // profileController.getProfileFromToken();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
