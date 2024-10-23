
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/const_colors.dart';
import '../../../../../core/constants/const_neus.dart';
import '../../../../../core/utils/injections.dart';

import '../manager/main_nav_admin_controller.dart';
import 'list_tile_results.dart';

class ResultsDialogBox extends StatelessWidget {
  final int index;
  final String date ;

  ResultsDialogBox({super.key, required this.index, required this.date});
  final mainController = sl<MainNavAdminController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(2.w),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.w)), //this right here
      child: Container(
        decoration: BoxDecoration(
            // color: ConstColors.kBGColor,
            color: ConstColors.white,
            borderRadius: BorderRadius.circular(5.w)),
        width: 80.w,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: NeumorphicButton(
                  onPressed: () => Navigator.pop(context),
                  style: ConstNeus.appBarCirclesDark,
                  padding: EdgeInsets.all(10.sp),
                  child: Icon(
                    Icons.clear,
                    color: ConstColors.white,
                    size: 20.sp,
                  ),
                ),
              ),
              SizedBox(height: 3.h,),
              NeumorphicText(
                "Draw Winner Details",
                textStyle: NeumorphicTextStyle(
                    fontSize: 20.sp, fontWeight: FontWeight.bold),
                style: const NeumorphicStyle(color: Colors.black54),
              ),

              NeumorphicText(
                date,
                style: const NeumorphicStyle(color: Colors.black54),
              ),
              SizedBox(height: 3.h,),
              SizedBox(
                height: 40.h,
                child: ListView.builder(

                  itemCount: mainController.resultList[index].length,
                  itemBuilder: (context, i) => ListTileResults(results: mainController.resultList[index][i], isClient: false,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
