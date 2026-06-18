import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:student_manager/firebase_options.dart';

class SecondaryFirebaseAuth {
  SecondaryFirebaseAuth._();

  static FirebaseApp? _app;

  static Future<FirebaseAuth> instance() async {
    _app ??= await Firebase.initializeApp(
      name: 'UserCreator',
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return FirebaseAuth.instanceFor(app: _app!);
  }
}
