import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oasis_cafe_app_store/config/palette.dart';
import 'package:oasis_cafe_app_store/provider/orderStateController.dart';
import 'package:oasis_cafe_app_store/screens/home/orderList.dart';
import 'package:oasis_cafe_app_store/strings/strings_en.dart';

import 'drawer.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final tabBarLength = 2;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabBarLength,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.backgroundColor1,
          elevation: 0.0,
          title: const Text(Strings.storeName),

          bottom: TabBar(
            indicator: const BoxDecoration(color: Colors.white),
            labelColor: Palette.textColor1,
            unselectedLabelColor: Colors.white,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold,),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),

            tabs: [
              Tab(text: '신규/처리중 ${Get.find<OrderStateController>().getNewOrderLength()}',),
              Tab(text: '완료 ${Get.find<OrderStateController>().getCompletedOrderLength()}',)
            ],
          ),
        ),

        drawer: const MyDrawer(),

        body: TabBarView(
          children: [
            for( var i = 0; i < tabBarLength; i++ )
              OrderList(currentTabIndex: i,)

          ],
        ),
      ),
    );
  }
}
