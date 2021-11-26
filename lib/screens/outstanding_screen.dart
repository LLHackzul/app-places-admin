import 'package:flutter/material.dart';
import '../widgets/outstanding_grid.dart';
class OutstandingPlacesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Destacado',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: const Text(
                  'Los mejores lugares para explorar',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
              const Divider(color: Colors.black87,),
              Expanded(child: OutstandingGrid()),
            ],
          ),
        ),
      ),
    );
  }
}