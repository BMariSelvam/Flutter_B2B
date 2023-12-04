import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'colors.dart';
import 'fonts.dart';

class AddButton extends StatefulWidget {
  const AddButton({Key? key}) : super(key: key);

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  int counter = 0;

  TextEditingController counterController = TextEditingController();

  void increment() {
    setState(() {
      counter++;
      counterController.text = counter.toString();
    });
  }

  //Decrement
  void decrement() {
    setState(() {
      if (counter > 0) {
        counter--;
        counterController.text = counter.toString();
      }
    });
  }

  void addCounter() {
    setState(() {
      counter++;
      counterController.text = counter.toString();
    });
  }

  void updateCountFromTextField() {
    setState(() {
      counter = int.tryParse(counterController.text) ?? 0;
    });
  }

  @override
  void dispose() {
    counterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      width: 100,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              decrement();
            },
            child: Container(
              decoration: BoxDecoration(
                color: MyColors.mainTheme,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Icon(
                Icons.remove,
                color: MyColors.white,
              ),
            ),
          ),
          Flexible(
              child: SizedBox(
                  width: 50,
                  child: TextField(
                    controller: counterController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 15)),
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                    ),
                    textAlign: TextAlign.center,
                    onChanged: (_) => updateCountFromTextField(),
                  ))),
          GestureDetector(
            onTap: () {
              increment();
            },
            child: Container(
              decoration: BoxDecoration(
                color: MyColors.mainTheme,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Icon(Icons.add, color: MyColors.white),
            ),
          )
        ],
      ),
    );
    // (counter == 0)
    //   ? SizedBox(
    //       height: 25,
    //       width: 80,
    //       child: ElevatedButton(
    //         style: ElevatedButton.styleFrom(
    //             backgroundColor: MyColors.white,
    //             side: const BorderSide(color: MyColors.mainTheme)),
    //         onPressed: addCounter,
    //         child: const Text(
    //           'Add',
    //           style: TextStyle(color: MyColors.mainTheme),
    //         ),
    //       ),
    //     )
    //   : SizedBox(
    //       height: 25,
    //       width: 100,
    //       child: Row(
    //         children: [
    //           GestureDetector(
    //             onTap: () {
    //               decrement();
    //             },
    //             child: Container(
    //               decoration: BoxDecoration(
    //                 color: MyColors.mainTheme,
    //                 borderRadius: BorderRadius.circular(5.0),
    //               ),
    //               child: const Icon(
    //                 Icons.remove,
    //                 color: MyColors.white,
    //               ),
    //             ),
    //           ),
    //           Flexible(
    //               child: SizedBox(
    //                   width: 50,
    //                   child: TextField(
    //                     controller: counterController,
    //                     keyboardType: TextInputType.number,
    //                     decoration: const InputDecoration(
    //                         contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 15)),
    //                     style: TextStyle(
    //                       fontFamily: MyFont.myFont,
    //                     ),
    //                     textAlign: TextAlign.center,
    //                     onChanged: (_) => updateCountFromTextField(),
    //                   ))),
    //           GestureDetector(
    //             onTap: () {
    //               increment();
    //             },
    //             child: Container(
    //               decoration: BoxDecoration(
    //                 color: MyColors.mainTheme,
    //                 borderRadius: BorderRadius.circular(5.0),
    //               ),
    //               child: const Icon(Icons.add, color: MyColors.white),
    //             ),
    //           )
    //         ],
    //       ),
    //     );
  }
}
