import 'package:dio_lab_flutter_imc/src/home/home_controller.dart';
import 'package:dio_lab_flutter_imc/src/home/models/imc.dart';
import 'package:flutter/material.dart';

import '../utils/formatter.dart';
import '../utils/validator.dart';
import '../widgets/calculate_button.dart';
import '../widgets/field_custon.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  final _weigth = TextEditingController(text: '0.000');
  final _heigth = TextEditingController(text: '0.00');
  final _controller = HomeController(imc: IMC());

  @override
  void dispose() {
    _weigth.dispose();
    _heigth.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculadora IMC',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  FieldCuston(
                    controller: _weigth,
                    label: 'Peso (Kg)*',
                    formatter: const [
                      Formatter(
                        asFixed: 3,
                      ),
                    ],
                    validator: Validator.notLessThen(
                      'Digite seu peso.',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FieldCuston(
                    controller: _heigth,
                    label: 'Altura (m)*',
                    textInputAction: TextInputAction.done,
                    formatter: const [
                      Formatter(
                        asFixed: 2,
                      ),
                    ],
                    validator: Validator.notLessThen(
                      'Digite sua altura.',
                      minimumValue: 0.1,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CalculateButton(
                    onPressed: () {
                      (_formKey.currentState?.validate() ?? false)
                          ? setState(
                              () {
                                final imc = _controller.calculate(
                                  weigth: double.parse(_weigth.text),
                                  heigth: double.parse(_heigth.text),
                                );

                                _controller.imcList.add(imc);
                                _weigth.text = '0.000';
                                _heigth.text = '0.00';

                                debugPrint('onPressed');
                              },
                            )
                          : ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                showCloseIcon: true,
                                closeIconColor: Colors.red,
                                backgroundColor: Colors.white,
                                content: Text(
                                  'Digite todos os campos para continuar!',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            );
                    },
                    child: const Text('Calcular IMC'),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _controller.imcList.length,
                    itemBuilder: (context, index) {
                      debugPrint('ListView.Builder ${_formKey.currentState}');
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _controller.imcList[index],
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                            overflow: TextOverflow.clip,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _controller.imcList.removeAt(index);
                              });
                            },
                            icon: const Icon(
                              Icons.close_rounded,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
