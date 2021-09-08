import 'package:flutter/material.dart';
import 'package:georline_shopping_app/providers/cart.dart';
import 'package:georline_shopping_app/providers/product.dart';
import 'package:georline_shopping_app/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // final double price;
  // ProductItem(
  //   this.id,
  //   this.title,
  //   this.imageUrl,
  //   this.price,
  // );

  @override
  Widget build(BuildContext context) {
    final scaffoldMessanger = ScaffoldMessenger.of(context);
    final product = Provider.of<Product>(
      context,
      // if this is false, we can't see changes when we favorite the item, default is true, so we don't have to set it to true
      listen:
          false, // we set it to false so that the whole widget is not re-created when we faver the item, but we will use Consumer to see changes in the favorite
    );

    final Cart cart = Provider.of<Cart>(context);
    return GestureDetector(
      onTap: () {
        // Navigator.of(context)
        //     .pushNamed(ProductDetailScreen.routeName, arguments: {
        //   "id": id,
        //   "title": title,
        // });
        Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
          arguments: product.id,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GridTile(
          child: Image.network(
            product.imageUrl,
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
                  product.title,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "\$${product.price}",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            leading: Consumer<Product>(
              // product is the same as product in the Provider.of(Product)
              builder: (context, product, child) => IconButton(
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  product.toggleFavoriteStatus().catchError((e) =>
                      scaffoldMessanger
                          .showSnackBar(SnackBar(content: Text(e.toString()))));
                },
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                cart.addItem(product.id, product.title, product.price);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added ${product.title} to cart!'),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
