import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/openingHoursProvider.dart';
import 'openingHoursEditPage.dart';

class OpeningHours extends StatelessWidget {
  const OpeningHours({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> dayList = ['월', '화', '수', '목', '금', '토', '일'];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            _title(),

            // 수정하기 버튼
            _editButton(context),
          ],
        ),

        const SizedBox(height: 10,),

        // 서버에서 영업 시간 가져오기
        for( var i = 0; i < dayList.length; i++ )
          _getOpeningHoursInfo(context, dayList[i], i)
      ],
    );
  }

  Widget _title() {
    return const Text(
      '영업 시간',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),
    );
  }

  // 수정하기 버튼
  Widget _editButton(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,
          MaterialPageRoute(builder: (context) =>
          const OpeningHoursEditPage())
        );
      },
      child: const Text(
        '수정하기',
        style: TextStyle(
          color: Colors.blue,
          fontSize: 17.0
        ),
      ),
    );
  }

  // 영업 시간 정보
  Widget _getOpeningHoursInfo(BuildContext context, String day, int index) {
    var dayTextSize = const TextStyle(fontSize: 17.0);
    var openingHoursProvider = Provider.of<OpeningHoursProvider>(context, listen: false);
    openingHoursProvider.getOpeningHours();

    String openAmPm = openingHoursProvider.hoursList[index].openAmPm;
    String openHour = openingHoursProvider.hoursList[index].openHour;
    String openMinutes = openingHoursProvider.hoursList[index].openMinutes;
    String closeAmPm = openingHoursProvider.hoursList[index].closeAmPm;
    String closeHour = openingHoursProvider.hoursList[index].closeHour;
    String closeMinutes = openingHoursProvider.hoursList[index].closeMinutes;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$day요일',
          style: dayTextSize,
        ),

        openingHoursProvider.hoursList.isEmpty ?
        const CircularProgressIndicator() :
        openingHoursProvider.hoursList[index].openHour == '0' ?
        Text(
          '휴무',
          style: dayTextSize,
        ) :
        Text(
          '$openAmPm $openHour:$openMinutes ~ $closeAmPm $closeHour:$closeMinutes',
          style: dayTextSize,
        )
      ],
    );
  }
}
