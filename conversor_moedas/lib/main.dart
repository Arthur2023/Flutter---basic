import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const request = 'https://api.hgbrasil.com/finance/quotations?key=778b7931';

Future<Map> getData() async {
  final uri = Uri.parse(request);
  final response = await http.get(uri);
  return json.decode(response.body);
}

void main() async => runApp(MaterialApp(
      theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: Colors.amber,
          labelStyle: TextStyle(color: Colors.amber),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        ),
      ),
      home: const HomePage(),
    ));

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double dollar;
  late double euro;

  final realController = TextEditingController();
  final dollarController = TextEditingController();
  final euroController = TextEditingController();

  void _clearAll() {
    realController.text = "";
    dollarController.text = "";
    euroController.text = "";
  }

  void onRealChange(String? text) {
    if (text == null || text.isEmpty) {
      return _clearAll();
    }
    final real = double.parse(text);
    dollarController.text = (real / dollar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void onDollarChange(String? text) {
    if (text == null || text.isEmpty) {
      return _clearAll();
    }
    final dollar = double.parse(text);
    realController.text = (dollar * this.dollar).toStringAsFixed(2);
    euroController.text = (dollar * this.dollar / euro).toStringAsFixed(2);
  }

  void onEuroChange(String? text) {
    if (text == null || text.isEmpty) {
      return _clearAll();
    }
    final euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    euroController.text = (euro * this.euro / dollar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Conversor',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.amber,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              onPressed: _clearAll,
            ),
          ],
        ),
        body: FutureBuilder<Map>(
          future: getData(),
          builder: (_, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: Text(
                    'Carregando...',
                    style: TextStyle(
                      color: Colors.amber,
                    ),
                  ),
                );

              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Falha',
                      style: TextStyle(
                        color: Colors.amber,
                      ),
                    ),
                  );
                } else {
                  dollar = snapshot.data!['results']['currencies']['USD']['buy'];
                  euro = snapshot.data!['results']['currencies']['EUR']['buy'];

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Icon(
                            Icons.monetization_on,
                            color: Colors.amber,
                            size: 150,
                          ),
                          valueTextField(
                            'Reais',
                            'R\$',
                            onRealChange,
                            realController,
                          ),
                          const Divider(),
                          valueTextField(
                            'Dólares',
                            'US',
                            onDollarChange,
                            dollarController,
                          ),
                          const Divider(),
                          valueTextField(
                            'Euros',
                            '€',
                            onEuroChange,
                            euroController,
                          ),
                        ],
                      ),
                    ),
                  );
                }
            }
          },
        ),
      );
}

Widget valueTextField(
  String label,
  String prefix,
  Function(String?) onChange,
  TextEditingController controller,
) {
  return TextField(
    controller: controller,
    cursorColor: Colors.amber,
    onChanged: onChange,
    style: const TextStyle(
      color: Colors.amber,
    ),
    decoration: InputDecoration(
      labelText: label,
      prefixText: '$prefix ',
    ),
  );
}
