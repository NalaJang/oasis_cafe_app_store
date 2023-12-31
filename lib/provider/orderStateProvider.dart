import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:oasis_cafe_app_store/strings/strings_en.dart';

import '../model/model_order.dart';
import '../screens/home/home.dart';

class OrderStateProvider with ChangeNotifier {

  final db = FirebaseFirestore.instance;
  late CollectionReference orderCollection;
  List<OrderModel> orderList = [];
  var newOrderLength = 0;
  var completedOrderLength = 0;

  // OrderStateProvider() {
  //   orderCollection = db.collection('user_order_new');
  // }


  Future<void> getUserOrderList() async {
    orderList = await orderCollection
                .orderBy('orderTime', descending: true)
                .get().then((querySnapshot) {
                  return querySnapshot.docs.map((document) {
                    return OrderModel.getSnapshotData(document);
                  }).toList();
    });

    notifyListeners();
  }


  // 신규/처리중 메뉴 항목 리스트 개수 가져오기
  int getNewOrderLength() {

    db.collection(Strings.collection_userOrderNew).get().then((value) {
      newOrderLength = value.size;
    });
    return newOrderLength;
  }

  // 완료 메뉴 항목 리스트 개수 가져오기
  int getCompletedOrderLength() {

    db.collection(Strings.collection_userOrderCompleted).get().then((value) {
      completedOrderLength = value.size;
    });
    return completedOrderLength;
  }


  Future<String> getUserName(int index) async {
    String userName = '';
    var userUid = orderList[index].userUid;

    await db.collection(Strings.collection_user)
        .doc(userUid)
        .get()
        .then((value) =>
        userName = value['userName']
    );
    return userName;
  }


  // 새 주문 상태 업데이트
  Future<void> updateNewOrderState(String orderId, String userUid, String orderUid) async {

    // '주문 접수(new)' 클릭 시 '처리중(inProcess)' 로 상태 업데이트
    await orderCollection.doc(orderId).update({
      'processState' : Strings.orderInProcess,
    });


    // 고객 데이터베이스에서도 업데이트
    await db.collection('user')
        .doc(userUid)
        .collection('user_order')
        .doc(orderUid)
        .update({
      'processState' : Strings.orderInProcess,
    });
  }

  // 취소 처리된 주문 상태 업데이트
  Future<void> updateOrderCanceled(int index, String orderId, String userUid, String orderUid, String reason) async {

    // 취소된 사유와 함께 '주문 취소(canceled)' 로 상태 업데이트
    OrderModel.setDataToCompletedOrder(true, reason, orderId, orderUid, orderList[index]);
    await orderCollection.doc(orderId).delete();

    // 고객 데이터베이스에서도 업데이트
    await db.collection('user')
        .doc(userUid)
        .collection('user_order')
        .doc(orderUid)
        .update({
      'processState' : Strings.orderCanceled,
      'reasonOfCanceled' : reason
    });
  }

  // 처리중인 주문 상태 업데이트
  Future<void> updateOrderInProcessState(String orderId, String userUid, String orderUid) async {

    // '처리중(inProcess)' 클릭 시 '완료(done)' 로 상태 업데이트
    await orderCollection.doc(orderId).update({
      'processState' : Strings.orderDone,
    });


    // 고객 데이터베이스에서도 업데이트
    await db.collection('user')
        .doc(userUid)
        .collection('user_order')
        .doc(orderUid)
        .update({
      'processState' : Strings.orderDone,
    });
  }

  // 완료 상태 업데이트
  Future<void> updateOrderDoneState(int index, String orderId, String userUid, String orderUid) async {

    // '완료' 클릭 시 신규/처리중 메뉴 항목에서 삭제, 해당 항목을 완료 항목으로 업데이트
    OrderModel.setDataToCompletedOrder(false, '', orderId, orderUid, orderList[index]);
    await orderCollection.doc(orderId).delete();

    // 고객 데이터베이스에서도 업데이트
    await db.collection('user')
        .doc(userUid)
        .collection('user_order')
        .doc(orderUid)
        .update({
      'processState' : Strings.orderPickedUp,
    });
  }
}