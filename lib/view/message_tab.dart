import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:project/controller/profile_controller.dart';
import 'package:project/utils/color.constants.dart';
import 'package:project/view/showfollowers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/config.dart';

class MessageTab extends StatefulWidget {
  const MessageTab({Key? key}) : super(key: key);

  @override
  State<MessageTab> createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  final ProfileController profileController = Get.find();
  // late var isloading = true;
  // final ProfileController profileController = Get.put(ProfileController());
  // final ProfileController profileController = Get.find();
  // Map<String, dynamic>? profileDetail; // Declare profileDetail as nullable

  @override
  void initState() {
    super.initState();
    // Call loadProfileData to fetch the profile data
    profileController.loadProfileData();
    profileController.profileid.value =
        profileController.profileDetail!['userId'];
    profileController.followers();
    print("initState ========== followings");
    profileController.following();
    print("initStatte");
    print(profileController.personIdList);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (profileController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        final profileDetail = profileController.profileDetail?.value;
        if (profileDetail != null) {
          return ListView(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          image: DecorationImage(
                            image: NetworkImage(
                                '${Config.getImage}${profileDetail['userAvatar']}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 225.0,
                    top: 90,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {},
                      child: Container(
                        height: 25.0,
                        width: 25.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Icon(
                          IconlyBold.edit,
                          color: ColorConstants.appColors,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(profileDetail['userName']), // Use profileDetail
                  Text(profileDetail['userPosition']), // Use profileDetail
                  Text(profileDetail['userCountry']), // Use profileDetail
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ! followers
                          Ink(
                            width: 70,
                            height: 50,
                            child: InkWell(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              splashColor: ColorConstants.gray100,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                print('followersbutton');
                                // print(profileController.personIdList);
                                profileController.selectedList.value =
                                    'followers';
                                Get.to(
                                  () => ShowFollowers(),
                                  transition: Transition.downToUp,
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(profileController.countFollowers
                                      .toString()),
                                  Text(
                                    'followers',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 20,
                              child: Text(
                                '|',
                                textAlign: TextAlign
                                    .center, // ตั้งค่าการจัดวางให้เป็นกลาง
                                style: TextStyle(
                                  fontSize: 20,
                                  // fontWeight: FontWeight.w600,
                                  // ปรับขนาดตามความต้องการ
                                ),
                              ),
                            ),
                          ),
                          Ink(
                            width: 70,
                            height: 50,
                            child: InkWell(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              splashColor: ColorConstants.gray100,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                // print(profileController.following());
                                print('followeringbutton');
                                // print(profileController.personIdList);
                                profileController.selectedList.value =
                                    'following';
                                Get.to(
                                  () => ShowFollowers(),
                                  transition: Transition.downToUp,
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(profileController.countFollowing
                                      .toString()),
                                  Text(
                                    'follwing',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ],
          );
        } else {
          return Text('No profile data available.');
        }
      }
    });
  }
}
// Container(
//       color: ColorConstants.gray50,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "Message",
//             style: Theme.of(context).textTheme.headline1,
//           ),
//           const Icon(
//             IconlyLight.message,
//             size: 40,
//           ),
//         ],
//       ),
//     );