import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';

class Profile_page extends StatefulWidget {
  final DocumentSnapshot snapshot;
  const Profile_page(this.snapshot);

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  IconData pass_eye = MdiIcons.eyeLock;
  bool eye_pressed = false;
  String pass = "*********";
  Color save_changes = const Color.fromRGBO(1, 70, 66, 1.0);

  TextEditingController user_name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String profile_image_path = '';
  double screenWidth = 0;

  @override
  void initState() {
    super.initState();
    user_name = TextEditingController(text: widget.snapshot['name']);
    phone = TextEditingController(text: widget.snapshot['phone']);
    email = TextEditingController(text: widget.snapshot['email']);
    password = TextEditingController(text: widget.snapshot['password']);

  }

  void _updateProfile() {
    String newName = user_name.text;
    String newEmail = email.text;
    String newPassword = password.text;
    String newPhone = phone.text;

    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.snapshot.id)
        .update({
      'name': newName,
      'phone': newPhone,
      'email': newEmail,
      'password': newPassword,

    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    }).catchError((error) {
      print('Error updating profile: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth1 = MediaQuery.of(context).size.width;
    screenWidth = screenWidth1;
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.snapshot.id)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Error retrieving profile data');
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Text('Profile data not found');
            }

            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            height: 0.6 * screenWidth,
                            width: screenWidth,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(0.2 * screenWidth),
                                color: Colors.black),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(0.2 * screenWidth),
                              child: Image.asset(
                                "Assets/images/image_processing20200825-24260-1l1hr8o.gif",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                  height: screenWidth * 0.9,
                                  width: screenWidth,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          screenWidth * 0.2),
                                      color: Colors.transparent)),
                              Container(
                                width: screenWidth * 0.28 * 2,
                                height: screenWidth * 0.28 * 2,
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle),
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black54,
                                      radius: screenWidth * 0.28,
                                      child: CircleAvatar(
                                        radius: screenWidth * 0.27,
                                        backgroundImage: profile_image_path ==
                                                ''
                                            ? const AssetImage(
                                                "Assets/images/image_processing20210910-22853-1777qya.gif",
                                              )
                                            : Image.file(
                                                    File(profile_image_path))
                                                .image,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectImage();
                                        });
                                      },
                                      child: CircleAvatar(
                                        backgroundImage: const AssetImage(
                                            "Assets/images/camera.png"),
                                        radius: screenWidth * 0.09,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenWidth * 0.04,
                      ),
                      Text(
                        data["name"],
                        style: TextStyle(
                          fontSize: screenWidth * 0.1,
                          fontFamily: "sweety",
                          color: Colors.black12,
                        ),
                      ),
                      SizedBox(
                        height: screenWidth * 0.04,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.05),
                          color: Colors.black12,
                        ),
                        child: TextField(
                          controller: user_name,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(1, 126, 120, 1.0),
                                    width: 2),
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.05),
                              ),
                              hintText: data["name"],
                              hintStyle: TextStyle(
                                overflow: TextOverflow.fade,
                                fontFamily: 'Amperzand',
                                fontSize: screenWidth * 0.05,
                                color: Colors.white,
                              ),
                              labelText: "user name",
                              labelStyle: TextStyle(
                                fontSize: screenWidth * 0.06,
                                fontFamily: "Sweety",
                              ),
                              prefixIcon: const Icon(
                                FontAwesomeIcons.userCircle,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: screenWidth * 0.04,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.05),
                          color: Colors.black12,
                        ),
                        child: TextField(
                          controller: phone,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(1, 126, 120, 1.0),
                                    width: 2),
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.05),
                              ),
                              hintText: data["phone"],
                              hintStyle: TextStyle(
                                overflow: TextOverflow.fade,
                                fontFamily: 'Amperzand',
                                fontSize: screenWidth * 0.05,
                                color: Colors.white,
                              ),
                              labelText: "phone number",
                              labelStyle: TextStyle(
                                fontSize: screenWidth * 0.06,
                                fontFamily: "Sweety",
                              ),
                              prefixIcon: const Icon(
                                FontAwesomeIcons.phoneVolume,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: screenWidth * 0.04,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.05),
                          color: Colors.black12,
                        ),
                        child: TextField(
                          controller: email,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(1, 126, 120, 1.0),
                                    width: 2),
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.05),
                              ),
                              hintText: data["email"],
                              hintStyle: TextStyle(
                                overflow: TextOverflow.fade,
                                fontFamily: 'Amperzand',
                                fontSize: screenWidth * 0.05,
                                color: Colors.white,
                              ),
                              labelText: "Email",
                              labelStyle: TextStyle(
                                fontSize: screenWidth * 0.06,
                                fontFamily: "Sweety",
                              ),
                              prefixIcon: Icon(
                                MdiIcons.emailBox,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: screenWidth * 0.04,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.05),
                          color: Colors.black12,
                        ),
                        child: TextField(
                          controller: password,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(1, 126, 120, 1.0),
                                    width: 2),
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.05),
                              ),
                              hintText: data["password"],
                              hintStyle: TextStyle(
                                overflow: TextOverflow.fade,
                                fontFamily: 'Amperzand',
                                fontSize: screenWidth * 0.05,
                                color: Colors.white,
                              ),
                              labelText: "Password",
                              labelStyle: TextStyle(
                                fontSize: screenWidth * 0.06,
                                fontFamily: "Sweety",
                              ),
                              prefixIcon: const Icon(
                                Icons.password_sharp,
                                color: Colors.black,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    eye_pressed = !eye_pressed;
                                    pass_eye = eye_pressed
                                        ? MdiIcons.eyeCheck
                                        : MdiIcons.eyeLock;
                                    pass = eye_pressed
                                        ? data["password"]
                                        : "*********";
                                  });
                                },
                                icon: Icon(pass_eye),
                              )),
                          obscureText: true,
                        ),
                      ),
                      SizedBox(
                        height: screenWidth * 0.06,
                      ),
                      MaterialButton(
                        onPressed: () {
                          _updateProfile();
                          // setState(() {
                          //   save_changes =  Color.fromRGBO(1, 126, 120, 1.0);
                          //   data["name"] = user_name.text != ''
                          //       ? user_name.text
                          //       : data["name"];
                          //   data["phone"] =
                          //       phone.text != '' ? phone.text : data["phone"];
                          //   data["email"] =
                          //       email.text != '' ? email.text : data["email"];
                          //   data["password"] = password.text != ''
                          //       ? password.text
                          //       : data["password"];
                          //   print(user_name.text);
                          //   print(data["name"]);
                          // });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black87, width: 2),
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.05),
                            color: save_changes,
                          ),
                          width: screenWidth * 0.5,
                          height: screenWidth * 0.2,
                          child: Center(
                              child: Text(
                            'Save changes',
                            style: TextStyle(
                                fontFamily: "Amperzand",
                                fontSize: screenWidth * 0.09,
                                color: Colors.white),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
                height: screenWidth * 0.7,
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Choose the photo source',
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontFamily: "Amperzand",
                          color: Colors.black45,
                        ),
                      ),
                      SizedBox(
                        height: screenWidth * 0.1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  profile_image_path = await wallpaper();
                                  if (profile_image_path.isNotEmpty) {
                                    Navigator.pop(context);
                                    setState(() {});
                                  }
                                },
                                child: Container(
                                    width: screenWidth * 0.2,
                                    height: screenWidth * 0.2,
                                    child: Image.asset(
                                        "Assets/images/wallpaper.png")),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Wallpaper',
                                style: TextStyle(
                                  fontFamily: 'Sweety',
                                  fontSize: screenWidth * 0.06,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  profile_image_path = await camera();
                                  if (profile_image_path.isNotEmpty) {
                                    Navigator.pop(context);
                                    setState(() {});
                                  }
                                },
                                child: Container(
                                    width: screenWidth * 0.2,
                                    height: screenWidth * 0.2,
                                    child: Image.asset(
                                        "Assets/images/camera (1).png")),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Camera',
                                style: TextStyle(
                                  fontFamily: 'Sweety',
                                  fontSize: screenWidth * 0.06,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          );
        });
  }

  wallpaper() async {
    XFile? imageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (imageFile != null)
      return imageFile.path;
    else
      return '';
  }

  camera() async {
    XFile? imageFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (imageFile != null)
      return imageFile.path;
    else
      return '';
  }
}
