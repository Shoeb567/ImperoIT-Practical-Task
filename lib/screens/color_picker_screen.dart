import 'package:flutter/material.dart';

class ColorPickerScreen extends StatefulWidget {
  const ColorPickerScreen({super.key});

  @override
  _ColorPickerScreenState createState() => _ColorPickerScreenState();
}

class _ColorPickerScreenState extends State<ColorPickerScreen> {
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
  ];

  List<TextEditingController> controllers = List.generate(
    5,
    (index) => TextEditingController(),
  );

  Color selectedColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Color Picker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: Row(
        children: [
          Container(
            width: 50,
            color: selectedColor,
          ),
          Expanded(
            child: Column(
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColor = colors[index];
                      controllers[index].text = colors[index].toString();
                    });
                  },
                  child: Container(
                    color: colors[index],
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      'Color ${index + 1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: List.generate(
                5,
                (index) => TextField(
                  controller: controllers[index],
                  onChanged: (value) {
                    setState(() {
                      colors[index] = getColor(value);
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Color ${index + 1}',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getColor(String colorString) {
    colorString = colorString.replaceAll('Color(0x', '').replaceAll(')', '');
    List<String> rgba = colorString.split(', ');
    return Color.fromRGBO(
      int.parse(rgba[0]),
      int.parse(rgba[1]),
      int.parse(rgba[2]),
      double.parse(rgba[3]),
    );
  }
}
