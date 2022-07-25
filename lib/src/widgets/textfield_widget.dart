import 'package:flutter/material.dart';
import 'package:ge0tic/src/utils/utils.dart';

class TextFieldFormWidget extends StatefulWidget {
  final IconData? icon;
  final String? title;
  final TextInputType? type;
  final Function? validator;
  final Function? onSave;
  const TextFieldFormWidget(
      {Key? key, this.icon, this.title, this.type, this.validator, this.onSave})
      : super(key: key);

  @override
  _TextFieldFormWidgetState createState() => _TextFieldFormWidgetState();
}

class _TextFieldFormWidgetState extends State<TextFieldFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          widget.icon,
          size: 30.0,
        ),
        Utils.espacio05,
        Expanded(
          child: TextFormField(
            keyboardType: widget.type,
            style:
                TextStyle(fontSize: 13.0, color: Colors.black.withOpacity(0.8)),
            decoration: InputDecoration(
              labelText: widget.title,
              contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              labelStyle: TextStyle(color: Utils.colorGuindo(0.8)),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Utils.colorVerde(0.4), width: 1.0),
                borderRadius: BorderRadius.circular(50.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Utils.colorVerde(0.8), width: 2.0),
                borderRadius: BorderRadius.circular(50.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.circular(50.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.circular(50.0),
              ),
              //counterText: snapshot.data
            ),
            validator: (String? v) {
              return widget.validator.toString();
            },
            onSaved: (String? v) {
              widget.onSave.toString();
            },
          ),
        ),
        const SizedBox(
          width: 3.0,
        ),
      ],
    );
  }
}
