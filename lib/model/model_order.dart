import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {

  late String id;
  late String orderTime;
  late int quantity;
  late String itemName;
  late String itemPrice;
  late double totalPrice;
  late String drinkSize;
  late String cup;
  late int espressoOption;
  late String hotOrIced;
  late String syrupOption;
  late String whippedCreamOption;
  late String iceOption;

  OrderModel.getSnapshotData(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    id = snapshot.id;
    orderTime = data['orderTime'];
    quantity = data['quantity'];
    itemName = data['itemName'];
    itemPrice = data['itemPrice'];
    totalPrice = data['totalPrice'];
    drinkSize = data['drinkSize'];
    cup = data['cup'];
    espressoOption = data['espressoOption'];
    hotOrIced = data['hotOrIced'];
    syrupOption = data['syrupOption'];
    whippedCreamOption = data['whippedCreamOption'];
    iceOption = data['iceOption'];
  }
}