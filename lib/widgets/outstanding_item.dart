import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../screens/site_detail_screen.dart';
class OutstandingItem extends StatelessWidget {
  const OutstandingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
         Navigator.of(context).pushNamed(SiteDetailScreen.routeName);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 8,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              child: GestureDetector(
                onTap: () {},
                child:Container(
                  height: 100,
                  width: double.infinity,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/img/placeholder.png'),
                    image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/example-89004.appspot.com/o/yaxha.jpg?alt=media&token=7c658869-8351-4f52-9962-a13e3db392c2'),
                    fit: BoxFit.cover,
                  ),
                ), 
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      'Yaxhá',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 80,
                    child: FittedBox(
                      child: RatingBar.builder(
                        ignoreGestures: true,
                        initialRating: 4.5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Tour completo por yaxha, no te lo puedes perder!',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                  ),
                
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Colors.blue,
                      ),
                      Text(
                        'Petén',
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



/* ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {},
          child: Image.network(
            'https://firebasestorage.googleapis.com/v0/b/example-89004.appspot.com/o/yaxha.jpg?alt=media&token=7c658869-8351-4f52-9962-a13e3db392c2',
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
          title: FittedBox(
            child: Text(
              'Yaxhá',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    ) */