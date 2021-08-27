import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_pro/models/user.dart';

import 'local_storage_provider.dart';

class AppProvider with ChangeNotifier {
  final navKey = new GlobalKey<NavigatorState>();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  LocalStorage storageActions = LocalStorage.getActions();

  User? authUser;
  MyUser? currentUser;

  String? uid;

  bool isFirstOpen = true;
  bool isUserExist = false;

  bool isLoggedIn = false;

  Future<void> bootActions() async {
    await checkIfIsFirstOpen();
    await checkIfLoggedIn();
  }

  Future<void> checkIfIsFirstOpen() async {
    var isFirstOpenKeyExists = storageActions.checkKey(key: 'is_first_open');
    isFirstOpen = !isFirstOpenKeyExists;
    print('First time opening the app: $isFirstOpen');
    if (isFirstOpen) {
      await storageActions.save(key: 'is_first_open', data: false);
    }
  }

  Future<void> checkIfLoggedIn() async {
    if (!storageActions.checkKey(key: 'is_logged_in')) {
      await storageActions.save(key: 'is_logged_in', data: false);
    }
    if (!storageActions.checkKey(key: 'uid')) {
      await storageActions.save(key: 'uid', data: '');
    }
    isLoggedIn = storageActions.getData(key: 'is_logged_in');
    uid = storageActions.getData(key: 'uid');
    print('the user login status is : $isLoggedIn');
    print('the user uid is : $uid');
  }

  Future<void> signIn(String email, String password) async {
    try {
      authUser = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      storageActions.save(key: 'uid', data: authUser!.uid);
      var result = await firestore.collection('users').doc(authUser!.uid).get();
      if (result.exists) {
        isUserExist = true;
        currentUser = MyUser.fromMap(result.data()!);
        await storageActions.save(key: 'is_logged_in', data: true);
      } else {
        isUserExist = false;
        currentUser =
            MyUser(email: email, password: password, uid: authUser!.uid);
      }
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> saveUser() async {
    try {
      if (currentUser != null) {
        await firestore
            .collection('users')
            .doc(currentUser!.uid)
            .set(currentUser!.toMap());
        await storageActions.save(key: 'is_logged_in', data: true);
        notifyListeners();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<bool> signUp(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      }
      return false;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }
  }

  Future<void> signOut() async {
    await storageActions.save(key: 'is_logged_in', data: false);
    await storageActions.deleteData(key: 'uid');
    notifyListeners();
  }
}
