import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomfirebase/const/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoaded = false.obs;
  // login method
  Future<UserCredential?> loginMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      VxToast.show(context, msg: ex.toString());
    }
    return userCredential;
  }

  //signup method create

  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
       VxToast.show(context, msg: ex.toString());
    }
    return userCredential;
  }

  // storing data method
  storeUserData({name, email, password}) async {
    DocumentReference store = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid);
    store.set({
      "name": name,
      "email": email,
      "password": password,
      "imgUrl": "",
      "id": FirebaseAuth.instance.currentUser!.uid
    });
  }

  //signOUt method create
  siginOutMethod({context}) async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (ex) {
      VxToast.show(context, msg: ex.toString());
    }
  }
}
