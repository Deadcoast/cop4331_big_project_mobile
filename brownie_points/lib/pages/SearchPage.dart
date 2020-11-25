import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override

  List<String> names = ["Recipe1", "Recipe2", "Recipe3", "Recipe2", "Recipe3", "Recipe2", "Recipe3", "Recipe2", "Recipe3", "Recipe2", "Recipe3", "Recipe2", "Recipe3", "Recipe2", "Recipe3", "Recipe2", "Recipe3"];

  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: names.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index)
      {
        return createRecipieCard('${names[index]}', null, null);
      },
    );
  }

  Card createRecipieCard(String name, String image, String user)
  {
    Image img;
    if(image == null)
      img = Image.network("https://banner.uclipart.com/20200112/lqt/mexican-food-cartoon-line.png");
    else
      img = Image.network(image);
    if(name == null)
      name = "College Degree";
    if(user == null)
      user = "Rick Leinicker";

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [ListTile(
          title: Text(name),
          subtitle: Text(user),
        ),

          img,
          FlatButton(
            onPressed: () {
              //TODO: Favorite that recipe
            },
            child: Text('Favorite'),
          ),
        ],
      ),
    );
  }
}