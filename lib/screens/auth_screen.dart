import 'package:flutter/material.dart';
import '../providers/auth.dart';
import '../models/http_exception.dart';
import 'package:provider/provider.dart';
import 'dart:math';
enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: (mediaQuery.size.height - mediaQuery.padding.top),
                child: Image.asset(
                  'assets/img/GuateLogo.png',
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 100),
                    child: Center(
                        child: Image.asset(
                      'assets/img/logo1.png',
                      fit: BoxFit.cover,
                  
                    )),
                  ),
                  Flexible(
                    flex: mediaQuery.size.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}


class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  AnimationController? _controller;
  Animation<Offset>? _slideAnimation;
  Animation<double>? _opacityAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 300,
        ));
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
        parent: _controller as Animation<double>, curve: Curves.fastOutSlowIn));
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller as Animation<double>, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller!.dispose();
  }

  void _showErrorDialog(String message, BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Un error ha ocurrido'),
              content: Text(message),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'))
              ],
            ));
  }

   Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).login(
            _authData['email'] as String, _authData['password'] as String);
      } else {
        await Provider.of<Auth>(context, listen: false).signUp(
            _authData['email'] as String, _authData['password'] as String);
      }
    } on HttpException catch (error) {
      var errorMessage = 'Fallo la autenticación :c';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'El correo ya esta en uso';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'El correo no es válido';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'La contraseña es muy debil';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'No se pudo encontrar un usuario con el correo';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'La contraseña no es válida';
      }
      _showErrorDialog(errorMessage, context);
    } catch (error) {
      const errorMessage =
          'Algo salió mal, por favor intenta de nuevo mas tarde';
      _showErrorDialog(errorMessage, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller!.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller!.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final meduaQuery = MediaQuery.of(context);
    return Card(
      margin: EdgeInsets.only(left: 110, right: 15, bottom: 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: _authMode == AuthMode.Signup ? 320 : 260,
        /*  height: _heightAnimation!.value.height, */
        constraints: BoxConstraints(
          minHeight: _authMode == AuthMode.Signup ? 320 : 260,
        ),
        width: meduaQuery.size.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Correo'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'correo inválido!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Contraseña muy corta!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                /*  if (_authMode == AuthMode.Signup) */
                AnimatedContainer(
                  constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                    maxHeight: _authMode == AuthMode.Signup ? 120 : 0,
                  ),
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  child: FadeTransition(
                    opacity: _opacityAnimation as Animation<double>,
                    child: SlideTransition(
                      position: _slideAnimation!,
                      child: TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        decoration:
                            InputDecoration(labelText: 'Confirmar Contraseña'),
                        obscureText: true,
                        validator: _authMode == AuthMode.Signup
                            ? (value) {
                                if (value != _passwordController.text) {
                                  return 'Las contraseñas no coinciden!';
                                }
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child: Text(_authMode == AuthMode.Login
                        ? 'Iniciar Sesión'
                        : 'Registrarse'),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button!.color,
                  ),
                FlatButton(
                  child: Text(
                    '${_authMode == AuthMode.Login ? 'REGISTRARSE' : 'INICIAR SESIÓN'} EN SU LUGAR',
                    style: TextStyle(fontSize: 12),
                  ),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
