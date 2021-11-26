import 'package:flutter/material.dart';
import '../providers/sites_provider.dart';
import '../models/site.dart';
import 'package:provider/provider.dart';

class EditSiteScreen extends StatefulWidget {
  static const routeName = '/edit-site';

  @override
  _EditSiteScreenState createState() => _EditSiteScreenState();
}

class _EditSiteScreenState extends State<EditSiteScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _editedSite = Site(
    id: '',
    title: '',
    description: '',
    history: '',
    image: '',
    placeId: '',
  );
  var _isInit = true;
  var _initValues = {
    'title': '',
    'description': '',
    'history': '',
    'image': '',
  };
  var _isLoading = false;
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);

    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty) {
        return;
      }
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
     
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
    if (_editedSite.id != '') {
      /* await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct); */
    } else {
      try {
        await Provider.of<Sites>(context, listen: false).addSite(_editedSite);
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
      }
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final placeId = ModalRoute.of(context)!.settings.arguments as String;
       _editedSite = Site(
                          title: _editedSite.title,
                          description: _editedSite.description,
                          history: _editedSite.history,
                          image: _editedSite.image,
                          id: _editedSite.id,
                          placeId: placeId,
                        );
    return Scaffold(
      appBar: AppBar(
        title: Text('Sitios'),
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
                        labelText: 'titulo',
                      ),
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        _editedSite = Site(
                          title: value as String,
                          description: _editedSite.description,
                          history: _editedSite.history,
                          image: _editedSite.image,
                          id: _editedSite.id,
                          placeId: _editedSite.placeId,
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
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      onSaved: (value) {
                        _editedSite = Site(
                          title: _editedSite.title,
                          description: value as String,
                          history: _editedSite.history,
                          image: _editedSite.image,
                          id: _editedSite.id,
                          placeId: _editedSite.placeId,
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
                      initialValue: _initValues['history'],
                      decoration: InputDecoration(
                        labelText: 'Historia',
                      ),
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      onSaved: (value) {
                        _editedSite = Site(
                          title: _editedSite.title,
                          description: _editedSite.description,
                          history: value as String,
                          image: _editedSite.image,
                          id: _editedSite.id,
                          placeId: _editedSite.placeId,
                        );
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Porfavor ingrese un valor';
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
                              _editedSite = Site(
                                title: _editedSite.title,
                                description: _editedSite.description,
                                history: _editedSite.history,
                                image: value as String,
                                id: _editedSite.id,
                                placeId: _editedSite.placeId,
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
