import 'package:ge0tic/src/providers/base_provider.dart';
import 'package:ge0tic/src/utils/constantes.dart';
import 'package:ge0tic/src/utils/utils.dart';

class LoginProvider {
  Future loginUsuario(String email, String password) async {
    final authData = {
      'usuario': email.trim(),
      'password': Utils.encodeBase64(password)
    };
    final _resp = await BaseProvider().baseProvider(
      Constantes.servLogin,
      authData,
      Constantes.headers,
      Constantes.post,
    );
    return _resp;
  }
}
