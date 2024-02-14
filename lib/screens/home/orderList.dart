import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:oasis_cafe_app_store/config/circularProgressIndicator.dart';
import 'package:oasis_cafe_app_store/config/gaps.dart';
import 'package:oasis_cafe_app_store/provider/orderStateController.dart';

import '../../config/commonButton.dart';
import '../../strings/strings_en.dart';

class OrderList extends StatefulWidget {
  const OrderList({required this.currentTabIndex, Key? key}) : super(key: key);

  final int currentTabIndex;

  @override
  State<OrderList> createState() => _OrderListState();
}

// 주문 취소 사유
enum ReasonOfOrderCancellation {cafeCircumstances, soldOut, notAllowed}

class _OrderListState extends State<OrderList> {

  bool processingConfirm = false;
  // 취소 사유 라디오 버튼 초기화 값
  ReasonOfOrderCancellation _reason = ReasonOfOrderCancellation.cafeCircumstances;
  String clickedCollectionName = Strings.collection_userOrderNew;

  @override
  void initState() {
    super.initState();

    String setCollectionName() {
      if( widget.currentTabIndex == 0 ) {
        clickedCollectionName = Strings.collection_userOrderNew;
      } else if( widget.currentTabIndex == 1 ) {
        clickedCollectionName = Strings.collection_userOrderCompleted;
      }
      return clickedCollectionName;
    }

    final db = FirebaseFirestore.instance;
    var orderStateController = Get.find<OrderStateController>();
    orderStateController.orderCollection = db.collection(setCollectionName());
  }

  @override
  Widget build(BuildContext context) {

    var orderStateController = Get.find<OrderStateController>();

    return StreamBuilder(
      // orderTime 내림차순으로 데이터 정렬
      stream: orderStateController.orderCollection.orderBy('orderTime', descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if( streamSnapshot.hasData ) {
          return _buildOrderListView(streamSnapshot);

        } else {
          return CircularProgressBar.circularProgressBar;
        }
      }
    );
  }


  Widget _buildOrderListView(AsyncSnapshot<QuerySnapshot> streamSnapshot) {
    var orderStateController = Get.find<OrderStateController>();

    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Colors.grey,
      ),

      itemCount: streamSnapshot.data!.docs.length,
      itemBuilder: (context, index) {
        final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
        orderStateController.getUserOrderList();
        String orderId = documentSnapshot.id;
        String userUid = documentSnapshot['userUid'];
        String orderUid = documentSnapshot['orderUid'];
        int quantity = documentSnapshot['quantity'];
        String itemName = documentSnapshot['itemName'];
        String orderTime = documentSnapshot['orderTime'];
        String processState = documentSnapshot['processState'];

        // orderTime = yyyy-MM-dd H:m:s
        List<String> split_orderTime = orderTime.split(' ');
        String date = split_orderTime[0];
        String time = split_orderTime[1];


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

              Gaps.gapW5,

              // 주문 상태 업데이트
              _orderStateUpdate(processState, index, orderId, userUid, orderUid),
            ],
          ),

          // 주문 정보 다이얼로그
          onTap: (){
            _showOrderDetailDialog(context, index, processState);
          },
        );
      }
    );
  }

  // 주문 상태 업데이트
  Widget _orderStateUpdate(String processState, int index, String orderId, String userUid, String orderUid) {
    var orderStateController = Get.find<OrderStateController>();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: processState == Strings.newOrder ? Colors.brown : Colors.white,
          side: const BorderSide(
            color: Colors.brown,
          )
      ),
      onPressed: () async {
        // '주문 접수(new)' 클릭 시
        if( processState == Strings.newOrder ) {
          orderStateController.updateNewOrderState(orderId, userUid, orderUid);

          // '처리중(inProcess)' 클릭 -> '완료' 로 상태 업데이트
        } else if( processState == Strings.orderInProcess ) {
          var result = await showProcessingStateDialog('완료');

          setState(() {
            if( result )  {
              orderStateController.updateOrderInProcessState(orderId, userUid, orderUid);
            }
          });

          // '완료(done)' 클릭 -> 'pickUp' 으로 상태 업데이트
        } else if( processState == Strings.orderDone ) {
          var result = await showProcessingStateDialog('픽업');

          setState(() {
            if( result )  {
              orderStateController.updateOrderDoneState(index, orderId, userUid, orderUid);
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
    );
  }

  // 주문 정보 보기 다이얼로그
  Future<void> _showOrderDetailDialog(BuildContext context, int index, String processState) async {
    var orderStateController = Get.find<OrderStateController>();
    var customerName = await orderStateController.getUserName(index);
    var orderedItem = orderStateController.orderList[index];
    print('주문 정보 index > $index');
    print('주문 정보 orderedItem > ${orderedItem.id}');

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

                Gaps.gapH15,

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('접수 시간'),
                    Text(orderedItem.orderTime),
                  ],
                ),

                Gaps.gapH15,

                const Text('주문 내역'),

                Gaps.gapH10,

                Text('${orderedItem.quantity} ${orderedItem.hotOrIced} ${orderedItem.itemName}'),
                Text('${orderedItem.espressoOption} shots'),
                Text(orderedItem.drinkSize),
                orderedItem.syrupOption.isEmpty ? const Visibility(visible: false,child: Text(''),) : Text(orderedItem.syrupOption),
                orderedItem.iceOption.isEmpty ? const Visibility(visible: false, child: Text('')) : Text(orderedItem.iceOption),
                orderedItem.whippedCreamOption.isEmpty ? const Visibility(visible: false,child: Text('',),) : Text('${orderedItem.whippedCreamOption}'),
                Text(orderedItem.cup),

                Gaps.spacer,
                // 주문 취소 버튼(새 주문일 경우에만 취소 버튼 보임)
                processState == Strings.newOrder ?
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xFF878787),
                      side: const BorderSide(
                        color: Color(0xFF878787)
                      )
                    ),

                    onPressed: () async {
                      var isCanceled = await showTheDialog();
                      if( isCanceled ) {
                        Get.back;
                        orderStateController.updateOrderCanceled(
                            index, orderedItem.id, orderedItem.userUid, orderedItem.orderUid, _reason.toString()
                        );
                      }

                    },
                    child: const Text(
                      '주문 취소',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ),
                ) : Gaps.spacer
              ],
            ),
          );
        }
      );
    }
  }

  final List<String> reasonOfCancellationList = ['업소 사정 취소', '재료 소진', '요청사항 불가'];
  // AlertDialog 에서는 setState() 가 작동을 하지 않았다.
  // setState() 는 StatefulBuilder 에서만 사용이 가능하다고 해서
  // AlertDialog 를 StatefulBuilder widget 으로 감싸주었다.
  showTheDialog() {
    return Get.dialog(
      StatefulBuilder(
        builder: (context, StateSetter setState) {
          return AlertDialog(
            title: const Text(Strings.orderCancel),
            content: Column(
              children: [
                for( var i = 0; i < reasonOfCancellationList.length; i++ )
                  RadioListTile(
                    title: Text(reasonOfCancellationList[i]),
                    value: ReasonOfOrderCancellation.values[i],
                    groupValue: _reason,
                    onChanged: (ReasonOfOrderCancellation? value) {
                      setState(() {
                        _reason = value!;
                      });
                    },
                  ),
              ],
            ),

            actions: [
              // 취소 버튼
              CommonButton.cancelButton(),

              // 주문 취소 확인 버튼
              CommonButton.submitButton(Strings.orderCancel),
            ],
          );
        }
      )
    );
  }

  // 주문 처리 상태 다이얼로그
  Future<bool> showProcessingStateDialog(String nextProcess) async {
    processingConfirm = false;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('처리중'),
          content: Text('$nextProcess 처리를 하시겠습니까?'),
          actions: [
            // 취소
            cancelButton(),

            // 확인
            submitButton(nextProcess)
          ],
        );
      }
    );
    return processingConfirm;
  }

  // 취소 버튼
  ElevatedButton cancelButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            side: const BorderSide(
                color: Colors.brown
            )
        ),
        onPressed: (){
          // processingConfirm = false;
          Navigator.pop(context);
        },
        child: const Text(
          Strings.cancel,
          style: TextStyle(
              color: Colors.brown
          ),
        )
    );
  }

  // 제출 버튼
  ElevatedButton submitButton(String content) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown,
            side: const BorderSide(
                color: Colors.brown
            )
        ),
        onPressed: (){
          if( content == '완료' || content == '픽업' || content == '주문 취소' ) {
            processingConfirm = true;
          }
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '$content 처리되었습니다.',
                ),
              )
          );
          Navigator.pop(context);
        },
        child: const Text(Strings.submit)
    );
  }

}
