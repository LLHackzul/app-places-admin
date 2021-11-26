import 'package:flutter/material.dart';
import '../providers/places_provider.dart';
import '../models/place.dart';
import 'package:provider/provider.dart';

class EditPlaceScreen extends StatefulWidget {
  static const routeName = '/edit-place';

  @override
  _EditPlaceScreenState createState() => _EditPlaceScreenState();
}

class _EditPlaceScreenState extends State<EditPlaceScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedPlace = Place(
    id: '',
    title: '',
    description: '',
    img: '',
  );
  var _isInit = true;
  var _initValues = {
    'title': '',
    'description': '',
    'img': '',
  };
  var _isLoading = false;
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);

    super.initState();
  }
    void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty ) {
        return;
      }
      setState(() {});
    }
  }

   @override
  void didChangeDependencies() {
    if (_isInit) {
      final placeId = ModalRoute.of(context)!.settings.arguments;
      if (placeId != null) {
        final place = Provider.of<Places>(context, listen: false)
            .findById(placeId as String);
        _editedPlace = place;
        _initValues = {
          'title': _editedPlace.title,
          'description': _editedPlace.description,
          'img': '',
        };
        _imageUrlController.text = _editedPlace.img;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

   @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();

    super.dispose();
  }

  
  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedPlace.id != '') {
      /* await Provider.of<Places>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct); */
    } else {
      try {
        await Provider.of<Places>(context, listen: false)
            .addPlace(_editedPlace);
      } catch (error) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text(
                    'Ocurrio un error!',
                  ),
                  content: Text('Algo ocurrió mal :('),
                  actions: [
                    FlatButton(
                        child: Text('Okay'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                ));
      }/*  finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      } */
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(
                        labelText: 'Titulo',
                      ),
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        _editedPlace = Place(
                          title: value as String,
                          description: _editedPlace.description,
                          img: _editedPlace.img,
                          id: _editedPlace.id,
                        );
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Porfavor ingrese un valor';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(
                        labelText: 'Descripcion',
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      onSaved: (value) {
                        _editedPlace = Place(
                          title: _editedPlace.title,
                          description: value as String,
                          img: _editedPlace.img,
                          id: _editedPlace.id,
                        );
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Porfavor ingrese un valor';
                        }
                        if (value.length < 10) {
                          return 'Almenos tienen que ser 10 caracteres';
                        }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Ingresa una URL')
                              : FittedBox(
                                  child:
                                      Image.network(_imageUrlController.text),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Url de la Imagen'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            onSaved: (value) {
                              _editedPlace = Place(
                                title: _editedPlace.title,
                                description: _editedPlace.description,
                                img: value as String,
                                id: _editedPlace.id,
                              );
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Porfavor ingrese una imagen';
                              }
                              
                              return null;
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}