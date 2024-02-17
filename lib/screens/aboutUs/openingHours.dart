import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oasis_cafe_app_store/config/commonButton.dart';
import 'package:provider/provider.dart';

import '../../provider/openingHoursController.dart';
import 'editPages/openingHoursEditPage.dart';

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
            CommonButton().editButton(context, OpeningHoursEditPage.routeName),
          ],
        ),

        const SizedBox(height: 10,),

        // 서버에서 영업 시간 가져오기
        for( var i = 0; i < dayList.length; i++ )
          Obx(() {
            return _getOpeningHoursInfo(context, dayList[i], i);
          })
      ],
    );
  }

  Widget _title() {
    return Row(
      children: const [
        Icon(CupertinoIcons.clock),

        Text(
          ' 영업 시간',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }


  // 영업 시간 정보
  Widget _getOpeningHoursInfo(BuildContext context, String day, int index) {
    var dayTextSize = const TextStyle(fontSize: 17.0);

    /*
     var openingHoursProvider = Provider.of<OpeningHoursProvider>(context, listen: false);
     (에러) RangeError (index): Invalid value: Valid value range is empty: 0
     : 페이지를 나갔다 다시 들어오면 정상 작동하였다. 분명 이 전에는 잘 작동했고 메소드로 코드를 분리하는 바람에 생긴 문제일까 고민했는데
     원인은 Provider 의 'listen: false' 파라미터 때문이었다.

     => (제거) listen: false
     기본적으로 'notifyListeners()' 함수가 호출되면 UI 를 업데이트하지만 리소스를 절약하기 위해서 업데이트를 수행하지 않도록
     할 수 있는데 이 옵션이 'listen: false' 이다.
     내가 해당 속성을 false 로 설정해 놓는 바람에 'getOpeningHours()' 함수에서 hoursList 에 데이터를 담았음에도 불구하고
     바로 데이터가 업데이트 안되었던 것으로 보인다.
    */
    var openingHoursProvider = Get.find<OpeningHoursController>();
    openingHoursProvider.getOpeningHours();

    if( openingHoursProvider.openingHoursList.isEmpty ) {
      return const CircularProgressIndicator();
    }

    String openAmPm = openingHoursProvider.openingHoursList[index].openAmPm;
    String openHour = openingHoursProvider.openingHoursList[index].openHour;
    String openMinutes = openingHoursProvider.openingHoursList[index].openMinutes;
    String closeAmPm = openingHoursProvider.openingHoursList[index].closeAmPm;
    String closeHour = openingHoursProvider.openingHoursList[index].closeHour;
    String closeMinutes = openingHoursProvider.openingHoursList[index].closeMinutes;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$day요일',
          style: dayTextSize,
        ),

        openingHoursProvider.openingHoursList[index].openHour == '00' ?
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
