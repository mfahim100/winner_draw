import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../admin/main_admin/domain/entities/model_results.dart';

class ListTileResultsClient extends StatelessWidget {
  final ModelResults results;

  const ListTileResultsClient({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      width: 90.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    NeumorphicText(
                      results.prizeNo == 1
                          ? "1st"
                          : results.prizeNo == 2
                              ? "2nd"
                              : results.prizeNo == 3
                                  ? "3rd"
                                  : "1st",
                      textStyle: NeumorphicTextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                      style: const NeumorphicStyle(color: Colors.black),
                    ),
                    NeumorphicText(
                      " Prize:",
                      textStyle: NeumorphicTextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                      style: const NeumorphicStyle(color: Colors.black),
                    ),
                  ],
                ),

                NeumorphicText(
                  results.title!,
                  style: const NeumorphicStyle(color: Colors.black),
                  textStyle: NeumorphicTextStyle(
                      fontSize: 16.sp, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NeumorphicText(
                  results.name!,
                  textStyle: NeumorphicTextStyle(
                      fontSize: 18.sp, fontWeight: FontWeight.bold),
                  style: const NeumorphicStyle(color: Colors.black),
                ),
                NeumorphicText(
                  "${results.phone!.substring(0, 4)}xxx${results.phone!.substring(7)}",
                  style: const NeumorphicStyle(color: Colors.black),
                  textStyle: NeumorphicTextStyle(
                      fontSize: 16.sp, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
