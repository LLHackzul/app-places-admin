import 'package:flutter/material.dart';

class SiteDetailScreen extends StatelessWidget {
  static const routeName = '/site-detail-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Parque Nacional de Tikal',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Divider(
                color: Colors.black87,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: FadeInImage(
                      placeholder: AssetImage('assets/img/placeholder.png'),
                      image: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/example-89004.appspot.com/o/San%20Felipe.jpg?alt=media&token=90a9e95e-1b8b-4185-a2e2-cff28eced01c'),
                      fit: BoxFit.cover,
                      width: 150,
                      height: 240,
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                      child: Container(
                          height: 250,
                          child: SingleChildScrollView(
                              child: Text(
                            "La antigua ciudad Maya de Tikal es una de las mayores riquezas culturales, naturales y de valor universal de Guatemala. El parque fue declarado como el primer sitio Patrimonio Mundial Cultural y Natural de la humanidad en 1979 por la UNESCO. encuentra situada en el municipio de Flores, departamento de Petén. Este asentamiento prehispánico es el más extenso del país, se dice que llego a tener 100,000 habitantes durante su época de mayor esplendor.",
                            style: TextStyle(color: Colors.grey,),
                            textAlign: TextAlign.justify,
                          )))),
                ],
              ),
               Text(
                'Actividades',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
               Text(
                'Localización',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}
