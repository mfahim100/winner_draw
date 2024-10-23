import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../core/constants/const_colors.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../../core/widgets/default_button.dart';
import '../manager/main_nav_admin_controller.dart';

class DialogCalender extends StatefulWidget {
  const DialogCalender({Key? key}) : super(key: key);

  @override
  State<DialogCalender> createState() => _DialogCalenderState();
}

class _DialogCalenderState extends State<DialogCalender> {
  late DateRangePickerController _controller;
  DateTime time = DateTime.now();
  final mainController = sl<MainNavAdminController>();

  @override
  void initState() {
    // TODO: implement initState
    _controller = DateRangePickerController();
    super.initState();
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    print(args.value.toString());

    DateTime? date1 = DateTime.now();
    try {
      PickerDateRange ranges = args.value;
      date1 = ranges.startDate;
    } catch (e) {
      date1 = args.value;
    }

    print(date1.toString());
    _controller.selectedRange = PickerDateRange(date1, date1);
    time = date1 ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ConstColors.white,
      insetPadding: EdgeInsets.all(2.w),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.w)), //this right here
      child: Container(
        padding: EdgeInsets.all(10.sp),
        height: 45.h,
        width: 40.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SfDateRangePicker(
              controller: _controller,
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.single,
              onSelectionChanged: onSelectionChanged,
              monthViewSettings: const DateRangePickerMonthViewSettings(
                  enableSwipeSelection: false),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DefaultButton(
                  isFixed: true,
                  text: 'Ok',
                  onPressed: () {
                    mainController.changeTimer(time,context);

                  },
                ),
                DefaultButton(
                  isFixed: true,
                  text: 'Cancel',
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
