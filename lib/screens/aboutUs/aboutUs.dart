import 'package:flutter/material.dart';
import 'package:oasis_cafe_app_store/config/palette.dart';
import 'package:oasis_cafe_app_store/provider/aboutUsProvider.dart';
import 'package:oasis_cafe_app_store/screens/aboutUs/aboutUsEditPage.dart';
import 'package:provider/provider.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> dayList = ['월', '화', '수', '목', '금', '토', '일'];
    var aboutUsProvider = Provider.of<AboutUsProvider>(context);
    aboutUsProvider.getStoreInfo();

    var dayTextSize = const TextStyle(fontSize: 17.0);


    return Scaffold(
      appBar: AppBar(
        title: const Text('About us'),
        backgroundColor: Palette.backgroundColor1,
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '영업 시간',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                        const AboutUsEditPage())
                    );
                  },
                  child: const Text(
                    '수정하기',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 17.0
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 10,),

            for( var i = 0; i < dayList.length; i++ )
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${dayList[i]}요일',
                    style: dayTextSize,
                  ),

                  aboutUsProvider.dayList.isEmpty ?
                      const CircularProgressIndicator() :
                      Text(
                        aboutUsProvider.dayList[i],
                        style: dayTextSize,
                      )
                ],
              ),


            const Divider(height: 10, color: Colors.grey,),
          ],
        ),
      ),
    );
  }
}
