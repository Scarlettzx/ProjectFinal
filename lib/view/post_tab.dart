// ignore_for_file: deprecated_member_use, unused_import, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project/controller/profile_controller.dart';
import 'package:project/view/another_profile_tab.dart';
import 'package:project/components/Mypost.dart';
import 'package:project/controller/posts_controller.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project/view/add_post.dart';
import 'package:project/view/post_detail.dart';
// import '../components/Post.dart';
import '../controller/Video_wrap_controller.dart';
import '../controller/comments_controller.dart';
import '../data/models/dropdown_province_model.dart';
import '../pages/api_provider.dart';
import '../utils/color.constants.dart';
import '../utils/config.dart';

class PostTab extends StatefulWidget {
  // เพิ่มพารามิเตอร์เพื่อรับข้อมูล

  const PostTab({Key? key}) : super(key: key);

  @override
  State<PostTab> createState() => _PostTabState();
}

class _PostTabState extends State<PostTab> {
  // void updatePost(String value) {
  //   setState(() {
  //     if (selectedCity == 'All' && selectedRole == 'All') {
  //       display_post = _post
  //           .where((element) =>
  //               element.username.toLowerCase().contains(value.toLowerCase()))
  //           .toList();
  //     } else if (selectedCity == 'All') {
  //       display_post = _post
  //           .where((element) =>
  //               element.username.toLowerCase().contains(value.toLowerCase()) &&
  //               element.role.toLowerCase().contains(selectedRole.toLowerCase()))
  //           .toList();
  //     } else if (selectedRole == 'All') {
  //       display_post = _post
  //           .where((element) =>
  //               element.username.toLowerCase().contains(value.toLowerCase()) &&
  //               element.city.toLowerCase().contains(selectedCity.toLowerCase()))
  //           .toList();
  //     } else {
  //       display_post = _post
  //           .where((element) =>
  //               element.username.toLowerCase().contains(value.toLowerCase()) &&
  //               element.city
  //                   .toLowerCase()
  //                   .contains(selectedCity.toLowerCase()) &&
  //               element.role.toLowerCase().contains(selectedRole.toLowerCase()))
  //           .toList();
  //     }
  //   });
  // }

  // void updatePost_Role(String value) {
  //   setState(() {
  //     if (value == 'All' && selectedCity == 'All') {
  //       display_post = _post
  //           .where((element) => element.username
  //               .toLowerCase()
  //               .contains(selectedUsername.toLowerCase()))
  //           .toList();
  //     } else if (value == 'All') {
  //       display_post = _post
  //           .where((element) =>
  //               element.city
  //                   .toLowerCase()
  //                   .contains(selectedCity.toLowerCase()) &&
  //               element.username
  //                   .toLowerCase()
  //                   .contains(selectedUsername.toLowerCase()))
  //           .toList();
  //     } else if (selectedCity == 'All') {
  //       display_post = _post
  //           .where((element) =>
  //               element.role.toLowerCase().contains(value.toLowerCase()) &&
  //               element.username
  //                   .toLowerCase()
  //                   .contains(selectedUsername.toLowerCase()))
  //           .toList();
  //     } else {
  //       display_post = _post
  //           .where((element) =>
  //               element.role.toLowerCase().contains(value.toLowerCase()) &&
  //               element.city
  //                   .toLowerCase()
  //                   .contains(selectedCity.toLowerCase()) &&
  //               element.username
  //                   .toLowerCase()
  //                   .contains(selectedUsername.toLowerCase()))
  //           .toList();
  //     }
  //   });
  // }

  // void updatePost_city(String value) {
  //   setState(() {
  //     if (value == 'All' && selectedRole == 'All') {
  //       display_post = _post
  //           .where((element) => element.username
  //               .toLowerCase()
  //               .contains(selectedUsername.toLowerCase()))
  //           .toList();
  //     } else if (value == 'All') {
  //       display_post = _post
  //           .where((element) =>
  //               element.role
  //                   .toLowerCase()
  //                   .contains(selectedRole.toLowerCase()) &&
  //               element.username
  //                   .toLowerCase()
  //                   .contains(selectedUsername.toLowerCase()))
  //           .toList();
  //     } else if (selectedRole == 'All') {
  //       display_post = _post
  //           .where((element) =>
  //               element.city.toLowerCase().contains(value.toLowerCase()) &&
  //               element.username
  //                   .toLowerCase()
  //                   .contains(selectedUsername.toLowerCase()))
  //           .toList();
  //     } else {
  //       display_post = _post
  //           .where((element) =>
  //               element.city.toLowerCase().contains(value.toLowerCase()) &&
  //               element.role
  //                   .toLowerCase()
  //                   .contains(selectedRole.toLowerCase()) &&
  //               element.username
  //                   .toLowerCase()
  //                   .contains(selectedUsername.toLowerCase()))
  //           .toList();
  //     }
  //   });
  // }
// Define a variable to hold the selected filter value
  // String selectedFilter = 'All';
  @override
  Widget build(BuildContext context) {
    String? selectedValueProvince;
    ApiProvider apiProvider = ApiProvider();
    final PostsController _controller = Get.put(PostsController());
    final ProfileController _profilecontroller = Get.put(ProfileController());
    final CommentsController _commentcontroller = Get.put(CommentsController());
    TextEditingController _searchController = TextEditingController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.appColors,
        child: const Icon(Icons.add), //child widget inside this button
        onPressed: () {
          Get.to(const AddPost(), transition: Transition.downToUp);
        },
      ),
      // backgroundColor: ColorConstants.gray100, // กำหนดสีพื้นหลังที่ต้องการ
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true, // เพื่อให้ SearchBar หายไปเมื่อเลื่อนลง
            backgroundColor: ColorConstants.appColors,
            title: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintText: 'ข้อมูลที่ต้องการค้นหา',
                  contentPadding: EdgeInsets.only(
                    left: 15.0,
                  ),
                ),
                controller: _searchController,
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<List<ProvinceDropdownModel>>(
                future: apiProvider.fetchProvinceData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Obx(() => DropdownButtonFormField(
                        // validator: _provinceValidator,
                        menuMaxHeight: 700,
                        style: TextStyle(
                          color: ColorConstants.gray600,
                        ),
                        // autofocus: true,
                        icon: Icon(
                          Icons.arrow_drop_down_circle,
                          color: ColorConstants.appColors,
                        ),
                        // value: selectedValue,
                        decoration: InputDecoration(
                          hintText: "Select Province",
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 192, 192, 192)),
                          fillColor: const Color.fromARGB(255, 237, 237, 237),
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.location_on,
                            color: Color(0xFFB3B3B3),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 52, 230, 168),
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        ),
                        items: snapshot.data?.map((e) {
                          return DropdownMenuItem(
                              value: e.nameTh.toString(),
                              child: Text(e.nameTh.toString()));
                        }).toList(),
                        value: _controller.selectProvice.value != ''
                            ? _controller.selectProvice.value
                            : null,
                        onChanged: (value) {
                          _controller.selectProvice.value = value!;
                          print(_controller.selectProvice.value);
                        }));
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
          Obx(() {
            final isLoading = _controller.isLoading.value;
            
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int i) {
                  // สร้างรายการรายการ ListView ของคุณที่นี่
                  var reverseindex = _controller.posts.length - 1 - i;
                  var postid = _controller.posts[reverseindex].postId;
                  var profileid =
                      _controller.posts[reverseindex].createByid.userId;
                  DateTime _datetime =
                      _controller.posts[reverseindex].postCreateAt;
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ListTile(
                      onTap: () {
                        _commentcontroller.postid.value = postid;
                        print(_commentcontroller.postid.value);
                        _commentcontroller.getCommentsBypostid();
                        Get.to(
                          PostDetail(
                              _controller.posts[reverseindex].postMessage),
                          transition:
                              Transition.downToUp, // ใช้ transition ตรงนี้
                        );
                      },
                      tileColor: Colors.amber,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              _controller.posts[reverseindex].postMessage,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            ),
                          ),
                          Text(
                            GetTimeAgo.parse(_datetime),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_controller
                              .posts[reverseindex].createByid.userName),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              _profilecontroller.profileid.value = profileid;
                              _profilecontroller.checkfollow();
                              Get.to(
                                AnotherProfileTab(
                                  userId: profileid,
                                  userAvatar: _controller.posts[reverseindex]
                                      .createByid.userAvatar,
                                  userName: _controller
                                      .posts[reverseindex].createByid.userName,
                                  userPosition: _controller.posts[reverseindex]
                                      .createByid.userPosition,
                                  userCountry: _controller.posts[reverseindex]
                                      .createByid.userCountry,
                                ),
                                transition: Transition.downToUp,
                              );
                              print(_controller.posts[reverseindex].createByid
                                  .userId.runtimeType);
                              print(_controller
                                  .posts[reverseindex].createByid.userId);
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              backgroundImage: _controller.posts[reverseindex]
                                          .createByid.userAvatar ==
                                      ''
                                  ? null
                                  : NetworkImage(
                                      '${Config.getImage}${_controller.posts[reverseindex].createByid.userAvatar}'),
                            ),
                          ),
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
                childCount: _controller.posts.length,
              ),
            );
            // return Visibility(
            //   visible: !isLoading,
            //   child: ListView.builder(
            //     physics:
            //         const AlwaysScrollableScrollPhysics(), // ช่วยให้ ListView ขยายตามข้อมูล
            //     padding: const EdgeInsets.all(5.0),
            //     // reverse: true,
            //     shrinkWrap: true, // ให้ ListView ขยายตามเนื้อหาของมัน
            //     itemCount: _controller.posts.length,
            //     itemBuilder: (context, i) {
            // var reverseindex = _controller.posts.length - 1 - i;
            // var postid = _controller.posts[reverseindex].postId;
            // var profileid =
            //     _controller.posts[reverseindex].createByid.userId;
            // DateTime _datetime =
            //     _controller.posts[reverseindex].postCreateAt;
            // return Padding(
            //   padding: const EdgeInsets.all(2.0),
            //   child: ListTile(
            //     onTap: () {
            //       _commentcontroller.postid.value = postid;
            //       print(_commentcontroller.postid.value);
            //       _commentcontroller.getCommentsBypostid();
            //       Get.to(
            //         PostDetail(
            //             _controller.posts[reverseindex].postMessage),
            //         transition:
            //             Transition.downToUp, // ใช้ transition ตรงนี้
            //       );
            //     },
            //     tileColor: Colors.amber,
            //     title: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Expanded(
            //           child: Text(
            //             _controller.posts[reverseindex].postMessage,
            //             overflow: TextOverflow.ellipsis,
            //             maxLines: 5,
            //           ),
            //         ),
            //         Text(
            //           GetTimeAgo.parse(_datetime),
            //         ),
            //       ],
            //     ),
            //     subtitle: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(_controller
            //             .posts[reverseindex].createByid.userName),
            //         InkWell(
            //           splashColor: Colors.transparent,
            //           highlightColor: Colors.transparent,
            //           onTap: () {
            //             _profilecontroller.profileid.value = profileid;
            //             _profilecontroller.checkfollow();
            //             Get.to(
            //               AnotherProfileTab(
            //                 userId: profileid,
            //                 userAvatar: _controller.posts[reverseindex]
            //                     .createByid.userAvatar,
            //                 userName: _controller
            //                     .posts[reverseindex].createByid.userName,
            //                 userPosition: _controller.posts[reverseindex]
            //                     .createByid.userPosition,
            //                 userCountry: _controller.posts[reverseindex]
            //                     .createByid.userCountry,
            //               ),
            //               transition: Transition.downToUp,
            //             );
            //             print(_controller.posts[reverseindex].createByid
            //                 .userId.runtimeType);
            //             print(_controller
            //                 .posts[reverseindex].createByid.userId);
            //           },
            //           child: CircleAvatar(
            //             radius: 50,
            //             backgroundColor: Colors.transparent,
            //             backgroundImage: _controller.posts[reverseindex]
            //                         .createByid.userAvatar ==
            //                     ''
            //                 ? null
            //                 : NetworkImage(
            //                     '${Config.getImage}${_controller.posts[reverseindex].createByid.userAvatar}'),
            //           ),
            //         ),
            //       ],
            //     ),
            //     isThreeLine: true,
            //   ),
            // );
            //     },
            //   ),
            // );
            // Visibility(
            //     visible: isLoading,
            //     child: Center(
            //       child: LoadingAnimationWidget.dotsTriangle(
            //         color: ColorConstants.appColors,
            //         size: 50,
            //       ),
            //     )),
            //   ],
            // );
            // );
          }),
        ],
      ),
    );
  }
}

                  // return Column(
                  //   children: [
                  //     Ink(
                  //       color: Colors.amber,
                  //       child: Container(
                  //         // alignment: Alignment.topLeft,
                  //         height: 150,
                  //         child: ListTile(
                  //           title: Text(
                  //               _controller.posts[reverseindex].postMessage),
                  //           subtitle: Column(
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             children: [
                  //               Text(_controller
                  //                   .posts[reverseindex].createByid.userName),
                  //               Text(_controller.posts[reverseindex].createByid
                  //                   .userPosition),
                  //             ],
                  //           ),
                  //           trailing: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.end,
                  //             children: [
                  //               Text(
                  //                 _controller.posts[reverseindex].postCreateAt
                  //                     .toString(),
                  //                 style: TextStyle(color: Colors.grey),
                  //               ),
                  //               SizedBox(
                  //                 height: 10,
                  //               ),
                  //               Container(
                  //                 // padding: EdgeInsets.only(left: 30.0),
                  //                 width: 90,
                  //                 height: 90,
                  //                 // color: Colors.white,
                  //                 // margin: EdgeInsets.only(left: 20.0),
                  //                 child: CircleAvatar(
                  //                   radius: 80,
                  //                   backgroundColor: Colors.transparent,
                  //                   backgroundImage: _controller
                  //                               .posts[reverseindex]
                  //                               .createByid
                  //                               .userAvatar ==
                  //                           ''
                  //                       ? null
                  //                       : NetworkImage(
                  //                           '${Config.getImage}${_controller.posts[reverseindex].createByid.userAvatar}'),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           onTap: () {
                  //             Get.to(
                  //               PostDetail(_controller
                  //                   .posts[reverseindex].postMessage),
                  //               transition: Transition
                  //                   .downToUp, // ใช้ transition ตรงนี้
                  //             );
                  //             // Get.off(PageTransition(
                  //             //     type: PageTransitionType.bottomToTop, //bottom
                  //             //     child: const PostDetail(),
                  //             //     childCurrent: this));
                  //           },
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(height: 10),
                  //   ],
                  // );
