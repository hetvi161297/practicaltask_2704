
import 'package:flutter/material.dart';
import 'package:practicle_task/model/Product.dart';

// ignore: must_be_immutable
class ProductDetailScreen extends StatefulWidget {

  ProductDetailScreen(this.index, this.productdata, {super.key});
int index=0;
List<Product> productdata;
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

@override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final productId = widget.index;
   

    var productdata=widget.productdata;
    return Scaffold(
      appBar: AppBar(
        title: 
          
            Text(productdata[productId].title,softWrap: true,maxLines: 1,style: const TextStyle(overflow: TextOverflow.ellipsis),),
              actions: [
                IconButton(
                        icon:  Icon(
                           productdata[productId].isFavourite ? Icons.favorite : Icons.favorite_border),
                        color: Colors.red,
                        onPressed: () async{
                         // toggle here
                         productdata[productId].toggleFavorite();
                         setState(() {});
                        },
                      ),
             ],
          
        ),
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: Hero(
              tag: productdata[productId].id,
              child: Image.network(
                productdata[productId].images[0],
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Card(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        "Price",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Chip(
                        label: Text(
                          "\$${productdata[productId].price}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                     
                    ]),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "\$${productdata[productId].description}",
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
