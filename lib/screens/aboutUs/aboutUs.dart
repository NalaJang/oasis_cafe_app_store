import 'package:flutter/material.dart';
import 'package:oasis_cafe_app_store/config/palette.dart';
import 'package:oasis_cafe_app_store/screens/aboutUs/aboutUsEditPage.dart';
import 'package:provider/provider.dart';

import '../../provider/openingHoursProvider.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> dayList = ['월', '화', '수', '목', '금', '토', '일'];
    var openingHoursProvider = Provider.of<OpeningHoursProvider>(context);
    openingHoursProvider.getOpeningHours();

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

                  openingHoursProvider.hoursList.isEmpty ?
                      const CircularProgressIndicator() :
                      openingHoursProvider.hoursList[i].openHour == '0' ?
                      Text(
                        '휴무',
                        style: dayTextSize,
                      ) :
                      Text(
                        '${openingHoursProvider.hoursList[i].openAmPm} ${openingHoursProvider.hoursList[i].openHour}:${openingHoursProvider.hoursList[i].openMinutes} ~ '
                            '${openingHoursProvider.hoursList[i].closeAmPm} ${openingHoursProvider.hoursList[i].closeHour}:${openingHoursProvider.hoursList[i].closeMinutes}',
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
