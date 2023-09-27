// import 'dart:ffi';
//

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project/view/post_tab.dart';
import 'package:project/view/showfollowers.dart';
import '../controller/posts_controller.dart';
import '../controller/profile_controller.dart';
// import '../data/models/post_model.dart';
import '../utils/color.constants.dart';
import '../utils/config.dart';

class AnotherProfileTab extends StatefulWidget {
  final int userId;
  final String userName;
  final String userPosition;
  final String userCountry;
  final String userAvatar;

  const AnotherProfileTab({
    Key? key,
    required this.userAvatar,
    required this.userName,
    required this.userPosition,
    required this.userCountry,
    required this.userId,
  }) : super(key: key);

  @override
  State<AnotherProfileTab> createState() => _AnotherProfileTabState();
}

class _AnotherProfileTabState extends State<AnotherProfileTab> {
  final ProfileController profileController = Get.find();
  @override
  void initState() {
    super.initState();
    profileController.followers();
    profileController.following();
    // Call loadProfileData to fetch the profile data
  }

  final PostsController _postsController = Get.find<PostsController>();
  _loadDataPost() async {
    _postsController.getPosts();
    print(_postsController.posts.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    _loadDataPost();
                    Navigator.pop(
                      context,
                      PageTransition(
                        type: PageTransitionType.topToBottomPop,
                        child: PostTab(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            ListView(
              shrinkWrap: true,
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
                                  '${Config.getImage}${widget.userAvatar}'),
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
                        onTap: () {
                          // Handle edit button click
                        },
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
                    Text(widget.userName),
                    Text(widget.userPosition),
                    Text(widget.userCountry), // Use profileDetail
                    const SizedBox(
                      height: 10,
                    ),
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
                                  print('followersbutton_anotherprofile');
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
                                  print('followeringbutton_anotherprofile');
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
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() {
                          final bool shouldShowButton = widget.userId !=
                              profileController.profileDetail!['userId'];
                          return Visibility(
                            visible: shouldShowButton,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  profileController.isFollowing.value
                                      ? ColorConstants.unfollow
                                      : ColorConstants.appColors,
                                ),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.white,
                                ),
                              ),
                              onPressed: () {
                                if (profileController.isFollowing.value) {
                                  //! ถ้ากำลัง Following ให้ทำ Unfollow
                                  //! ทำการ Unfollow ที่นี่
                                  profileController.doUnfollow(widget.userId);
                                } else {
                                  //! ถ้าไม่ได้ Following ให้ทำ Follow
                                  profileController.dofollow(widget.userId);
                                  // profileController.toggleFollow();
                                }
                                print(
                                    profileController.profileDetail!['userId']);
                              },
                              child: Text(
                                profileController.isFollowing.value
                                    ? 'Unfollow'
                                    : 'Follow',
                              ),
                            ),
                          );
                        }),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                            ),
                          ),
                          onPressed: () {
                            // Handle button click
                          },
                          child: const Text("Invite"),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
