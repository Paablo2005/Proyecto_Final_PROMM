import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  // Controlador para gestionar el texto ingresado.
  final TextEditingController inputController;

  // Indica si el campo es para contraseñas (oculta el texto).
  final bool isPasswordField;

  // Texto como pista del TextField.
  final String placeholderText;

  // Icono opcional.
  final IconData? icon;

  // Tipo de teclado que se muestra.
  final TextInputType inputType;

  // Constructor.
  const CustomTextField({
    super.key,
    required this.inputController,
    this.isPasswordField = false,
    required this.placeholderText,
    this.icon,
    required this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextField(
        // Estilo del texto.
        style: const TextStyle(fontSize: 20),
        controller: inputController,
        decoration: InputDecoration(
          // Icono opcional al principio del campo de texto.
          prefixIcon: Icon(icon, color: Colors.black54),

          // Placeholder.
          hintText: placeholderText,
          hintStyle: const TextStyle(color: Colors.black45, fontSize: 18),

          // Borde cuando el campo no está seleccionado.
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),

          // Sin borde al redibujar (por defecto).
          border: InputBorder.none,

          // Borde resaltado al pulsar el campo.
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(30),
          ),

          // Color de fondo del campo.
          filled: true,
          fillColor: const Color(0xFFF9F7F7),

          // Espaciado interno.
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
        ),

        // Tipo de teclado.
        keyboardType: inputType,

        // Texto oculto para contraseñas.
        obscureText: isPasswordField,
      ),
    );
  }
}
