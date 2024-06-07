import 'package:flutter/material.dart';
import 'package:flutter_application_todo_list/components/habit_tile.dart'; // Importa o componente de azulejo do hábito
import 'package:flutter_application_todo_list/components/month_summary.dart'; // Importa o resumo mensal
import 'package:flutter_application_todo_list/components/my_fab.dart'; // Importa o botão de ação flutuante personalizado
import 'package:flutter_application_todo_list/components/my_alert_box.dart'; // Importa o alerta personalizado
import 'package:flutter_application_todo_list/data/habit_database.dart'; // Importa o banco de dados de hábitos
import 'package:hive_flutter/hive_flutter.dart'; // Importa o Hive

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDatabase db = HabitDatabase(); // Instância do banco de dados de hábitos
  final _myBox = Hive.box("Habit_Database"); // Instância do Hive Box

  @override
  void initState() {
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData(); // Cria dados padrão se não existirem
    }
    else {
      db.loadData(); // Carrega os dados
    }
    db.updateDatabase(); // Atualiza o banco de dados
    super.initState();
  }

  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value; // Atualiza o estado do hábito ao ser marcado
    });
    db.updateDatabase(); // Atualiza o banco de dados
  }

  final _newHabitNameController = TextEditingController();
  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          hintText: 'Escreva o nome da atividade',
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // Salva um novo hábito
  void saveNewHabit() {
    setState(() {
      db.todaysHabitList.add([_newHabitNameController.text, false]); // Adiciona um novo hábito à lista de hábitos de hoje
    });

    // Limpa o campo de texto
    _newHabitNameController.clear();
    // Fecha a caixa de diálogo
    Navigator.of(context).pop();
    db.updateDatabase(); // Atualiza o banco de dados
  }

  // Cancela a criação de um novo hábito
  void cancelDialogBox() {
    // Limpa o campo de texto
    _newHabitNameController.clear();

    // Fecha a caixa de diálogo
    Navigator.of(context).pop();
  }

  // Abre as configurações do hábito para edição
  void openHabitSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          hintText: db.todaysHabitList[index][0],
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // Salva um hábito existente com um novo nome
  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.pop(context);
    db.updateDatabase(); // Atualiza o banco de dados
  }

  // Deleta um hábito
  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase(); // Atualiza o banco de dados
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      floatingActionButton: MyFloatingActionButton(onPressed: createNewHabit), // Botão de ação flutuante
      body: ListView(
        children: [
          // Resumo mensal em forma de mapa de calor
          MonthlySummary(
            datasets: db.heatMapDataSet,
            startDate: _myBox.get("START_DATE"),
          ),

          // Lista de hábitos
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: db.todaysHabitList.length,
            itemBuilder: (context, index) {
              return HabitTile(
                habitName: db.todaysHabitList[index][0], // Nome do hábito
                habitCompleted: db.todaysHabitList[index][1], // Estado de conclusão do hábito
                onChanged: (value) => checkBoxTapped(value, index), // Função chamada quando o estado do checkbox é alterado
                settingsTapped: (context) => openHabitSettings(index), // Função chamada quando as configurações do hábito são tocadas
                deleteTapped: (context) => deleteHabit(index), // Função chamada quando o hábito é excluído
              );
            },
          )
        ],
      ),
    );
  }
}
