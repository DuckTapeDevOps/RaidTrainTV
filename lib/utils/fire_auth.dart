import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitch_api/twitch_api.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

const clientId = "wgt3b63eja0ykpkesftb4s3qofqeg9";
const redirectUri = "https://id.twitch.tv/oauth2/authorize"; // ex: "http://localhost/"
// https://id.twitch.tv/oauth2/authorize?client_id=wgt3b63eja0ykpkesftb4s3qofqeg9&redirect_uri=https://raidtraintv.firebaseapp.com/__/auth/handler&response_type=token&scope=openid
final _twitchClient = TwitchClient(
  clientId: clientId,
  redirectUri: redirectUri,
);



class FireAuth {
  Future<User?> signInWithTwitch() async {
    try {
      OAuthProvider oAuthProvider = OAuthProvider('oidc.twitch');
      oAuthProvider.addScope('user:read:email');
      oAuthProvider.setCustomParameters({
        'client_id': clientId,
        'response_type': 'code',
        'redirect_uri': 'https://raidtraintv.firebaseapp.com/__/auth/handler',
      });
      
      UserCredential userCredential = await FirebaseAuth.instance.signInWithPopup(oAuthProvider);
      return userCredential.user;
    } catch (e) {
      print("Error during Twitch sign-in: $e");
      if (e is FirebaseAuthException) {
        print('Error code: ${e.code}');
        print('Error message: ${e.message}');
      }
      return null;
    }
  }

  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateProfile(displayName: name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }

  static Future<User?> signInUsingEmailPassword({
  required String email,
  required String password,
  required BuildContext context,
}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided.');
    }
  }

  return user;
}
}

