import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitName; // Nome do hábito
  final bool habitCompleted; // Indica se o hábito foi concluído ou não
  final Function(bool?)? onChanged; // Função chamada quando o estado do checkbox é alterado
  final Function(BuildContext)? settingsTapped; // Função chamada quando as configurações do hábito são tocadas
  final Function(BuildContext)? deleteTapped; // Função chamada quando o hábito é excluído

  const HabitTile({
    super.key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChanged,
    required this.settingsTapped,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Preenchimento em todos os lados do azulejo
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(), // Animação ao deslizar
          children: [
            // Opção de configurações
            SlidableAction(
              onPressed: settingsTapped, // Função chamada ao tocar na opção de configurações
              backgroundColor: Colors.grey.shade400, // Cor de fundo da opção de configurações
              icon: Icons.settings, // Ícone da opção de configurações
              borderRadius: BorderRadius.circular(12), // Borda arredondada da opção de configurações
            ),

            // Opção de exclusão
            SlidableAction(
              onPressed: deleteTapped, // Função chamada ao tocar na opção de exclusão
              backgroundColor: Colors.red.shade400, // Cor de fundo da opção de exclusão
              icon: Icons.delete, // Ícone da opção de exclusão
              borderRadius: BorderRadius.circular(12), // Borda arredondada da opção de exclusão
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24), // Preenchimento interno do conteúdo do azulejo
          decoration: BoxDecoration(
            color: Colors.grey[100], // Cor de fundo do azulejo
            borderRadius: BorderRadius.circular(12), // Borda arredondada do azulejo
          ),
          child: Row(
            children: [
              // Checkbox
              Checkbox(
                value: habitCompleted, // Valor do checkbox
                onChanged: onChanged, // Função chamada quando o estado do checkbox é alterado
              ),

              // Nome do hábito
              Text(habitName), // Texto exibindo o nome do hábito
            ],
          ),
        ),
      ),
    );
  }
}
