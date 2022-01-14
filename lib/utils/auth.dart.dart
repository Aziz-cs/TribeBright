import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tribebright/pages/navigator_page.dart';
import 'package:tribebright/pages/sign_up/add_child_page.dart';

import '../constants.dart';
import 'database.dart';
import 'helper.dart';

class Auth {
  static Future<void> signUp({
    required String email,
    required String password,
    String name = '',
    String phoneNo = '',
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        Database.registerParent(name: name, phoneNo: phoneNo);
        // ParentID = FirebaseAuth.instance.currentUser!.uid;
        Database.setParentValues();
        await Database.getCategories();
        await Database.getSleepSounds();
      }).then((value) {
        Helper.showToast("Congratulations, Account has been registered!");
        Get.off(() => const AddChildPage());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Helper.showToast("That's a weak password, please make it stronger");
      } else if (e.code == 'email-already-in-use') {
        Helper.showToast("This Email is already registered");
      } else {
        Helper.showToast(kMsgSomethingWrong);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> signIn(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        Database.setParentValues();

        await Database.getCategories();
        await Database.getSleepSounds();
        Get.off(() => const NavigatorPage());
        Helper.showToast('Welcome back!');
      });
    } on FirebaseAuthException catch (e) {
      print('exception code ${e.code}');
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Helper.showToast('This Email is not registered');
      } else if (e.code == 'wrong-password') {
        Helper.showToast('Wrong password');
        print('Wrong password provided for that user.');
      } else {
        Helper.showToast(kMsgSomethingWrong);
      }
    }
  }

  static bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser?.uid != null;
  }
}
