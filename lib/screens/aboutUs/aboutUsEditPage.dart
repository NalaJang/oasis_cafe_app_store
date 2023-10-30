import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oasis_cafe_app_store/config/palette.dart';
import 'package:oasis_cafe_app_store/model/model_openingHours.dart';

class AboutUsEditPage extends StatefulWidget {
  const AboutUsEditPage({Key? key}) : super(key: key);

  @override
  State<AboutUsEditPage> createState() => _AboutUsEditPageState();
}

class _AboutUsEditPageState extends State<AboutUsEditPage> {

  var openingHoursModel = OpeningHoursModel();

  @override
  void dispose() {
    super.dispose();

    // mondayOpenHour.dispose();
    // mondayOpenMinutes.dispose();
    // mondayCloseHour.dispose();
    // mondayCloseMinutes.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor1,
        title: const Text('운영시간 수정'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              for( var i = 0; i < openingHoursModel.dayList.length; i++ )
              Row(
                children: [
                  Text(
                    '${openingHoursModel.dayList[i]}요일',
                    style: const TextStyle(
                      fontSize: 17.0
                    ),
                  ),

                  const SizedBox(width: 10,),
                  const Text('오전'),
                  const Text('오전'),

                  Expanded(
                    child: TextFormField(
                      controller: openingHoursModel.openHours[i],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 2,
                      decoration: const InputDecoration(
                        counterText: ''
                      ),
                    ),
                  ),

                  const Text(':'),

                  Expanded(
                    child: TextFormField(
                      controller: openingHoursModel.openMinutes[i],
                      textAlign: TextAlign.center,
                      // maxLength: 2,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 2,
                      decoration: const InputDecoration(
                          counterText: ''
                      ),
                    ),
                  ),

                  const SizedBox(width: 10,),
                  const Text('~'),
                  const SizedBox(width: 10,),

                  const Text('오후'),
                  const Text('오후'),

                  Expanded(
                    child: TextFormField(
                      controller: openingHoursModel.closeHours[i],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 2,
                      decoration: const InputDecoration(
                          counterText: ''
                      ),
                    ),
                  ),

                  const Text(':'),

                  Expanded(
                    child: TextFormField(
                      controller: openingHoursModel.closeMinutes[i],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 2,
                      decoration: const InputDecoration(
                          counterText: ''
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _showTimePicker(Widget chile) {
  //   showCupertinoModalPopup(
  //     context: context,
  //     builder: (BuildContext context) => Container(
  //       height: 200,
  //       child: SafeArea(
  //         top: false,
  //         child: chile,
  //       ),
  //     )
  //   );
  // }
}
