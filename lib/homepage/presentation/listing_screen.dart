import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:meetup/homepage/model/listing.dart';

import 'description_screen.dart';

class ListingScreen extends StatelessWidget {
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart))
          ],
          title: const Text("Nepal-Made"),
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                const Text("Our", style: TextStyle(fontSize: 23)),
                const Text("Products", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                const SizedBox(height: 10),
                DropdownSearch<String>(
                  popupProps: PopupProps.menu(
                    showSelectedItems: true,
                    disabledItemFn: (String s) => s.startsWith('I'),
                  ),
                  items: const ["Product 1", "Product 2", "Product 3", 'Product 4'],
                  dropdownDecoratorProps: const DropDownDecoratorProps(),
                  onChanged: print,
                  selectedItem: "Product 1",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: FutureBuilder(
                      future: ReadJsonData(),
                      builder: (context, data) {
                        if (data.hasError) {
                          //in case if error found
                          return Center(child: Text("${data.error}"));
                        } else if (data.hasData) {
                          var items = data.data as List<ProductDetails>;
                          return SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                              ),
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(Description(
                                      details: items[index],
                                    ));
                                  },
                                  child: SizedBox(
                                    child: Card(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 150,
                                              decoration:
                                                  BoxDecoration(image: DecorationImage(image: NetworkImage(items[index].image!), fit: BoxFit.fill)),
                                              child: Center(
                                                child: Text(items[index].productName!),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              padding: const EdgeInsets.all(8),
                                              height: 60,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Text(items[index].productName!),
                                                      Text("Rs. ${items[index].price!}"),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5),
                                                  RatingBar.builder(
                                                    initialRating: double.parse(items[index].ratings!),
                                                    minRating: 1,
                                                    itemSize: 20,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                    itemBuilder: (context, _) => const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      print(rating);
                                                    },
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                )
              ])),
        ));
  }
}
