import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:oasis_cafe_app_store/provider/orderStateProvider.dart';
import 'package:provider/provider.dart';

import '../../strings/strings_en.dart';

class OrderList extends StatefulWidget {
  const OrderList({required this.currentTabIndex, Key? key}) : super(key: key);

  final int currentTabIndex;

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {

  String buttonText = '주문 접수';
  bool processingConfirm = false;

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
      // orderTime 내림차순으로 데이터 정렬
      stream: collectionReference.orderBy('orderTime', descending: true).snapshots(),
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
              String date = split_orderTime[0];
              String time = split_orderTime[1];


              if( processState == 'new' ) {
                buttonText = '주문\n접수';
              } else {
                buttonText = '처리중';
              }

              return ListTile(
                leading: Text('$date\n$time', textAlign: TextAlign.center,),
                title: Text('$itemName $quantity개'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                              color: Colors.white
                          )
                      ),
                      onPressed: (){},
                      child: const Text(
                        '주문표\n인쇄',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black
                        ),
                      ),
                    ),

                    const SizedBox(width: 5,),

                    // 주문 상태 업데이트
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: processState == Strings.newOrder ? Colors.brown : Colors.white,
                        side: const BorderSide(
                          color: Colors.brown,
                        )
                      ),
                      onPressed: () async {
                        // '주문 접수(new)' 클릭 시
                        if( processState == Strings.newOrder ) {
                          orderStateProvider.updateNewOrderState(orderId);

                        // '처리중(inProcess)' 클릭 시
                        } else if( processState == Strings.orderInProcess ) {
                          var result = await showProcessingStateDialog();

                          setState(() {
                            if( result )  {
                              orderStateProvider.updateOrderInProcessState(index, orderId);
                            }
                          });
                        }
                      },
                      child: Text(
                        processState,
                        style: TextStyle(
                          color: processState == Strings.newOrder ? Colors.white : Colors.brown,
                          fontWeight: FontWeight.bold
                        ),
                      ),
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

  // 주문 처리 상태 다이얼로그
  Future<bool> showProcessingStateDialog() async {
    // return
      await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('처리중'),
          content: Text('완료 처리를 하시겠습니까?'),
          actions: [
            // 취소
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(
                  color: Colors.brown
                )
              ),
              onPressed: (){
                processingConfirm = false;
                Navigator.pop(context);
              },
              child: const Text(
                Strings.cancel,
                style: TextStyle(
                  color: Colors.brown
                ),
              )
            ),

            // 확인
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  side: const BorderSide(
                      color: Colors.brown
                  )
              ),
              onPressed: (){
                processingConfirm = true;
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        '완료 처리되었습니다.',
                      ),
                    )
                );
                Navigator.pop(context);
              },
              child: const Text(Strings.submit)
            )
          ],
        );
      }
    );
      return processingConfirm;
  }
}
