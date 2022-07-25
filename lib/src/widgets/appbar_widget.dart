import 'package:flutter/material.dart';
import 'package:ge0tic/src/utils/utils.dart';
import 'package:get/get.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Widget? auxWidget;
  const AppBarWidget({Key? key, required this.title, this.auxWidget})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
  @override
  final Size preferredSize; // default is 56.0

}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  build(BuildContext context) {
    return AppBar(
      //leading: InkWell(onTap: () => Get.back(), child: Utils.imagenFoco(context)),
      leadingWidth: 55.0,
      backgroundColor: Utils.primaryColor,
      title: Row(
        children: [
          widget.auxWidget ?? Container(),
          Utils.estiloTexto(widget.title, 16.0, false, Colors.white),
        ],
      ),
      //automaticallyImplyLeading: true,
      centerTitle: false,
      //cambia el color del ENdDrawer
      //foregroundColor: Colors.orange[900],
      //shape: Utils.estiloShapeVerde(),
      elevation: 5.0,
    );
  }
}
