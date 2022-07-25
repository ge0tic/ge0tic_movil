// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';

class LoginController extends GetxController {
  var auth = false.obs;
  /* var infoUser = InfoUserModel(
          extension: '', identificationNumber: '', mail: '', phoneNumber: 0)
      .obs;*/
  //var listSuministros = <SuministroModel>[].obs;

  void setAuth(bool auth) {
    this.auth.value = auth;
  }

  bool get getAuth => auth.value;
  /*void setLogout() {
    this.auth.value = false;
  }*/

  /*setInfoUser(InfoUserModel infoUser) {
    this.infoUser.value = infoUser;
  }*/

  /*setListSuministros(List<SuministroModel> listSuministros) {
    this.listSuministros.value = listSuministros;
  }*/

  //getInfoUser() => infoUser.value;
  //getListSuministros() => listSuministros.value;

  /*String getUsuario() => getInfoUser().mail;
  String getMail() => getInfoUser().mail;
  String getTelefono() => getInfoUser().phoneNumber.toString();
  String getCI() => getInfoUser().identificationNumber;
  String getExtension() => getInfoUser().extension;
  */
}
