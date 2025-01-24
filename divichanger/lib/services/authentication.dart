import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Instancia de FirebaseFirestore para interactuar con Firestore.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Instancia de FirebaseAuth para interactuar con la autenticación de Firebase.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Función para registrar un nuevo usuario en la base de datos.
  Future<String> registerUser({
    required String email,
    required String password,
    required String username,
  }) async {
    // Mensaje de error.
    String result = "Ocurrió un error";
    try {
      // Verifica que los campos no estén vacíos.
      if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
        // Crea el usuario en Firebase Auth.
        UserCredential credentials = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Imprime el UID del usuario recién creado.
        // ignore: avoid_print
        print(credentials.user!.uid);

        // Guarda los detalles del usuario en Firestore.
        await _firestore.collection("users").doc(credentials.user!.uid).set({
          'username': username,
          'uid': credentials.user!.uid,
          'email': email,
        });
        // Registro exitoso.
        result = "éxito";
      }
    } catch (error) {
      // Retorna el error si ocurre alguna excepción.
      return error.toString();
    }
    return result;
  }

  // Función para autenticar a un usuario existente.
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    //Mensaje de error
    String result = "Ocurrió un error";
    try {
      // Verifica que los campos no estén vacíos.
      if (email.isNotEmpty && password.isNotEmpty) {
        // Inicia sesión con las credenciales proporcionadas.
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        // Inicio de sesión exitoso.
        result = "éxito";
      } else {
        // Solicita que se ingresen todos los campos.
        result = "Por favor ingresa todos los campos";
      }
    } catch (error) {
      // Retorna el error si ocurre alguna excepción.
      return error.toString();
    }
    return result;
  }

  // Función para cerrar sesión.
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
