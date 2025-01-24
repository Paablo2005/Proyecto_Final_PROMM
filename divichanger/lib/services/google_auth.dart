import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  // Instancia de FirebaseAuth para gestionar la autenticación de Firebase.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Instancia de GoogleSignIn para gestionar la autenticación con Google.
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Método para iniciar sesión con Google.
  Future<void> signInWithGoogle() async {
    try {
      // Inicia el flujo de inicio de sesión con Google.
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        // Obtiene la autenticación de Google después de que el usuario haya iniciado sesión.
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        // Crea las credenciales necesarias para Firebase usando los tokens de Google.
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // Inicia sesión en Firebase utilizando las credenciales de Google.
        await _auth.signInWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (e) {
      // Maneja cualquier error de autenticación de Firebase.
      // ignore: avoid_print
      print(e.toString());
    }
  }

  // Método para cerrar sesión tanto en Google como en Firebase.
  Future<void> signOut() async {
    await _googleSignIn.signOut(); // Cierra sesión en Google.
    await _auth.signOut(); // Cierra sesión en Firebase.
  }
}
