import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:oasis_cafe_app_store/strings/strings_en.dart';

import '../model/model_order.dart';

class OrderStateProvider with ChangeNotifier {

  final db = FirebaseFirestore.instance;
  late CollectionReference orderCollection;
  List<OrderModel> orderList = [];

  OrderStateProvider() {
    orderCollection = db.collection(Strings.collection_userOrder);
  }


  Future<void> getUserOrderList() async {
    orderList = await orderCollection.get().then((querySnapshot) {
      return querySnapshot.docs.map((document) {
        return OrderModel.getSnapshotData(document);
      }).toList();
    });

    notifyListeners();
  }

}