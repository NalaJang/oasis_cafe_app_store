import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:oasis_cafe_app_store/strings/strings_en.dart';

import '../model/model_order.dart';

class OrderStateProvider with ChangeNotifier {

  final db = FirebaseFirestore.instance;
  late CollectionReference orderCollection;
  List<OrderModel> orderList = [];

  // OrderStateProvider() {
  //   orderCollection = db.collection('user_order_new');
  // }


  Future<void> getUserOrderList() async {
    orderList = await orderCollection.get().then((querySnapshot) {
      return querySnapshot.docs.map((document) {
        return OrderModel.getSnapshotData(document);
      }).toList();
    });

    notifyListeners();
  }

  Future<String> getUserName(int index) async {
    String userName = '';
    var userUid = orderList[index].userUid;

    await db.collection('user')
        .doc(userUid)
        .get()
        .then((value) =>
        userName = value['userName']
    );
    return userName;
  }


  // 주문 상태 업데이트
  Future<void> updateOrderState(int index, String orderId, String processState) async {

    if( processState == 'new' ) {

      await orderCollection.doc(orderId).update({
        'processState' : 'inProcess',
      });

    } else if( processState == 'inProcess' ) {

      OrderModel.setDataToCompletedOrder(orderId, orderList[index]);
      await orderCollection.doc(orderId).delete();
    }
  }

}