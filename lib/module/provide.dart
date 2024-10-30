

import 'package:flutter/material.dart';


class Service extends ChangeNotifier {

  bool _obscureText = false ;
  bool get obscureText => _obscureText;
  
  void toggle(){
    _obscureText = !_obscureText;
    notifyListeners();
  }
  List<Product> _items = [];
  

  List<Product> get items => _items;
 
  void addItem(Product product) async{
      _items.add(product);
      notifyListeners();
  }
}

class Product {

  String title;
  String names;
 
  Product({required this.title,required this.names});

  Map<String, dynamic> toJson() {
    return {
      
      'title': title,
      'price': names,

    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      
      title: json['title'],
      names: json['price'],

    );
  }
}
class Item {
  final String id;
  final String name;

  Item({required this.id, required this.name});
}



