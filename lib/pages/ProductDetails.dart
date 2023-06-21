import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final String product_detail_name;
  final String product_detail_picture;
  final int product_detail_old_price;
  final int product_detail_new_price;

  const ProductDetails({
    required this.product_detail_name,
    required this.product_detail_picture,
    required this.product_detail_old_price,
    required this.product_detail_new_price,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Fashapp'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300.0,
            color: Colors.white,
            child: Container(
              child: GridTile(
                footer: Container(
                  color: Colors.white70,
                  child: ListTile(
                    leading: Text(
                      widget.product_detail_name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '\$${widget.product_detail_old_price}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '\$${widget.product_detail_new_price}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                child: Image.asset(widget.product_detail_picture),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Choose the size"),
                          content: Text("Size"),
                          actions: [
                            MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pop(context);
                              },
                              child: Text("Close"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  child: Row(
                    children: const [
                      Expanded(child: Text('Size')),
                      Expanded(child: Icon(Icons.arrow_drop_down)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Choose a color"),
                          content: Text("Color"),
                          actions: [
                            MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pop(context);
                              },
                              child: Text("Close"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  child: Row(
                    children: const [
                      Expanded(child: Text('Color')),
                      Expanded(child: Icon(Icons.arrow_drop_down)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Choose the Quantity"),
                          content: Text("Quantity"),
                          actions: [
                            MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pop(context);
                              },
                              child: Text("Close"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  child: Row(
                    children: const [
                      Expanded(child: Text('Number')),
                      Expanded(child: Icon(Icons.arrow_drop_down)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Buy now',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_basket),
                color: Colors.red,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
                color: Colors.red,
              ),
            ],
          ),
          const Divider(),
          const ListTile(
            title: Text("Product Details"),
            subtitle: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
            ),
          ),
          const Divider(),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12, 5, 5, 5),
                child: Text(
                  "Product name",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(widget.product_detail_name),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12, 5, 5, 5),
                child: Text(
                  "Product brand",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12, 5, 5, 5),
                child: Text(
                  "Product condition",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          SimilarSingleProduct(),
        ],
      ),
    );
  }
}

class SimilarSingleProduct extends StatefulWidget {
  @override
  State<SimilarSingleProduct> createState() => _SimilarSingleProductState();
}

class _SimilarSingleProductState extends State<SimilarSingleProduct> {
  var product_list = [
    {
      "name": "Dark Blazer",
      "img": "images/products/blazer1.jpg",
      "old_price": 150,
      "new_price": 95
    },
    {
      "name": "Red Dress",
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
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // Provide a fixed height or adjust as needed
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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
      ),
    );
  }
}

class SingleProduct extends StatelessWidget {
  final String prod_name;
  final String prod_img;
  final int prod_old_price;
  final int prod_new_price;

  const SingleProduct({
    super.key,
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
