import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:project/data/models/profile_model.dart';
import 'package:project/utils/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  RxList<Map<String, dynamic>> personIdList = RxList<Map<String, dynamic>>();
  var isFollowing = false.obs;
  var countFollowing = 0.obs;
  RxInt countFollowers = 0.obs;
  var profilefollower = <ProfileModel>[].obs;
  var profileList = <ProfileModel>[].obs;
  var isLoading = true.obs;
  final RxInt profileid = 0.obs;
  final selectedList = "followers".obs;
  // Initialize profileDetail as an RxMap<String, dynamic>?
  RxMap<String, dynamic>? profileDetail;

  // Constructor to initialize profileDetail
  ProfileController() {
    profileDetail = <String, dynamic>{}.obs;
  }

  Future<void> loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      final Map<String, dynamic> decodedToken =
          JwtDecoder.decode(token)['result'];
      profileDetail!.value = {
        'userId': decodedToken['user_id'],
        'userCountry': decodedToken['user_country'],
        'userName': decodedToken['user_name'],
        'userPosition': decodedToken['user_position'],
        'userAvatar': decodedToken['user_avatar'],
      };
    }
    isLoading.value = false;
  }

  getProfile(userid) async {
    final response = await http
        .get(Uri.parse('${Config.endPoint}/api/users/getbyuserid/$userid'));
    try {
      if (response.statusCode == 200) {
        print(response.body);
        // final dynamic jsonData = jsonDecode(response.body);
        // final data = jsonDecode(response.body)['data'];

// 1. แปลง JSON ใน 'data' เป็น Map
        final Map<String, dynamic> data = jsonDecode(response.body)['data'];
        print(data.runtimeType);
        print(data);

// 2. สร้าง ProfileModel จากข้อมูลใน 'data'
        final ProfileModel profileModel = ProfileModel.fromJson(data);

// 3. เพิ่ม ProfileModel เข้าไปใน profileList
        profileList.add(profileModel);
        // final List<dynamic> result = jsonData["data"] as List<dynamic>;
        // print(result);
        // profileList.value =
        // result.map((e) => ProfileModel.fromJson(e).data).toList();

        isLoading.value = false;
        // update();
      } else if (response.statusCode == 404) {
        print(response.body);
      } else {
        Get.snackbar("Error Loading data",
            'Server Response: ${response.statusCode}:${response.reasonPhrase.toString()}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

// ! Addfollow
  Future<void> dofollow(int followersid) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(profileid.value);
    final Uri url = Uri.parse('${Config.endPoint}/api/users/addfollowers');
    // var body = {'followers_id': profileid.value};
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({'followers_id': followersid});
    final response = await http.post(url, headers: headers, body: body);
    print(response.body);
    try {
      if (response.statusCode == 409) {
        print('already follow');
        // isFollowing.value = true;
      } else if (response.statusCode == 200) {
        isFollowing.value = true;
        followers();
        following();
        // Handle other successful responses if needed
      } else {
        // Handle other error responses if needed
      }
    } catch (e) {
      print(e.toString());
    }
  }

// ! unfollow
  Future<void> doUnfollow(int followersid) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(profileid.value);
    final Uri url = Uri.parse('${Config.endPoint}/api/users/unfollowers');
    // var body = {'followers_id': profileid.value};
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({'followers_id': followersid});
    final response = await http.delete(url, headers: headers, body: body);
    print(response.body);
    try {
      if (response.statusCode == 200) {
        isFollowing.value = false;
        followers();
        following();
        // Handle other successful responses if needed
      } else {
        // Handle other error responses if needed
      }
    } catch (e) {
      print(e.toString());
    }
  }

// ! checkfollow to be use for button follow or unfollow by check in DB
  Future<void> checkfollow() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(profileid.value);
    final Uri url = Uri.parse('${Config.endPoint}/api/users/checkfollowers');
    // var body = {'followers_id': profileid.value};
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({'followers_id': profileid.value});
    final response = await http.post(url, headers: headers, body: body);
    var jsonRes = json.decode(response.body);
    try {
      if (response.statusCode == 200) {
        if (jsonRes['followers'] == false) {
          isFollowing.value = false;
        } else if (jsonRes['followers'] == true) {
          isFollowing.value = true;
        }
      } else {
        Get.snackbar("Error Loading data",
            'Server Response: ${response.statusCode}:${response.reasonPhrase.toString()}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // ! checkfollowers
  Future<void> followers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(profileid.value);
    final Uri url = Uri.parse(
        '${Config.endPoint}/api/users/getallfollowerByuserid/${profileid.value}');
    // var body = {'followers_id': profileid.value};
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    // final body = jsonEncode({'user_id': profileid.value});
    final response = await http.get(url, headers: headers);
    var jsonRes = json.decode(response.body);
    // print(response.body);
    try {
      if (response.statusCode == 200) {
        countFollowers.value = jsonRes['followers_length'];
        print('Followers=======================');
        var followers = jsonRes['followers'];
        personIdList.clear();
        for (var follower in followers) {
          var personIdData = follower['person_id'];
          personIdList.add(personIdData);
        }
        print(personIdList);
        // print(jsonRes['followers_length'].runtimeType);
        // print(countFollowers.value.runtimeType);
      } else if (response.statusCode == 404) {
        if (jsonRes['followers_length'] == 0) {
          countFollowers.value = jsonRes['followers_length'];
          // Get.snackbar("Error Loading data",
          //     'Server Response: ${response.statusCode}:${response.reasonPhrase.toString()}');
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // ! checkfollowings
  Future<void> following() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(profileid.value);
    final Uri url = Uri.parse(
        '${Config.endPoint}/api/users/getallfollowingByuserid/${profileid.value}');
    // var body = {'followers_id': profileid.value};
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    // final body = jsonEncode({'user_id': profileid.value});
    final response = await http.get(url, headers: headers);
    var jsonRes = json.decode(response.body);
    // print(response.body);
    try {
      if (response.statusCode == 200) {
        countFollowing.value = jsonRes['following_length'];
        // print(jsonRes['following_length'].runtimeType);
        // print(countFollowing.value.runtimeType);
        print('Following=======================');
        var following = jsonRes['following'];
        personIdList.clear();
        for (var follower in following) {
          var personIdData = follower['followers_id'];
          personIdList.add(personIdData);
        }
        print(personIdList);
      } else if (response.statusCode == 404) {
        if (jsonRes['following_length'] == 0) {
          countFollowing.value = jsonRes['following_length'];
        }
      }
    } catch (e) {
      print(profileid.value);
      print(countFollowing.value.runtimeType);
      print(countFollowing.value);
      Get.snackbar("Error Loading data",
          'Server Response: ${response.statusCode}:${response.reasonPhrase.toString()}');
      print(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
