import 'package:dio_lab_flutter_imc/src/home/models/imc.dart';
import 'package:dio_lab_flutter_imc/src/repositories/storage_repository.dart';

class HomeController {
  HomeController(
    this._storage, {
    required this.imc,
  });

  final StorageRepository _storage;
  var imcList = <String>[];
  IMC imc;

  String calculate({
    required double weigth,
    required double heigth,
  }) {
    imc.weigth = weigth;
    imc.heigth = heigth;

    return imc.calculate();
  }

  Future<List<String>> getList(String key) async {
    return _storage.getList(key);
  }

  Future<void> setList(String key, List<String> list) async {
    await _storage.setList(key, list);
  }
}
