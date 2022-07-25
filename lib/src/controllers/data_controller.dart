import 'dart:convert';
import 'package:ge0tic/src/model/data_model.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  var dataMundo = ''.obs;
  var dataSudamerica = ''.obs;

  // Bolivia
  var dataDepartamentos = ''.obs;
  var dataProvincias = ''.obs;
  var dataMunicipios = ''.obs;

// SETERS
  void setDataMundo(String data) {
    dataMundo.value = data;
  }

  void setDataSudAmerica(String data) {
    dataSudamerica.value = data;
  }

  // Bolivia
  void setDataDepartamentos(String data) {
    dataDepartamentos.value = data;
  }

  void setDataProvincias(String data) {
    dataProvincias.value = data;
  }

  void setDataMunicipios(String data) {
    dataMunicipios.value = data;
  }

  get getDataMundo => jsonDecode(dataMundo.value);
  get getDataSudamerica => jsonDecode(dataSudamerica.value);

  //Bolivia
  get getDataDepartamentos => jsonDecode(dataDepartamentos.value);
  get getDataProvincias => jsonDecode(dataProvincias.value);
  get getDataMunicipios => jsonDecode(dataMunicipios.value);

// GETERS
  List<DataModel> getDataMundoObject() {
    final data = getDataMundo;
    List<DataModel> stateWiseElectionResult = getDataModelObject(data, 3);
    return stateWiseElectionResult;
  }

  List<DataModel> getDataSudamericaObject() {
    final data = getDataSudamerica;
    List<DataModel> stateWiseElectionResult =
        getDataModelObject(data, 3); // 3 porque utiliza también name
    return stateWiseElectionResult;
  }

// BOLIVIA
  List<DataModel> getDataDepartamentosObject() {
    final data = getDataDepartamentos;
    List<DataModel> stateWiseElectionResult = getDataModelObject(data, 0);
    return stateWiseElectionResult;
  }

  List<DataModel> getDataProvinciasObject() {
    final data = getDataProvincias;
    List<DataModel> stateWiseElectionResult = getDataModelObject(data, 1);
    return stateWiseElectionResult;
  }

  List<DataModel> getDataMunicipiosObject() {
    final data = getDataMunicipios;
    List<DataModel> stateWiseElectionResult = getDataModelObject(data, 2);
    return stateWiseElectionResult;
  }

  ////
  List<DataModel> getDataModelObject(data, int t) {
    late List<DataModel> stateWiseElectionResult = [];
    String x = '';
    for (var e in data['features']) {
      x = e['properties']['DEPARTAMEN'] ?? '';
      if (t == 1) {
        x = e['properties']['PROVINCIA'];
      } else if (t == 2) {
        x = e['properties']['MUNICIPIO'] ?? '';
      } else if (t == 3) {
        x = e['properties']['name'] ?? '';
      }
      stateWiseElectionResult.add(DataModel(
        codDep: e['properties']['cod_dep'] ?? '',
        nombre: x,
        descrip: e['properties']['DEPARTAMEN'] ?? '',
        departamento: e['properties']['DEPARTAMEN'] ?? '',
        provincia: e['properties']['PROVINCIA'] ?? '',
        municipio: e['properties']['MUNICIPIO'] ?? '',
        historia: e['properties']['HISTORIA'] ?? '',
        himno: e['properties']['HIMNO'] ?? '',
        bandera: e['properties']['BANDERA'] ?? '',
        escudo: e['properties']['ESCUDO'] ?? '',
        fechas: e['properties']['FECHAS'] ?? '',
        color: e['properties']['COLOR'] ?? '',
      ));
    }
    return stateWiseElectionResult;
  }
}
