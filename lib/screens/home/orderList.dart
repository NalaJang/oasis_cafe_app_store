import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app_store/provider/orderStateProvider.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {

  String buttonText = '주문 접수';

  @override
  Widget build(BuildContext context) {

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
              int quantity = documentSnapshot['quantity'];
              String itemName = documentSnapshot['itemName'];
              String orderTime = documentSnapshot['orderTime'];
              String processState = documentSnapshot['processState'];

              // orderTime = yyyy-MM-dd H:m:s
              List<String> split_orderTime = orderTime.split(' ');
              List<String> split_time = split_orderTime[1].split(':');
              String time = '${split_time[0]}:${split_time[1]}';


              if( processState == 'new' ) {
                buttonText = '주문 접수';
              }

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 주문 시간
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                    // 주문 아이템 및 개수
                    Text('$itemName $quantity개'),

                    Row(
                      children: [
                        // 주문표 인쇄
                        ElevatedButton(
                          onPressed: (){},
                          child: const Text(
                            '주문표 \n인쇄',
                            textAlign: TextAlign.center,
                          )
                        ),

                        const SizedBox(width: 10,),

                        // 주문 접수 또는 처리 중
                        ElevatedButton(
                          onPressed: (){},
                          child: Text(
                            buttonText
                          )
                        )
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
