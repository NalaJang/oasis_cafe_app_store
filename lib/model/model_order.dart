import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {

  late String id;
  late String userUid;
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
    userUid = data['userUid'];
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

  // 완료 처리된 주문 내역을 'user_order_completed' collection 에 저장
  OrderModel.setDataToCompletedOrder(String orderId, OrderModel data) {

    FirebaseFirestore.instance
        .collection('user_order_completed')
        .doc(orderId)
        .set(
        {
          'orderTime' : data.orderTime,
          'userUid' : data.userUid,
          'quantity' : data.quantity,
          'itemName' : data.itemName,
          'itemPrice' : data.itemPrice,
          'totalPrice' : data.totalPrice,
          'drinkSize' : data.drinkSize,
          'cup' : data.cup,
          'hotOrIced' : data.hotOrIced,
          'espressoOption' : data.espressoOption,
          'syrupOption' : data.syrupOption,
          'whippedCreamOption' : data.whippedCreamOption,
          'iceOption' : data.iceOption,
          'processState' : 'pickUp'
        });
  }
}