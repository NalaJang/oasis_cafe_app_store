import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:oasis_cafe_app_store/provider/orderStateProvider.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  const OrderList({required this.currentTabIndex, Key? key}) : super(key: key);

  final int currentTabIndex;

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {

  String buttonText = '주문 접수';

  @override
  Widget build(BuildContext context) {

    final db = FirebaseFirestore.instance;
    var orderStateProvider = Provider.of<OrderStateProvider>(context);
    String collectionName = 'user_order_new';
    double getWidth = Get.width;

    String setCollectionName() {
      if( widget.currentTabIndex == 0 ) {
        collectionName = 'user_order_new';
      } else if( widget.currentTabIndex == 1 ) {
        collectionName = 'user_order_completed';
      }
      return collectionName;
    }

    CollectionReference collectionReference = db.collection(setCollectionName());
    orderStateProvider.orderCollection = db.collection(setCollectionName());
    orderStateProvider.getUserOrderList();

    return StreamBuilder(
      stream: collectionReference.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if( streamSnapshot.hasData ) {
          return ListView.separated(
            separatorBuilder: (BuildContext context, int index) => const Divider(
            color: Colors.grey,
            ),

            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
              String orderId = documentSnapshot.id;
              int quantity = documentSnapshot['quantity'];
              String itemName = documentSnapshot['itemName'];
              String orderTime = documentSnapshot['orderTime'];
              String processState = documentSnapshot['processState'];

              // orderTime = yyyy-MM-dd H:m:s
              List<String> split_orderTime = orderTime.split(' ');
              List<String> split_time = split_orderTime[1].split(':');
              String time = '${split_time[0]}:${split_time[1]}';


              if( processState == 'new' ) {
                buttonText = '주문\n접수';
              } else {
                buttonText = '처리중';
              }

              return ListTile(
                leading: Text(time,),
                title: Text('$itemName $quantity개'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: (){},
                      child: const Text(
                        '주문표\n인쇄',
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // 주문 상태 업데이트
                    ElevatedButton(
                      onPressed: (){
                        orderStateProvider.updateOrderState(index, orderId, processState);
                      },
                      child: Text(processState),
                    ),
                  ],
                ),

                // 주문 정보 다이얼로그
                onTap: (){
                  _showOrderDetailDialog(context, index);
                },
              );
            }
          );

        } else {
          return const Center(child: CircularProgressIndicator(),);
        }
      }
    );
  }

  // 주문 정보 보기 다이얼로그
  Future<void> _showOrderDetailDialog(BuildContext context, int index) async {
    var orderStateProvider = Provider.of<OrderStateProvider>(context, listen: false);
    var customerName = await orderStateProvider.getUserName(index);
    var orderedItem = orderStateProvider.orderList[index];

    if( mounted ) {
      return showDialog<void> (
        context: context,
        builder: (context) {
          return AlertDialog (
            title: const Text('주문 정보'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('주문자'),
                    Text(customerName,),
                  ],
                ),

                const SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('접수 시간'),
                    Text(orderedItem.orderTime),
                  ],
                ),

                const SizedBox(height: 15,),

                const Text('주문 내역'),

                const SizedBox(height: 10,),

                Text('${orderedItem.quantity} ${orderedItem.hotOrIced} ${orderedItem.itemName}'),
                Text('${orderedItem.espressoOption} shots'),
                Text(orderedItem.drinkSize),
                orderedItem.syrupOption.isEmpty ? const Visibility(visible: false,child: Text(''),) : Text(orderedItem.syrupOption),
                orderedItem.iceOption.isEmpty ? const Visibility(visible: false, child: Text('')) : Text(orderedItem.iceOption),
                orderedItem.whippedCreamOption.isEmpty ? const Visibility(visible: false,child: Text('',),) : Text('${orderedItem.whippedCreamOption}'),
                Text(orderedItem.cup),
              ],
            ),
          );
        }
      );
    }
  }
}
