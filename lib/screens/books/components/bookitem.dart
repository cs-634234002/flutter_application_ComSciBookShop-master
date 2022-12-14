import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_lab1/screens/books/bookdetail_screen.dart';
import 'package:flutter_application_lab1/screens/books/components/bookitem_add.dart';
import 'package:flutter_application_lab1/models/book.dart';
import 'package:flutter_application_lab1/models/cart.dart';

class BookItem extends StatelessWidget {
  final Book book;
  const BookItem({
    Key? key,
    required this.book,
  }) : super(key: key);

  //Build ButtonSheet
  Widget buildButtomSheet(BuildContext context) {
    return AddBookItem(
        cartItem: CartItem(
            coffeeId: book.coffeeId,
            coffeeName: book.coffeeName,
            coffeePrice: book.coffeePrice,
            coffeePicture: book.coffeePicture,
            coffeeDescription: book.coffeeDescription,
            qty: 1));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87.withOpacity(0.7),
          title: Text(
            book.coffeeName,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.orangeAccent,
              size: 25,
            ),
            onPressed: () {
              //Show Buttom Sheet for adding item to cart
              showModalBottomSheet(context: context, builder: buildButtomSheet);
            },
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookDetailScreen(book: book)),
            );
          },
          //Using CachedNetworkImage
          child: CachedNetworkImage(
            imageUrl: book.coffeePicture,
            fit: BoxFit.fitWidth,
            placeholder: (context, url) => Image.asset(
              'assets/images/book_loading.png',
              fit: BoxFit.fitWidth,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
