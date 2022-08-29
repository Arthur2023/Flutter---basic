import 'package:flutter/material.dart';

const String initialMessage = 'Informe seus dados';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String info = initialMessage;
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void resetFields() {
    info = initialMessage;
    weightController.clear();
    heightController.clear();
    formKey = GlobalKey<FormState>();
    setState(() {});
  }

  void calculate() {
    final weight = double.parse(weightController.text);
    final height = double.parse(heightController.text) / 100;

    final imc = weight / (height * height);
    final imcFormatted = imc.toStringAsPrecision(3);

    resetFields();

    if (imc < 18.6) {
      info = 'Abaixo do peso ($imcFormatted)';
    } else if (imc < 24.9) {
      info = 'Peso ideal ($imcFormatted)';
    } else if (imc < 29.9) {
      info = 'Levemente acima do peso ($imcFormatted)';
    } else if (imc < 34.9) {
      info = 'Obesidade Grau I ($imcFormatted)';
    } else if (imc < 39.9) {
      info = 'Obesidade Grau II ($imcFormatted)';
    } else {
      info = 'Obesidade Grau II ($imcFormatted)';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Calculadora de IMC'),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              onPressed: resetFields,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.person_outlined,
                  color: Colors.green,
                  size: 120,
                ),
                TextFormField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Peso (kg)',
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Insira o seu peso' : null,
                ),
                TextFormField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Insira a sua altura' : null,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: calculate,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      child: const Text(
                        'Calcular',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  info,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.green,
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
