import 'screens.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controlador para el campo de correo electrónico
  final TextEditingController _emailController = TextEditingController();

  // Controlador para el campo de contraseña
  final TextEditingController _passwordController = TextEditingController();

  // Indica si la acción de inicio de sesión está en proceso
  // ignore: unused_field
  bool _isLoading = false;

  @override
  void dispose() {
    // Limpia el controlador de correo electrónico
    _emailController.dispose();
    // Limpia el controlador de contraseña
    _passwordController.dispose();
    super.dispose();
  }

  void _loginUser() async {
    // Activa el indicador de carga
    setState(() {
      _isLoading = true;
    });

    // Llama al método para iniciar sesión y almacena el resultado
    String result = await AuthService().loginUser(
      // Correo ingresado por el usuario
      email: _emailController.text,
      // Contraseña ingresada por el usuario
      password: _passwordController.text,
    );

    if (result == "éxito") {
      // Desactiva el indicador de carga
      setState(() {
        _isLoading = false;
      });

      // Navega a la pantalla principal si el inicio de sesión es exitoso
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      // Desactiva el indicador de carga en caso de error
      setState(() {
        _isLoading = false;
      });

      // Muestra un mensaje de error utilizando un snack bar personalizado
      // ignore: use_build_context_synchronously
      showCustomSnackBar(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtiene la altura de la pantalla
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // Permite que la vista se ajuste al teclado
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // Centra los elementos horizontalmente
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                // Ocupa el 40% de la altura de la pantalla
                height: screenHeight * 0.4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              CustomTextField(
                icon: Icons.person,
                inputController: _emailController,
                placeholderText: 'Ingresa tu correo electrónico',
                inputType: TextInputType.text,
              ),
              CustomTextField(
                icon: Icons.lock,
                inputController: _passwordController,
                placeholderText: 'Ingresa tu contraseña',
                inputType: TextInputType.text,
                // Indica que es un campo de contraseña
                isPasswordField: true,
              ),
              // Botón para recuperar la contraseña
              const ForgotPasswordScreen(),
              CustomButton(
                // Llama al método de inicio de sesión
                onButtonPressed: _loginUser,
                buttonText: "Iniciar sesión",
              ),
              Row(
                children: [
                  Expanded(
                    // Línea divisoria
                    child: Container(height: 1, color: Colors.black26),
                  ),
                  const Text("  o  "),
                  Expanded(
                    // Línea divisoria
                    child: Container(height: 1, color: Colors.black26),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff112D4E)),
                  onPressed: () async {
                    // Inicia sesión con Google
                    await FirebaseAuthService().signInWithGoogle();
                    Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        // Navega a la pantalla principal
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Image.network(
                          "https://th.bing.com/th/id/R.a9fb17c908f1933ab901c2c3fd1cdc44?rik=gWdVqzzG8%2buUEA&pid=ImgRaw&r=0", // Ícono de Google
                          height: 35,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Continuar con Google",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("¿No tienes una cuenta? "),
                    GestureDetector(
                      // Navega a la pantalla de registro
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Registrarse",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
