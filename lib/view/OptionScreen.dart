// import 'package:flutter/material.dart';

// class OptionScreen extends StatelessWidget {
//   const OptionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final bottom = MediaQuery.of(context).viewInsets.bottom;
//     final List<Commend> _com = [
//       Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
//       Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
//       Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
//       Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
//       Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
//       Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
//       Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
//       Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
//       Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
//       Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
//       Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
//       Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
//       Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
//       Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
//       Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
//       Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
//       Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
//       Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
//       Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
//     ];
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         elevation: 5,
//         leading: IconButton(
//           onPressed: () {
//             // Get.back(); // คำสั่งเพื่อย้อนกลับไปยังหน้า PostTab
//           },
//           icon: const Icon(Icons.arrow_back_ios_new),
//         ),
//         backgroundColor: ColorConstants.appColors,
//       ),
//       body: SafeArea(
//         child: Column(children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     alignment: Alignment.topLeft,
//                     width: double.infinity,
//                     height: MediaQuery.of(context).size.height / 5,
//                     color: ColorConstants.gray50,
//                     child: Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Text(
//                         "TEST POST",
//                         style: TextStyle(
//                             color: Colors.green[600],
//                             fontSize: 25,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       physics: const BouncingScrollPhysics(),
//                       padding: const EdgeInsets.all(5.0),
//                       primary: false,
//                       itemCount: _com.length,
//                       itemBuilder: ((context, index) {
//                         var reverseindex = _com.length - 1 - index;
//                         return Padding(
//                           padding: EdgeInsets.all(5.0),
//                           child: ListTile(
//                             tileColor: ColorConstants.gray50,
//                             title: Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(_com[index].text),
//                             ),
//                           ),
//                         );
//                       }),
//                     ),
//                   ),

//                   // SizedBox(
//                   //   // color: ColorConstants.appColors,
//                   //   height: MediaQuery.of(context).size.height / 4,
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             alignment: Alignment.bottomCenter,
//             color: ColorConstants.appColors,
//             child: TextFormField(
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               controller: _textcommentController,
//               obscureText: false,
//               decoration: InputDecoration(
//                   hintText: "Comment",
//                   hintStyle: const TextStyle(
//                       color: Color.fromARGB(255, 192, 192, 192)),
//                   fillColor: const Color.fromARGB(255, 237, 237, 237),
//                   filled: true,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                     color: Color.fromARGB(255, 52, 230, 168),
//                     width: 3,
//                   ))),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }
