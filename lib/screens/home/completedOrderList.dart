import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:oasis_cafe_app_store/provider/orderStateProvider.dart';
import 'package:provider/provider.dart';

class CompletedOrderList extends StatefulWidget {
  const CompletedOrderList({Key? key}) : super(key: key);

  @override
  State<CompletedOrderList> createState() => _CompletedOrderListState();
}

class _CompletedOrderListState extends State<CompletedOrderList> {

  String buttonText = '주문 접수';

  @override
  Widget build(BuildContext context) {

    double getWidth = Get.width;

    var orderStateProvider = Provider.of<OrderStateProvider>(context);

    return StreamBuilder(
      stream: orderStateProvider.orderCollection.snapshots(),
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

              return Padding(
                padding: const EdgeInsets.only(left: 5, right: 0, top: 10, bottom: 10),
                child: Row(
                  children: [
                    // 주문 시간
                    SizedBox(
                      width: getWidth * 0.2,
                      child: Text(
                        time,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                    // 주문 아이템 및 개수
                    SizedBox(
                      width: getWidth * 0.4,
                      child: Text(
                        '$itemName $quantity개',
                        textAlign: TextAlign.center,
                      )
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // 주문표 인쇄
                        ElevatedButton(
                          onPressed: (){},
                          child: const Text(
                            '주문표\n인쇄',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15
                            ),
                          )
                        ),

                        const SizedBox(width: 10,),

                        // 주문 접수 또는 처리 중
                        ElevatedButton(
                          onPressed: (){
                            String updateState = 'new';
                            if( processState == 'new' ) {
                              updateState = 'inProcess';
                              setState(() {
                                buttonText = '처리중';
                              });
                            } else if(processState == 'inProcess'){
                              updateState = 'new';
                              setState(() {
                                buttonText = '주문\n접수';
                              });
                            }
                            orderStateProvider.updateOrderState(orderId, updateState);
                          },
                          child: Text(
                            buttonText
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          );

        } else {
          return const Center(child: CircularProgressIndicator(),);
        }
      }
    );
  }
}
