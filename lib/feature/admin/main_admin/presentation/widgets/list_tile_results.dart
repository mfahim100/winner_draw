import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../domain/entities/model_results.dart';

class ListTileResults extends StatelessWidget {
  final ModelResults results;
  final bool isClient;

  const ListTileResults(
      {super.key, required this.results, required this.isClient});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.sp),
      padding: EdgeInsets.all(10.sp),
      child: Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.all(Radius.circular(15.sp))),
          color: results.prizeNo == 1
              ? Colors.amber
              : results.prizeNo == 2
                  ? Colors.grey.shade500
                  : results.prizeNo == 3
                      ? const Color(0xffef9bcd)
                      : Colors.amber,
          // shadowLightColor: ConstColors.darkShadowLight,
          // shadowDarkColor: ConstColors.darkShadowDark,
          depth: 4,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
          width: 90.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                child: Column(
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
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                      style: const NeumorphicStyle(color: Colors.black54),
                    ),
                    NeumorphicText(
                      "Prize",
                      style: const NeumorphicStyle(color: Colors.black54),
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
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                      style: const NeumorphicStyle(color: Colors.black54),
                    ),
                    Container(
                      child: isClient
                          ? NeumorphicText(
                              "${results.phone!.substring(0, 4)}XXX${results.phone!.substring(7)}",
                              style:
                                  const NeumorphicStyle(color: Colors.black54),
                            )
                          : NeumorphicText(
                              results.phone!,
                              style:
                                  const NeumorphicStyle(color: Colors.black54),
                            ),
                    ),
                    NeumorphicText(
                      results.email!.length<=20?results.email!:"${results.email!.substring(0,20)}...",
                      style: const NeumorphicStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
