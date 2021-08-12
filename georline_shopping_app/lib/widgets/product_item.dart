import 'package:flutter/material.dart';
import 'package:georline_shopping_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  ProductItem(
    this.id,
    this.title,
    this.imageUrl,
    this.price,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context)
        //     .pushNamed(ProductDetailScreen.routeName, arguments: {
        //   "id": id,
        //   "title": title,
        // });
        Navigator.of(context)
            .pushNamed(ProductDetailScreen.routeName, arguments: id);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GridTile(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          // header: GridTileBar(
          //   title: Text(
          //     'Some title',
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            title: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "\$$price",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            leading: IconButton(
              icon: Icon(
                Icons.favorite,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {},
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
