import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practicle_task/Api/Api.dart';
import 'package:http/http.dart' as http;
import 'package:practicle_task/Screen/product_detail_screen.dart';
import 'package:practicle_task/model/Product.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> productdata = [];

  @override
  void initState() {
    super.initState();

    getproductData();
  }

  getproductData() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    var productsurl = Uri.parse(Api.BASE_URL + Api.products);

    var response = await http.get(
      productsurl,
      headers: headers,
    );

    var data = response.body;

    print(data);
    var jsonData = jsonDecode(data);
    print(jsonData);

    List getitem = jsonData;
    for (var item in getitem) {
      productdata.add(Product.fromJson(item));
    }
    print(productdata[0].price);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:
              const Text("Product List", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.deepPurple,
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(10.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: productdata.length,
  
          itemBuilder: (BuildContext context, int index) {
            print("index is $index ${productdata[index].title} ");
            return ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: InkWell(
                onTap: () {
                  print('object');

                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return ProductDetailScreen(index, productdata);
                  })));
                },
                child: GridTile(
                  footer: GridTileBar(
                    backgroundColor: Colors.black38,
                    title: Text(
                      productdata[index].title,
                      textAlign: TextAlign.center,
                    ),
                    trailing: Text(
                      " \$${productdata[index].price}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  child: Hero(
                    tag: productdata[index].id,
                    child: Image.network(
                      productdata[index].images[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
