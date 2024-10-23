import 'dart:ui';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/const_styles.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../../core/widgets/default_button.dart';
import '../manager/main_nav_client_controller.dart';

class PaymentBankDialogBox extends StatelessWidget {
  PaymentBankDialogBox({super.key});
  final mainController = sl<MainNavClientController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(5.w),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.w)), //this right here
      child: Container(
        height: 60.h,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.sp)),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              width: 80.w,
              decoration:
                  BoxDecoration(color: Colors.grey.shade200.withOpacity(0.2)),
              child: Obx(
                () => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      CreditCardWidget(
                        cardNumber: mainController.cardNumber.value,
                        expiryDate: mainController.expiryDate.value,
                        cardHolderName: mainController.cardHolderName.value,
                        cvvCode: mainController.cvvCode.value,
                        showBackView: mainController.isCvvFocused.value,
                        onCreditCardWidgetChange: (CreditCardBrand brand) {},
                        bankName: 'Credit Card',
                        cardBgColor: Colors.black87,
                        glassmorphismConfig: Glassmorphism.defaultConfig(),
                        enableFloatingCard: true,
                        floatingConfig: const FloatingConfig(
                          isGlareEnabled: true,
                          isShadowEnabled: true,
                          shadowConfig: FloatingShadowConfig(),
                        ),
                        backgroundImage: 'assets/images/card_bg.png',
                        // backgroundNetworkImage: 'https://www.xyz.com/card_bg.png',
                        labelValidThru: 'VALID\nTHRU',
                        obscureCardNumber: true,
                        obscureInitialCardNumber: false,
                        obscureCardCvv: true,
                        labelCardHolder: 'CARD HOLDER',

                        cardType: CardType.mastercard,
                        isHolderNameVisible: false,
                        height: 175,
                        textStyle: const TextStyle(color: Colors.yellowAccent),
                        width: MediaQuery.of(context).size.width,
                        isChipVisible: true,
                        isSwipeGestureEnabled: true,
                        animationDuration: const Duration(milliseconds: 1000),
                        frontCardBorder: Border.all(color: Colors.grey),
                        backCardBorder: Border.all(color: Colors.grey),
                        chipColor: Colors.grey,
                        padding: 16,
                        // customCardTypeIcons: <CustomCardTypeIcons>[
                        //   CustomCardTypeIcons(
                        //     cardType: CardType.mastercard,
                        //     cardImage: Image.asset(
                        //       'assets/images/mastercard.png',
                        //       height: 48,
                        //       width: 48,
                        //     ),
                        //   ),
                        // ],
                      ),
                      Column(
                        children: <Widget>[
                          CreditCardForm(
                            formKey: mainController.bankFormKey,
                            obscureCvv: true,
                            obscureNumber: true,
                            cardNumber: mainController.cardNumber.value,
                            cvvCode: mainController.cvvCode.value,
                            isHolderNameVisible: true,
                            isCardNumberVisible: true,
                            isExpiryDateVisible: true,
                            cardHolderName: mainController.cardHolderName.value,
                            expiryDate: mainController.expiryDate.value,
                            inputConfiguration: InputConfiguration(
                              cardHolderTextStyle:
                                  ConstStyle.tileTitleTextStyle,
                              expiryDateTextStyle:
                                  ConstStyle.tileTitleTextStyle,
                              cvvCodeTextStyle: ConstStyle.tileTitleTextStyle,
                              cardNumberTextStyle:
                                  ConstStyle.tileTitleTextStyle,
                              cardNumberDecoration: InputDecoration(
                                labelStyle: ConstStyle.tileTitleTextStyle,
                                floatingLabelStyle:
                                    ConstStyle.tileTitleTextStyle,
                                hintStyle: ConstStyle.tileTitleTextStyle,
                                helperStyle: ConstStyle.tileTitleTextStyle,
                                labelText: 'Number',
                                hintText: 'XXXX XXXX XXXX XXXX',
                              ),
                              expiryDateDecoration: InputDecoration(
                                labelStyle: ConstStyle.tileTitleTextStyle,
                                floatingLabelStyle:
                                    ConstStyle.tileTitleTextStyle,
                                hintStyle: ConstStyle.tileTitleTextStyle,
                                helperStyle: ConstStyle.tileTitleTextStyle,
                                labelText: 'Expired Date',
                                hintText: 'XX/XX',
                              ),
                              cvvCodeDecoration: InputDecoration(
                                labelStyle: ConstStyle.tileTitleTextStyle,
                                floatingLabelStyle:
                                    ConstStyle.tileTitleTextStyle,
                                hintStyle: ConstStyle.tileTitleTextStyle,
                                helperStyle: ConstStyle.tileTitleTextStyle,
                                labelText: 'CVV',
                                hintText: 'XXX',
                              ),
                              cardHolderDecoration: InputDecoration(
                                labelStyle: ConstStyle.tileTitleTextStyle,
                                floatingLabelStyle:
                                    ConstStyle.tileTitleTextStyle,
                                hintStyle: ConstStyle.tileTitleTextStyle,
                                helperStyle: ConstStyle.tileTitleTextStyle,
                                labelText: 'Card Holder',
                              ),
                            ),
                            onCreditCardModelChange: (m) =>
                                mainController.onCreditCardModelChange(m),
                          ),
                          SizedBox(height: 2.h),
                          DefaultButton(
                            text: "Submit",
                            onPressed: () => mainController.submitBank(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
