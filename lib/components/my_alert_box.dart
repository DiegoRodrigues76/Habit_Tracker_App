import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller; // Controlador para o campo de texto
  final String hintText; // Texto de dica para o campo de texto
  final VoidCallback onSave; // Função chamada quando o botão de salvar é pressionado
  final VoidCallback onCancel; // Função chamada quando o botão de cancelar é pressionado

  const MyAlertBox({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900], // Cor de fundo do alerta
      content: TextField(
        controller: controller, // Associa o controlador ao campo de texto
        style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)), // Estilo do texto
        decoration: InputDecoration(
          hintText: hintText, // Define o texto de dica para o campo de texto
          hintStyle: TextStyle(color: Colors.grey[600]), // Estilo do texto de dica
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)), // Borda quando o campo está habilitado
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)), // Borda quando o campo está focado
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: onSave, // Chama a função onSave quando o botão é pressionado
          color: Colors.black, // Cor de fundo do botão
          child: const Text(
            "Salvar", // Texto do botão de salvar
            style: TextStyle(color: Colors.white), // Cor do texto do botão
          ),
        ),
        MaterialButton(
          onPressed: onCancel, // Chama a função onCancel quando o botão é pressionado
          color: Colors.black, // Cor de fundo do botão
          child: const Text(
            "Cancelar", // Texto do botão de cancelar
            style: TextStyle(color: Colors.white), // Cor do texto do botão
          ),
        ),
      ],
    );
  }
}
