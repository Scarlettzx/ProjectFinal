import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project/controller/main_wrapper_controller.dart';
import 'package:project/pages/login_screen.dart';

// import '../core/authentication_manager.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final MainWrapperController controller = Get.find<MainWrapperController>();
    // AuthenticationManager authManager = Get.find();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() => Text(
              'Count ${controller.token.value}',
              style: const TextStyle(fontSize: 20),
            )),
        const Icon(
          IconlyLight.profile,
          size: 40,
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            // print(controller.token.value);
            // authManager.logOut();
            Get.offAll(const LoginScreen());
            controller.logOut();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              fixedSize: const Size(200, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
          child: const Text('logout'),
        ),
      ],
    );
  }
}
