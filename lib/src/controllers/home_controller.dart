import 'package:dio_lab_flutter_imc/src/models/imc.dart';

class HomeController {
  HomeController({
    required this.imc,
  });

  final imcList = <String>[];
  IMC imc;

  String calculate({
    required double weigth,
    required double heigth,
  }) {
    imc.weigth = weigth;
    imc.heigth = heigth;

    return imc.calculate();
  }
}
