import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
String imageUrl;
String name;
String email;
String displayName;
String uid;
bool isSignedIn;

Future<bool> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
  print("hello");

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;
  uid = user.uid;
  isSignedIn = true;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
}

Future<bool> signupwithemail(
    String emailS, String passwordS, String nameS) async {
  AuthResult result = await _auth.createUserWithEmailAndPassword(
      email: emailS, password: passwordS);
  FirebaseUser user = result.user;
  var info = new UserUpdateInfo();
  info.displayName = nameS;
  await user.updateProfile(info);
  await user.reload();
  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  uid = currentUser.uid;
  email = currentUser.email;
  name = currentUser.displayName;
}

Future<bool> signInWithEmail(String emailS, String passwordS) async {
  AuthResult result = await _auth.signInWithEmailAndPassword(
      email: emailS, password: passwordS);
  FirebaseUser user = result.user;
  assert(user != null);
  assert(await user.getIdToken() != null);
  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  uid = user.uid;
  email = user.email;
  name = user.displayName;
  imageUrl = user.photoUrl;
  isSignedIn = true;
}

void signOutGoogle() async {
  await _auth.signOut();
  await googleSignIn.signOut();
  isSignedIn = false;
}
