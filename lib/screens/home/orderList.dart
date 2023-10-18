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
              String itemId = documentSnapshot.id;
              print('itemId > ${itemId}');
            }
          );

        } else {
          return const Center(child: CircularProgressIndicator(),);
        }
      }
    );
  }
}
