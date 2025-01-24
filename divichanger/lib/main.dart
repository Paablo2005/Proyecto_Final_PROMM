import 'package:divichanger/screens/home_screen.dart';
import 'package:divichanger/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  // Comprueba que los widgets esten inicializados antes de ejecutar la app.
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase.
  await Firebase.initializeApp();

  // Inicia la app.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Elimina el banner.
      debugShowCheckedModeBanner: false,

      // Define la pantalla inicial según el estado de autenticacion del usuario.
      home: StreamBuilder(
        // Escucha cambios en el estado de autenticacion de Firebase.
        stream: FirebaseAuth.instance.authStateChanges(),

        // Construye la interfaz basada en los datos de autenticacion.
        builder: (context, authSnapshot) {
          // Si el usuario esta autenticado, muestra la pantalla principal.
          if (authSnapshot.hasData) {
            return const HomeScreen();
          }
          // Si no esta autenticado, muestra la pantalla de inicio de sesión.
          else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
