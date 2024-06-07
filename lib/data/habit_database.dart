import 'package:flutter/material.dart';
import 'package:flutter_application_todo_list/datetime/date_time.dart'; // Importa funções relacionadas a datas
import 'package:hive_flutter/hive_flutter.dart'; // Importa o Hive

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HabitTrackerScreen(),
    );
  }
}

class HabitTrackerScreen extends StatefulWidget {
  const HabitTrackerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HabitTrackerScreenState createState() => _HabitTrackerScreenState();
}

class _HabitTrackerScreenState extends State<HabitTrackerScreen> {
  final HabitDatabase habitDatabase = HabitDatabase(); // Instância do banco de dados de hábitos

  @override
  void initState() {
    super.initState();
    habitDatabase.loadData(); // Carrega os dados do banco de dados
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker'), // Título da barra de aplicativos
      ),
      body: const Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

class HabitDatabase {
  final Box _myBox = Hive.box("Habit_Database"); // Instância do Hive Box

  List<List<dynamic>> todaysHabitList = []; // Lista de hábitos de hoje
  Map<DateTime, int> heatMapDataSet = {}; // Conjunto de dados do mapa de calor

  // Cria dados padrão iniciais
  void createDefaultData() {
    todaysHabitList = [];

    _myBox.put("START_DATE", todaysDateFormatted()); // Salva a data de início
  }

  // Carrega dados se já existirem
  void loadData() {
    // Se for um novo dia, obtém a lista de hábitos do banco de dados
    if (_myBox.get(todaysDateFormatted()) == null) {
      todaysHabitList = List<List<dynamic>>.from(_myBox.get("CURRENT_HABIT_LIST") ?? []);
      // Define todos os hábitos como não concluídos, já que é um novo dia
      for (int i = 0; i < todaysHabitList.length; i++) {
        todaysHabitList[i][1] = false;
      }
    }
    // Se não for um novo dia, carrega a lista de hoje
    else {
      todaysHabitList = List<List<dynamic>>.from(_myBox.get(todaysDateFormatted()));
    }
  }

  // Atualiza o banco de dados
  void updateDatabase() {
    // Atualiza a entrada de hoje
    _myBox.put(todaysDateFormatted(), todaysHabitList);

    // Atualiza a lista universal de hábitos caso tenha mudado (novo hábito, editar hábito, excluir hábito)
    _myBox.put("CURRENT_HABIT_LIST", todaysHabitList);

    // Calcula as porcentagens de conclusão dos hábitos para cada dia
    calculateHabitPercentages();

    // Carrega o mapa de calor
    loadHeatMap();
  }

  void calculateHabitPercentages() {
    int countCompleted = 0;
    for (int i = 0; i < todaysHabitList.length; i++) {
      if (todaysHabitList[i][1] == true) {
        countCompleted++;
      }
    }

    String percent = todaysHabitList.isEmpty
        ? '0.0'
        : (countCompleted / todaysHabitList.length).toStringAsFixed(1);

    // Chave: "PERCENTAGE_SUMMARY_yyyymmdd"
    // Valor: string de número com uma casa decimal entre 0.0 e 1.0 inclusive
    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  }

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

    // Conta o número de dias para carregar
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    // Percorre da data de início até hoje e adiciona cada porcentagem ao conjunto de dados
    // "PERCENTAGE_SUMMARY_yyyymmdd" será a chave no banco de dados
    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );

      // Divide a data e hora como abaixo para não se preocupar com horas/minutos/segundos, etc.
      DateTime date = startDate.add(Duration(days: i));

      final percentForEachDay = <DateTime, int>{
        DateTime(date.year, date.month, date.day): (10 * strengthAsPercent).toInt(),
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
      // ignore: avoid_print
      print(heatMapDataSet);
    }
  }
}
