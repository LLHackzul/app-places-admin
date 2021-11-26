import 'package:flutter/material.dart';
import '../widgets/places_grid.dart';
import 'package:provider/provider.dart';
import '../providers/places_provider.dart';
import '../screens/edit_place_screen.dart';
class PlacesScreen extends StatefulWidget {
  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  var _isInit = true;
  var _isLoading=false;
   @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading=true;
      });
      Provider.of<Places>(context).fetchAndSetPlaces().then((_) {
      _isLoading=false;
      });
      _isInit = false;

    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderWidget(),
            Expanded(child: _isLoading ? Center(child: CircularProgressIndicator(),): PlacesGrid()),
          ],
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Buscar y explorar',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 5),
            elevation: 8,
            color: Colors.grey.shade200,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  Icons.search,
                  size: 30,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Buscar lugares...',
                      border: InputBorder.none,
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                'Departamentos',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              IconButton(onPressed: (){
                 Navigator.of(context).pushNamed(EditPlaceScreen.routeName);
              }, icon: Icon(Icons.add))
            ],
          ),
          Divider(
            color: Colors.black87,
          ),
        ],
      ),
    );
  }
}
