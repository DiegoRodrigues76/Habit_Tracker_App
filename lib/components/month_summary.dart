import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter_application_todo_list/datetime/date_time.dart'; // Importa uma função para manipulação de data e hora

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int>? datasets; // Conjunto de dados para o resumo mensal
  final String startDate; // Data de início do resumo

  const MonthlySummary({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 25), // Preenchimento superior e inferior do contêiner
      child: HeatMap(
        startDate: createDateTimeObject(startDate), // Data de início para o mapa de calor
        endDate: DateTime.now().add(const Duration(days: 0)), // Data de término do mapa de calor (hoje)
        datasets: datasets, // Conjunto de dados do mapa de calor
        colorMode: ColorMode.color, // Modo de cor do mapa de calor
        defaultColor: Colors.grey[200], // Cor padrão do mapa de calor
        textColor: Colors.black, // Cor do texto do mapa de calor
        showColorTip: false, // Mostrar dica de cor no mapa de calor
        showText: true, // Mostrar texto no mapa de calor
        scrollable: true, // Permitir rolagem no mapa de calor
        size: 30, // Tamanho dos blocos do mapa de calor
        colorsets: const { // Conjunto de cores para os blocos do mapa de calor
          1: Color.fromARGB(20, 2, 179, 8),
          2: Color.fromARGB(40, 2, 179, 8),
          3: Color.fromARGB(60, 2, 179, 8),
          4: Color.fromARGB(80, 2, 179, 8),
          5: Color.fromARGB(100, 2, 179, 8),
          6: Color.fromARGB(120, 2, 179, 8),
          7: Color.fromARGB(150, 2, 179, 8),
          8: Color.fromARGB(180, 2, 179, 8),
          9: Color.fromARGB(220, 2, 179, 8),
          10: Color.fromARGB(255, 2, 179, 8),
        },
        onClick: (value) { // Ação ao clicar em um bloco do mapa de calor
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString()))); // Exibir um Snackbar com o valor do bloco clicado
        },
      ),
    );
  }
}
