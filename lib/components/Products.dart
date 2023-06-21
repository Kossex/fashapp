import 'package:flutter/material.dart';
import 'package:app/pages/ProductDetails.dart';

class Products extends StatefulWidget {
  const Products({Key? key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    {
      "name": "Dark Blazer",
      "img": "images/products/blazer1.jpg",
      "old_price": 150,
      "new_price": 95
    },
    {
      "name": "Red Dress ",
      "img": "images/products/dress1.jpg",
      "old_price": 100,
      "new_price": 75
    },
    {
      "name": "Pink Blazer",
      "img": "images/products/blazer2.jpg",
      "old_price": 140,
      "new_price": 85
    },
    {
      "name": "Dark Dress",
      "img": "images/products/dress2.jpg",
      "old_price": 110,
      "new_price": 100
    },
    {
      "name": " Green Hills",
      "img": "images/products/hills1.jpg",
      "old_price": 70,
      "new_price": 50
    },
    {
      "name": "Pink Hills",
      "img": "images/products/hills2.jpg",
      "old_price": 120,
      "new_price": 95
    },
    {
      "name": "Dark pants",
      "img": "images/products/pants1.jpg",
      "old_price": 150,
      "new_price": 95
    },
    {
      "name": "Grey Pants",
      "img": "images/products/pants2.jpg",
      "old_price": 140,
      "new_price": 100
    },
    {
      "name": "Blue Skirt",
      "img": "images/products/skt1.jpg",
      "old_price": 150,
      "new_price": 95
    },
    {
      "name": "Pink Skirt",
      "img": "images/products/skt2.jpg",
      "old_price": 135,
      "new_price": 115
    },
    {
      "name": "Brown Shoes",
      "img": "images/products/shoe1.jpg",
      "old_price": 200,
      "new_price": 170
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: product_list.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return SingleProduct(
          prod_name: product_list[index]["name"] as String,
          prod_img: product_list[index]["img"] as String,
          prod_new_price: product_list[index]["new_price"] as int,
          prod_old_price: product_list[index]["old_price"] as int,
        );
      },
    );
  }
}

class SingleProduct extends StatelessWidget {
  final String prod_name;
  final String prod_img;
  final int prod_old_price;
  final int prod_new_price;

  const SingleProduct({
    required this.prod_name,
    required this.prod_img,
    required this.prod_old_price,
    required this.prod_new_price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: prod_name,
        child: Material(
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDetails(
                  product_detail_name: prod_name,
                  product_detail_picture: prod_img,
                  product_detail_old_price: prod_old_price,
                  product_detail_new_price: prod_new_price,
                ),
              ),
            ),
            child: GridTile(
              footer: Container(
                height: 60.0,
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    prod_name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  title: Text(
                    "\$$prod_new_price",
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.red,
                    ),
                  ),
                  subtitle: Text(
                    "\$$prod_old_price",
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
              ),
              child: Image.asset(
                prod_img,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
