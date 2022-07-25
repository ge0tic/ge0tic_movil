import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ge0tic/src/controllers/login_controller.dart';
import 'package:ge0tic/src/model/data_path_model.dart';
import 'package:ge0tic/src/providers/db_provider.dart';
import 'package:ge0tic/src/widgets/pushable_button.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'constantes.dart';

class Utils {
  static const primaryColor = Color.fromARGB(228, 23, 148, 48);
  static const secodaryColor = Color.fromRGBO(0, 88, 28, 0.9);
  static const pinkColor = Color(0xFFdbbbec);
  static const blackColor = Color(0xFF092a45);

  static final player = AudioPlayer();

  static Size mediaQuerySize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static Widget colorFondoClaro(double opacidad) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(255, 255, 255, opacidad),
    );
  }

  static Widget colorFondoOscuro(double opacidad) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(0, 0, 0, opacidad),
    );
  }

  static Widget imagenFondo(String urlImagen) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage(urlImagen),
        fit: BoxFit.cover,
      ),
    );
  }

  static Widget delapazLogo() {
    return const FadeInImage(
      placeholder: AssetImage('assets/img/logo_slogan_dlp.png'),
      image: AssetImage('assets/img/logo_slogan_dlp.png'),
      fadeInDuration: Duration(seconds: 2),
    );
  }

  static Widget delapazLogo2() {
    return const FadeInImage(
      placeholder: AssetImage('assets/img/logo_slogan_dlp2.png'),
      image: AssetImage('assets/img/logo_slogan_dlp2.png'),
      fadeInDuration: Duration(seconds: 2),
    );
  }

  static Widget sloganLogo() {
    return const FadeInImage(
      placeholder: AssetImage('assets/img/et_endecorp.png'),
      image: AssetImage('assets/img/et_endecorp.png'),
      fadeInDuration: Duration(seconds: 2),
    );
  }

  static Widget delapazLogoSlogan() {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.6),
        ),
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[espacio60, delapazLogo(), _slogan()],
        ),
      ),
    );
  }

  static Widget _slogan() {
    String slogan = 'DISTRIBUIDORA DE ELECTRICIDAD LA PAZ';
    // ignore: prefer_const_constructors
    TextStyle estiloSlogan = TextStyle(
      color: Colors.white60,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    );
    return Text(
      slogan,
      style: estiloSlogan,
    );
  }

  static Color colorGuindo(double opacidad) {
    return Color.fromRGBO(146, 28, 46, opacidad);
  }

  static Color colorGuindo2() =>
      const Color(0xFF921C30); // fromRGB(146, 28, 46, 0.9)

  static Color colorVerde(double opcidad) {
    return Color.fromRGBO(0, 88, 48, opcidad);
  }

  static Widget logo() {
    return Container(
      height: Get.height * 0.12,
      margin: const EdgeInsets.only(left: 8.0),
      //padding: const EdgeInsets.all(8.0),
      child: const FadeInImage(
        placeholder:
            AssetImage('assets/img/electrolinera-logo-transparente.png'),
        image: AssetImage('assets/img/electrolinera-logo-transparente.png'),
        fadeInDuration: Duration(seconds: 2),
      ),
    );
  }

  static Widget mensajePlaceHolder(String title, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(title,
              style: const TextStyle(fontSize: 32.0, color: Colors.black54),
              textAlign: TextAlign.center),
          Text(message,
              style: const TextStyle(fontSize: 16.0, color: Colors.black54),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  static void showSnakbar(String title, String msg, int duration,
      [SnackPosition? position, IconData? ic, Color? col, Widget? msgWidget]) {
    Get.snackbar(title, msgWidget != null ? '' : msg,
        backgroundColor: Colors.black.withOpacity(0.7),
        colorText: Colors.white70,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        snackPosition: position ?? SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        icon: Icon(
          ic ?? Icons.info_outline,
          color: col ?? Colors.lightGreenAccent[400],
          size: 35.0,
        ),
        messageText: msgWidget);
  }

  static void showSnakbarError(String titulo, String msg, int duracion,
      [SnackPosition? position]) {
    Get.snackbar(titulo, msg,
        titleText: estiloTexto(titulo, 16.0, true, Colors.white),
        colorText: Colors.white.withOpacity(0.8),
        snackPosition: position ?? SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.6),
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        borderColor: Colors.white.withOpacity(0.8),
        borderWidth: 1,
        icon: const Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.error_outline,
            color: Colors.white,
            size: 35.0,
          ),
        ),
        duration: Duration(seconds: duracion));
  }

  static void showSnakbarOK(String titulo, String msg, int duracion,
      [SnackPosition? position]) {
    Get.snackbar(titulo, msg,
        titleText: estiloTexto(titulo, 16.0, true, Colors.white),
        colorText: Colors.white.withOpacity(0.8),
        snackPosition: position ?? SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        borderColor: Colors.white.withOpacity(0.8),
        borderWidth: 1,
        icon: const Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.verified_user_outlined,
            color: Colors.white,
            size: 35.0,
          ),
        ),
        duration: Duration(seconds: duracion));
  }

  static Widget copyRight() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          '©${Constantes.nombreET}',
          style: const TextStyle(fontSize: 9.0, fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  static Widget circulo(double wh, Color color) {
    return Container(
      width: wh,
      height: wh,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(color: color, width: 0.0), //20,0
        boxShadow: [
          BoxShadow(
            color: color,
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }

  static fondo(BuildContext context) {
    final Size size = Utils.mediaQuerySize(context);
    final fondo = SizedBox(
      height: size.height,
      width: double.infinity,
    );
    final verde = colorVerde(0.1);
    final guindo = colorGuindo(0.1);
    return Stack(
      children: <Widget>[
        fondo,
        Positioned(
          child: circulo(size.height * 0.45, guindo),
          top: -size.height * 0.1,
          right: -size.height * 0.1,
        ),
        const SizedBox(height: 200.0),
        Positioned(
          child: circulo(size.height * 0.40, verde),
          bottom: -size.height * 0.1,
          left: -size.height * 0.1,
        ),
      ],
    );
  }

  static void showAlert(
      BuildContext context, String title, Color colorTitle, String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyle(color: colorTitle),
            ),
            content: Text(
              msg,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18.0),
            ),
            actions: <Widget>[
              ElevatedButton(
                  style: Utils.estiloBoton(Colors.transparent),
                  onPressed: () => Navigator.of(context).pop(),
                  child: estiloTexto("Ok", 18.0, true, colorVerde(0.9)))
            ],
          );
        });
  }

  static void showAwesomeDialog(String title, Widget body,
      [bool? sinBotonok = false]) {
    Get.defaultDialog(
      title: title,
      titleStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? colorGuindo(0.8) : colorVerde(0.8)),
      //middleText: msg,
      content: body,
      backgroundColor: Get.isDarkMode
          ? Colors.black.withOpacity(0.7)
          : Colors.white.withOpacity(0.7),
      actions: sinBotonok!
          ? []
          : [
              TextButton(
                child: estiloTexto("Ok", 16.0, true, colorVerde(0.8)),
                onPressed: () => Get.back(),
              )
            ],
    );
  }

  static void showConfirmCloseApp(String titulo, String msg) {
    final lc = Get.find<LoginController>();
    Get.defaultDialog(
      title: titulo,
      content: lc.getAuth ? Text(msg) : const Text(''),
      actions: <Widget>[
        TextButton(
          child: estiloTexto(' Aceptar ', 14.0, true),
          onPressed: () async {
            lc.setAuth(false);
            await DBProvider.db.deleteTable(Constantes.tablaUsuario);
            Get.back();
            //Get.offAllNamed(HomePage.route);
          },
        ),
        TextButton(
          child: estiloTexto(' Cancelar ', 14.0, true),
          onPressed: () => Get.back(),
        )
      ],
    );
  }

  static void showConfirmCloseSessionYSalir(
      BuildContext context, String title, Color colorTitle, String msg) {
    final lc = Get.find<LoginController>();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyle(color: colorTitle),
            ),
            content: lc.getAuth ? Text(msg) : const Text(''),
            actions: <Widget>[
              ElevatedButton(
                  style: Utils.estiloBoton(Colors.transparent),
                  child: estiloTexto(
                    'Confirmar',
                    16.0,
                    true,
                    colorVerde(0.9),
                  ),
                  onPressed: () {
                    lc.setAuth(false);
                    //Navigator.pushReplacementNamed(context, HomePage.route);
                    //UtilsForms.cleanStorage();
                    SystemNavigator.pop();
                  }),
              ElevatedButton(
                  style: Utils.estiloBoton(Colors.transparent),
                  onPressed: () => Navigator.of(context).pop(),
                  child: estiloTexto(
                    'Cancelar',
                    16.0,
                    true,
                    colorGuindo(0.9),
                  ))
            ],
          );
        });
  }

  static bool isPasswordCompliant(String password, [int minLength = 6]) {
    if (password.isEmpty) {
      return false;
    }
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasMinLength = password.length >= minLength;
    return hasDigits & hasUppercase & hasLowercase & hasMinLength;
  }

  static String encodeBase64(String pass) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.encode(pass);
  }

  static String formatDate(String fecha) {
    if (fecha.isNotEmpty) {
      var fechaSplit = fecha.split('-');
      return ("${fechaSplit[2]}/${fechaSplit[1]}/${fechaSplit[0]}");
    }
    return "Sin fecha";
  }

  static String replacePoint(String monto) {
    if (monto.isNotEmpty) {
      var fechaSplit = monto.split('.');
      return (fechaSplit.length == 1
          ? "${fechaSplit[0]},00"
          : "${fechaSplit[0]},${fechaSplit[1]}");
    }
    return "Sin dato";
  }

  static estiloShapeVerde() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Utils.colorVerde(0.9), width: 2.0));
  }

  static estiloShapeGris() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: const BorderSide(color: Colors.grey, width: 2.0));
  }

  static estiloShapeGuindo() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Utils.colorGuindo(0.9), width: 2.0));
  }

  static Text estiloTexto(String txt, double tamanio, bool fontWeight,
          [Color? col, bool? center]) =>
      Text(
        txt,
        textAlign: center == true ? TextAlign.center : TextAlign.left,
        style: Get.textTheme.bodyMedium!.copyWith(
            fontSize: tamanio,
            fontWeight: fontWeight ? FontWeight.bold : null,
            color: col ?? Colors.black87),
      );

  static imagenFoco(BuildContext context) => ElevatedButton(
        style: Utils.estiloBoton(Colors.transparent),
        child: const Image(
          image: AssetImage('assets/img/foco-con-texto.png'),
        ),
        onPressed: () {
          //Navigator.pushReplacementNamed(context, HomePage.route);
        },
      );

  static Widget circulrProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: SizedBox(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(colorVerde(0.8)),
          strokeWidth: 4.0,
        ),
        height: 45.0,
        width: 45.0,
      ),
    );
  }

  static String getSaludo() {
    int hora = DateTime.now().hour;
    String saludo = 'Buen día';
    if (hora >= 12 && hora < 18) saludo = 'Buenas tardes';
    if (hora >= 18 && hora <= 23) saludo = 'Buenas noches';
    return saludo;
  }

  static ElevatedButton botonIconMenu(
          IconData icono, BuildContext context, String nomRuta) =>
      ElevatedButton(
          style: estiloBoton(Colors.transparent),
          child: Icon(
            icono,
            size: 40.0,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, nomRuta);
          });

  static ButtonStyle estiloBoton(Color color) => ElevatedButton.styleFrom(
      primary: color,
      onPrimary: color,
      onSurface: color,
      shadowColor: color,
      //minimumSize: Size(30.0, 30.0),
      animationDuration: const Duration(milliseconds: 1));
  static ButtonStyle estiloBotonRedondeado(Color color) =>
      ElevatedButton.styleFrom(
        primary: color,
        onPrimary: color,
        onSurface: color,
        shadowColor: color,
        //minimumSize: Size(30.0, 30.0),
        animationDuration: const Duration(milliseconds: 1),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
        //side: BorderSide(color: color, width: 2.0)
      );
  static ButtonStyle estiloBotonBordeColor(OutlinedBorder estiloShapeColor) =>
      ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onPrimary: Colors.transparent,
          onSurface: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: estiloShapeColor,
          animationDuration: const Duration(milliseconds: 1));
  static espacioV05() => const SizedBox(
        height: 05.0,
      );
  static espacioV10() => const SizedBox(
        height: 10.0,
      );
  static espacioV15() => const SizedBox(
        height: 15.0,
      );
  static espacioV20() => const SizedBox(
        height: 20.0,
      );
  static espacioV25() => const SizedBox(
        height: 25.0,
      );
  static espacioV30() => const SizedBox(
        height: 30.0,
      );
  static espacioV35() => const SizedBox(
        height: 35.0,
      );
  static espacioV40() => const SizedBox(
        height: 40.0,
      );
  static espacioV45() => const SizedBox(
        height: 45.0,
      );
  static espacioV50() => const SizedBox(
        height: 50.0,
      );

  static inputText(TextEditingController controllerText, bool read,
      String label, TextInputType inputType,
      [String? textoError]) {
    return TextField(
      controller: controllerText,
      keyboardType: inputType,
      readOnly: read,
      style: TextStyle(fontSize: 12.0, color: Utils.colorGuindo(0.6)),
      decoration: InputDecoration(
          labelText: label,
          contentPadding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          labelStyle: TextStyle(color: Utils.colorGuindo(0.8)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Utils.colorVerde(0.4), width: 1.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Utils.colorVerde(0.8), width: 1.5),
            borderRadius: BorderRadius.circular(20.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
          //counterText: snapshot.data
          errorStyle: TextStyle(color: Colors.red[900], fontSize: 11.0),
          errorText: textoError),
    );
  }

  static inputButton(String title, Future func, Color color) async {
    return TextButton(
      onPressed: () => func,
      child: estiloTexto(title, 12.0, true, color),
    );
  }

  /*static List<DropdownMenuItem> inputDopDown() {
    List<DropdownMenuItem> items = [];
    for (var e in l) {
      items.add(new DropdownMenuItem(
          value: "${e.id}", 
          child: Text(e.desc)
        )
      );
    }
    return items;
  }*/

  static get espacio05 => const SizedBox(height: 05.0, width: 05.0);
  static get espacio10 => const SizedBox(height: 10.0, width: 10.0);
  static get espacio15 => const SizedBox(height: 15.0, width: 15.0);
  static get espacio20 => const SizedBox(height: 20.0, width: 20.0);
  static get espacio25 => const SizedBox(height: 25.0, width: 25.0);
  static get espacio30 => const SizedBox(height: 30.0, width: 30.0);
  static get espacio35 => const SizedBox(height: 35.0, width: 35.0);
  static get espacio40 => const SizedBox(height: 40.0, width: 40.0);
  static get espacio45 => const SizedBox(height: 45.0, width: 45.0);
  static get espacio50 => const SizedBox(height: 50.0, width: 50.0);
  static get espacio55 => const SizedBox(height: 55.0, width: 55.0);
  static get espacio60 => const SizedBox(height: 60.0, width: 60.0);

  static estiloLetraInput() => const TextStyle(fontSize: 18);

  static InputDecoration estiloInputTextFiledLogin(String hintTextLabel,
      [bool todosBordes = false]) {
    bool isDark = Get.isDarkMode;
    return InputDecoration(
        hintText: hintTextLabel,
        hintStyle: TextStyle(
            color: isDark ? Colors.grey[400] : Colors.black87, fontSize: 15),
        fillColor: isDark ? Colors.black87 : Colors.white70,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: todosBordes
                ? const BorderRadius.all(Radius.circular(10))
                : const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
            borderSide: BorderSide(
                color: isDark ? Colors.white38 : Colors.black12, width: 1)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Utils.colorVerde(0.8), width: 1),
          borderRadius: todosBordes
              ? const BorderRadius.all(Radius.circular(10))
              : const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: todosBordes
              ? const BorderRadius.all(Radius.circular(10))
              : const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: todosBordes
              ? const BorderRadius.all(Radius.circular(10))
              : const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
        ));
  }

  static loadingCustom([double? size]) => Center(
        child: SpinKitCubeGrid(
          color: Get.isDarkMode ? Utils.colorVerde(0.8) : Utils.colorVerde(0.8),
          size: size ?? 50.0,
        ),
      );
  static boxDecoraton([Color? c, DecorationImage? di]) => BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1), //color of shadow
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(5),
        //color: c ?? Colors.grey.shade100,
        image: di,
      );
  static boxDecorationBorder([Color? c, DecorationImage? di]) =>
      BoxDecoration(border: Border.all(color: c ?? Colors.blueAccent));

  static elevatedButton(
          String txtboton, Color colorBorde, VoidCallback voidCallback,
          [double tamanioLetra = 12.0, Color colorLetra = Colors.white]) =>
      ElevatedButton(
          style: Utils.estiloBoton(colorBorde),
          child:
              Utils.estiloTexto(txtboton, tamanioLetra, true, colorLetra, true),
          onPressed: voidCallback);
  static elevatedButtonWidgetContent(
          Widget content, Color colorBorde, VoidCallback voidCallback) =>
      ElevatedButton(
          style: Utils.estiloBotonRedondeado(colorBorde),
          child: content,
          onPressed: voidCallback);

  /*static Map<String, dynamic> decodedToken(String jwt) {
    Map<String, dynamic> payload = Jwt.parseJwt(jwt);
    return payload;
  }*/

  static Future<String> readJsonFile(String pathJsonFile) async {
    final String response = await rootBundle.loadString(pathJsonFile);
    //final data = await json.decode(response);
    return response;
    //log("message: ${data[dataField].length}");
  }

  static void sortList(List<DataPathModel> l) =>
      l.sort((a, b) => a.nombre.compareTo(b.nombre));

  static Color hexadecColor(String hColor, [double? o]) =>
      HexColor(hColor).withOpacity(o ?? 0.8);

  static Future<void> soundOk() async {
    await player.setSource(AssetSource('sounds/ok-sound.mp3'));
    await player.play(AssetSource('sounds/ok-sound.mp3'));
  }

  static Future<void> soundFail() async {
    await player.setSource(AssetSource('sounds/fail-sound.mp3'));
    await player.play(AssetSource('sounds/fail-sound.mp3'));
  }

  static boton3D(String titulo, Color colorBoton, bool fontWeigth,
      void Function()? onPressedm,
      [Widget? icono]) {
    return PushableButton(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
            mainAxisAlignment: icono != null
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              icono ?? Utils.espacio05,
              estiloTexto(titulo, 16, fontWeigth)
            ]),
      ),
      height: 60,
      elevation: 10,
      hslColor:
          HSLColor.fromColor(colorBoton), // .fromAHSL(1.0, 120, 1.0, 0.37),
      shadow: BoxShadow(
        color: Colors.grey.withOpacity(0.4),
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(0, 2),
      ),
      onPressed: onPressedm,
    );
  }
}
