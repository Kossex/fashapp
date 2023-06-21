import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Element('Accessories', 'images/cats/accessories.png'),
          Element('Dress', 'images/cats/dress.png'),
          Element('Informal', 'images/cats/informal.png'),
          Element('Formal', 'images/cats/formal.png'),
          Element('T-shirt', 'images/cats/tshirt.png'),
          Element('Shoes', 'images/cats/shoes.png'),
          Element('Pants', 'images/cats/jeans.png'),
        ],
      ),
    );
  }
}

class Element extends StatelessWidget {
  final String imgLocation;
  final String imgCaption;

  const Element(this.imgCaption, this.imgLocation);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 110.0,
          height: 80.0,
          child: ListTile(
            title: Image.asset(
              imgLocation,
              width: 110.0,
              height: 80.0,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(imgCaption),
            ),
          ),
        ),
      ),
    );
  }
}
