import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomfirebase/const/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var profileImagePath = "".obs;
  var profileImageLink = "";
  var isLoading = false.obs;
  var nameController = TextEditingController();
  var OldController = TextEditingController();
  var NewController = TextEditingController();
  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 85);

      if (img == null) return;

      profileImagePath.value = img.path;
    } on PlatformException catch (ex) {
      VxToast.show(context, msg: ex.toString());
    }
  }

  UploadProfile() async {
    var fileName = "urlBase${profileImagePath.value}";
    var destination =
        "images/${FirebaseAuth.instance.currentUser!.uid}/$fileName";
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImagePath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  UpdateProfile({name, password, imgUrl}) async {
    var store = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid);
    await store.set({"name": name, "password": password, "imgUrl": imgUrl},
        SetOptions(merge: true));
    isLoading(false);
  }

  //change old password & then auth stored new password

  changeAuthPassword({email, oldPassword, newPassword}) async {
    final credential =
        EmailAuthProvider.credential(email: email, password: oldPassword);
    await FirebaseAuth.instance.currentUser!
        .reauthenticateWithCredential(credential)
        .then((value) {
      FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
    });
  }
}
