import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'const_colors.dart';

class ConstNeus {
  static NeumorphicStyle appBarCirclesLight = NeumorphicStyle(
    shape: NeumorphicShape.convex,
    boxShape: const NeumorphicBoxShape.circle(),
    color: ConstColors.colorBackgroundLight,
    shadowLightColor: ConstColors.lightShadowLight,
    shadowDarkColor: ConstColors.lightShadowDark,
  );
  static NeumorphicStyle appBarCirclesDark = NeumorphicStyle(
    shape: NeumorphicShape.convex,
    boxShape: const NeumorphicBoxShape.circle(),
    color: ConstColors.colorBackgroundDark,
    shadowLightColor: ConstColors.darkShadowLight,
    shadowDarkColor: ConstColors.darkShadowDark,
  );

  static NeumorphicStyle settingsTestingWidgetLight = NeumorphicStyle(
    color: ConstColors.colorBackgroundLight,
    shadowLightColor: ConstColors.lightShadowLight,
    shadowDarkColor: ConstColors.lightShadowDark,
    boxShape: NeumorphicBoxShape.roundRect(
      const BorderRadius.all(Radius.circular(24)),
    ),
    depth: -3,
  );
  static NeumorphicStyle settingsTestingWidgetDark = NeumorphicStyle(
    color: ConstColors.colorBackgroundDark,
    shadowLightColor: ConstColors.darkShadowLight,
    shadowDarkColor: ConstColors.darkShadowDark,
    boxShape: NeumorphicBoxShape.roundRect(
      const BorderRadius.all(Radius.circular(24)),
    ),
    depth: -3,
  );

  ////// Home///////////////////////////////////////////////////////////////

  static NeumorphicStyle homeOptionWidgetLight = NeumorphicStyle(
    color: ConstColors.colorBackgroundLight,
    shadowLightColor: ConstColors.lightShadowLight,
    shadowDarkColor: ConstColors.lightShadowDark,

    shape: NeumorphicShape.flat,
    boxShape: NeumorphicBoxShape.roundRect(
        const BorderRadius.all(
            Radius.circular(12))),

    depth: 3,

  );
  static NeumorphicStyle homeOptionWidgetDark = NeumorphicStyle(
    color: ConstColors.colorBackgroundDark,
    shadowLightColor: ConstColors.darkShadowLight,
    shadowDarkColor: ConstColors.darkShadowDark,
    shape: NeumorphicShape.flat,
    boxShape: NeumorphicBoxShape.roundRect(
        const BorderRadius.all(
            Radius.circular(12))),

    depth: 3,
  );

  ////// Settings///////////////////////////////////////////////////////////////

  static NeumorphicStyle settingsFirstWidgetLight = NeumorphicStyle(
    color: ConstColors.colorBackgroundLight,
    shadowLightColor: ConstColors.lightShadowLight,
    shadowDarkColor: ConstColors.lightShadowDark,
    boxShape: NeumorphicBoxShape.roundRect(
      const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    depth: 2,
  );
  static NeumorphicStyle settingsFirstWidgetDark = NeumorphicStyle(
    color: ConstColors.colorBackgroundDark,
    shadowLightColor: ConstColors.darkShadowLight,
    shadowDarkColor: ConstColors.darkShadowDark,
    boxShape: NeumorphicBoxShape.roundRect(
      const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    depth: 2,
  );
  static NeumorphicStyle settingsMiddleWidgetLight = NeumorphicStyle(
    color: ConstColors.colorBackgroundLight,
    shadowLightColor: ConstColors.lightShadowLight,
    shadowDarkColor: ConstColors.lightShadowDark,
    boxShape: NeumorphicBoxShape.roundRect(
      const BorderRadius.all(Radius.circular(0)),
    ),
    depth: 2,
  );
  static NeumorphicStyle settingsMiddleWidgetDark = NeumorphicStyle(
    color: ConstColors.colorBackgroundDark,
    shadowLightColor: ConstColors.darkShadowLight,
    shadowDarkColor: ConstColors.darkShadowDark,
    boxShape: NeumorphicBoxShape.roundRect(
      const BorderRadius.all(Radius.circular(0)),
    ),
    depth: 2,
  );
  static NeumorphicStyle settingsLastWidgetLight = NeumorphicStyle(
    color: ConstColors.colorBackgroundLight,
    shadowLightColor: ConstColors.lightShadowLight,
    shadowDarkColor: ConstColors.lightShadowDark,
    boxShape: NeumorphicBoxShape.roundRect(
      const BorderRadius.only(
        bottomRight: Radius.circular(16),
        bottomLeft: Radius.circular(16),
      ),
    ),
    depth: 2,
  );
  static NeumorphicStyle settingsLastWidgetDark = NeumorphicStyle(
    color: ConstColors.colorBackgroundDark,
    shadowLightColor: ConstColors.darkShadowLight,
    shadowDarkColor: ConstColors.darkShadowDark,
    boxShape: NeumorphicBoxShape.roundRect(
      const BorderRadius.only(
        bottomRight: Radius.circular(16),
        bottomLeft: Radius.circular(16),
      ),
    ),
    depth: 2,
  );
  static NeumorphicStyle settingsWidgetIconsLight = NeumorphicStyle(
    color: ConstColors.colorBackgroundLight,
    shadowLightColor: ConstColors.lightShadowLight,
    shadowDarkColor: ConstColors.lightShadowDark,
    depth: 2,
  );
  static NeumorphicStyle settingsWidgetIconsDark = NeumorphicStyle(
    color: ConstColors.colorBackgroundDark,
    shadowLightColor: ConstColors.darkShadowLight,
    shadowDarkColor: ConstColors.darkShadowDark,
    depth: 2,
  );
  static NeumorphicStyle settingsWidgetColorsLight = NeumorphicStyle(
    shadowLightColorEmboss: ConstColors.lightShadowLight,
    shadowDarkColorEmboss: ConstColors.lightShadowDark,
    boxShape: const NeumorphicBoxShape.circle(),
    depth: -3,
  );
  static NeumorphicStyle settingsWidgetColorsDark = NeumorphicStyle(
    shadowLightColorEmboss: ConstColors.darkShadowLight,
    shadowDarkColorEmboss: ConstColors.darkShadowDark,
    boxShape: const NeumorphicBoxShape.circle(),
    depth: -3,
  );

  //////////////////////////////////////////////////////////////////////////////

  static NeumorphicStyle lastPrayerMainLight = NeumorphicStyle(
    shape: NeumorphicShape.flat,
    boxShape: NeumorphicBoxShape.roundRect(
         BorderRadius.all(Radius.circular(50.sp))),
    color: ConstColors.colorBackgroundDark,
    shadowLightColor: ConstColors.lightShadowLight,
    shadowDarkColor: ConstColors.lightShadowDark,
    depth: 4,
  ); static NeumorphicStyle lastPrayerMainDark = NeumorphicStyle(
    shape: NeumorphicShape.flat,
    boxShape: NeumorphicBoxShape.roundRect(
         BorderRadius.all(Radius.circular(50.sp))),
    color: ConstColors.colorBackgroundDark,
    shadowLightColor: ConstColors.darkShadowLight,
    shadowDarkColor: ConstColors.darkShadowDark,
    depth: 4,
  );
  static NeumorphicStyle lastPrayerLight = NeumorphicStyle(
    shape: NeumorphicShape.flat,
    boxShape: NeumorphicBoxShape.roundRect(
        const BorderRadius.all(Radius.circular(10))),
    shadowLightColorEmboss: ConstColors.lightShadowLight,
    shadowDarkColorEmboss: ConstColors.lightShadowDark,
    depth: -3,
  );
  static NeumorphicStyle lastPrayerDark = NeumorphicStyle(
    shape: NeumorphicShape.flat,
    boxShape: NeumorphicBoxShape.roundRect(
        const BorderRadius.all(Radius.circular(10))),
    shadowLightColorEmboss: ConstColors.darkShadowLight,
    shadowDarkColorEmboss: ConstColors.darkShadowDark,
    depth: -3,
  );
  static NeumorphicStyle lastPrayerLastLight = NeumorphicStyle(
    color: ConstColors.colorBackgroundDark,
    shadowLightColor: ConstColors.lightShadowLight,
    shadowDarkColor: ConstColors.lightShadowDark,
    depth: 3,
  );
  static NeumorphicStyle lastPrayerLastDark = NeumorphicStyle(
    color: ConstColors.colorBackgroundDark,
    shadowLightColor: ConstColors.darkShadowLight,
    shadowDarkColor: ConstColors.darkShadowDark,
    depth: 3,
  );
  //////////////////////////////////////////////////////////////////////////////




}
