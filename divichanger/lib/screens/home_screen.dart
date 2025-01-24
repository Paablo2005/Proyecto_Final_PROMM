import 'screens.dart';
import 'package:flutter/material.dart';

// Pantalla principal
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Mensaje de bienvenida
            const Text(
              "Felicidades\nHas iniciado sesión exitosamente",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            // Botón para permitir al usuario cerrar sesión
            CustomButton(
                onButtonPressed: () async {
                  await AuthService().signOut();
                  // Navegar de regreso a la pantalla de inicio de sesión
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                buttonText: "Cerrar sesión"),
          ],
        ),
      ),
    );
  }
}
