import 'dart:io';
import 'dart:typed_data';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:winner_draw/feature/auth/presentation/pages/otp_screen.dart';
import '../../../../core/routes/app_pages.dart';
import '../../../../core/utils/injections.dart';
import '../../../../core/utils/use_case.dart';
import '../../../../core/widgets/snake_bars.dart';
import '../../../client/main_client/presentation/widgets/dialogbox_otp_success.dart';
import '../../domain/entities/model_otp.dart';
import '../../domain/entities/model_reset_password.dart';
import '../../../admin/main_admin/presentation/manager/main_nav_admin_controller.dart';
import '../../../client/main_client/presentation/manager/main_nav_client_controller.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/use_cases/forget_use_case.dart';
import '../../domain/use_cases/get_all_user_use_case.dart';
import '../../domain/use_cases/login_user_use_case.dart';
import '../../domain/use_cases/logout_use_case.dart';
import '../../domain/use_cases/pass_otp_use_case.dart';
import '../../domain/use_cases/register_user_use_case.dart';
import '../../domain/use_cases/resend_otp_use_case.dart';
import '../../domain/use_cases/change_password_use_case.dart';
import '../../domain/use_cases/update_user_use_case.dart';
import '../../domain/use_cases/verify_otp_use_case.dart';
import '../widgets/dialogbox_forgort_pass.dart';
import '../widgets/dialogbox_forgort_pass_otp_error.dart';

class AuthController extends GetxController {
  final RegisterUserUseCase registerUserUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final LoginUserUseCase loginUserUseCase;
  final LogoutUseCase logoutUseCase;
  final GetAllUserUseCase getAllUserUseCase;
  final ForgetUseCase forgetUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final PassOtpUseCase passOtpUseCase;
  final ReSendOtpUseCase reSendOtpUseCase;
  final UpdateUserUseCase updateUserUseCase;

  RxBool isSignIn = true.obs;
  RxBool isForgot = true.obs;

  AuthController(
      {required this.passOtpUseCase,
      required this.reSendOtpUseCase,
      required this.changePasswordUseCase,
      required this.verifyOtpUseCase,
      required this.updateUserUseCase,
      required this.forgetUseCase,
      required this.getAllUserUseCase,
      required this.logoutUseCase,
      required this.loginUserUseCase,
      required this.registerUserUseCase});

  List<String> pakistanStates = [

    "KPK",
    "Punjab",
    "Sindh",
    "Balochistan",
    "Azad jammu kashmir",
    "Gilgit Baldistan",
  ];
  RxString selectedProvince = "".obs;

  setProvince(String val) {
    formKey.currentState!.validate();
    selectedProvince.value = val;
  }

  toggleSignIn() {
    isSignIn.value = !isSignIn.value;
  }

  TextEditingController signUpNameController = TextEditingController();
  TextEditingController signUpPhoneController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpConfirmPasswordController = TextEditingController();

  TextEditingController forgotPassEmailController = TextEditingController();
  TextEditingController signInEmailController = TextEditingController();
  TextEditingController changePasswordEmailController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();



  clearController(){
     signUpNameController.clear();
     signUpPhoneController.clear();
     signUpEmailController.clear();
     signUpPasswordController.clear();
     signUpConfirmPasswordController .clear();
     forgotPassEmailController.clear();
     signInEmailController.clear();
     changePasswordEmailController.clear();
     signInPasswordController.clear();
     oldPasswordController.clear();
     newPasswordController.clear();
     confirmNewPasswordController .clear();
     cleanImage();
  }

  Future<void> signUpSubmit(BuildContext context) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      CustomSnakeBars.snakeBanner(
          context, 'Failed', 'Please Check Internet Connection', 'failure');
    } else if (selectedProvince.value.trim().isEmpty) {
      CustomSnakeBars.snakeBanner(
          context, 'Failed', 'Please Select Province', 'failure');
    } else {
      EasyLoading.show();
      String imgUrl = "";
      if (isImage.value) {
        imgUrl = filePath!;
      }
      AppUser user = AppUser(
          name: signUpNameController.text.trim(),
          province: selectedProvince.value,
          email: signUpEmailController.text.trim(),
          contact: signUpPhoneController.text.trim(),
          profilePicture: imgUrl,
          file: file,
          password: signUpPasswordController.text.trim());

      // AppUser user = AppUser(
      //   province: selectedProvince.value,
      //     isAdmin: false,
      //     status: 0,
      //     imgUrl: imgUrl,
      //     name: signUpNameController.text,
      //     phone: signUpPhoneController.text,
      //     email: signUpEmailController.text,
      //     password: signUpPasswordController.text
      //
      // );
      //

      bool isAdded = false;
      for (var element in allUsers) {
        if (user.contact == element.contact) {
          isAdded = true;
        }
      }

      if (!isAdded) {
        if (formKey.currentState!.validate()) {
          var results = await registerUserUseCase(Params(user));
          results.fold(
              (failure) => CustomSnakeBars.snakeBanner(
                  context, 'Failed', failure.message, 'failure'), (value) {
            if (value) {
              GetStorage().write("email", signUpEmailController.text);
              GetStorage().write("pass", signUpPasswordController.text);
              sl<MainNavClientController>().getCurrentLuckyDraw();
              sl<MainNavAdminController>().getCurrentLuckyDraw();
              sl<MainNavClientController>().loadData();
              Get.offAll(OtpScreen());
              // Get.toNamed(Routes.OTPSCREEN);
              clearController();
              // signUpNameController.clear();
              // signUpPasswordController.clear();
              // signUpPhoneController.clear();
              // signUpEmailController.clear();
              // signUpConfirmPasswordController.clear();
            } else {
              CustomSnakeBars.snakeBanner(
                  context,
                  'Failed',
                  'This Email is already register. Please try another one',
                  'failure');
            }
          });
        } else {
          CustomSnakeBars.snakeBanner(
              context, 'Failed', 'Please Enter All Fields', 'failure');
        }
      } else {
        CustomSnakeBars.snakeBanner(
            context, 'Failed', 'Phone Number already Exists', 'failure');
      }

      EasyLoading.dismiss();
    }

    // } else {
    //   CustomSnakeBars.snakeBanner(
    //       context, 'Failed', 'Please Select Image First', 'failure');
    // }
  }

  Future<void> forgotPassSubmit(BuildContext context) async {
    EasyLoading.show();
    if (forgetFormKey.currentState!.validate()) {
      AppUser user = AppUser(email: forgotPassEmailController.text);
      var results = await forgetUseCase(Params(user));
      results.fold(
              (failure) => CustomSnakeBars.snakeBanner(
              context, 'Failed', failure.message, 'failure'),
              (value) {
            GetStorage().write("email", forgotPassEmailController.text);
            isForgot.value = false;
            Get.dialog(ForgotPassDialogBox());
            clearController();
          });
      // await authService.forgetPass(forgotPassEmailController.text);
    } else {
      CustomSnakeBars.snakeBanner(
          context, 'Failed', 'Please Enter Your Email', 'failure');
    }

    EasyLoading.dismiss();
  }


  Future<bool> changePassword(BuildContext context) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      CustomSnakeBars.snakeBanner(
          context, 'Failed', 'Please Check Internet Connection', 'failure');
    } else {
      EasyLoading.show();
      if (changePasswordKey.currentState!.validate()) {
        ModelChangePassword mdl = ModelChangePassword(
            email: changePasswordEmailController.text,
            otp: oldPasswordController.text,
            newPassword: newPasswordController.text);
        var results = await changePasswordUseCase(Params(mdl));
        results.fold((failure) {
          CustomSnakeBars.snakeBanner(
              context, 'Failed', failure.message, 'failure');
        }, (value) {
          if (value != null) {
           clearController();
            return true;
          } else {
            CustomSnakeBars.snakeBanner(
                context, 'Failed', 'User Credentials Invalid', 'failure');
          }
        });
      } else {
        CustomSnakeBars.snakeBanner(context, 'Failed',
            'please enter your email and password', 'failure');
      }

      EasyLoading.dismiss();
    }
    return false;
  }

  //
  logout(BuildContext context) async {
    EasyLoading.show();

/*    var results = await logoutUseCase(NoParams());

    results.fold(
        (failure) => CustomSnakeBars.snakeBanner(
            context, 'Failed', 'User Logged Out Failed', 'failure'), (value) {
    });*/
    GetStorage().write("token", "");
    GetStorage().write("isLogin", false);
    GetStorage().write("UserId", "");
    Get.offAllNamed(Routes.AUTH);
    isSignIn.value = true;

    EasyLoading.dismiss();
  }

  List<AppUser> allUsers = [];

  getAllUsers() async {
    allUsers.clear();
    EasyLoading.show();

    var results = await getAllUserUseCase(NoParams());

    results.fold((failure) => null, (value) {
      allUsers = value;
    });
    EasyLoading.dismiss();
  }

  String? validateNameField(String? text) {
    if (text == null || text.isEmpty) {
      return 'Name is empty';
    }
    return null;
  }

  String? validateEmailField(String? text) {
    String pattern =
        r"^[a-zA-Z0-9_.]+@(gmail|yahoo|outlook|apple|hotmail|mailbox|aim).com$";
    RegExp regex = RegExp(pattern);

    if (text!.isEmpty) {
      return "Email is empty";
    } else if (!regex.hasMatch(text)) {
      return 'Enter a Valid Email Address ';
    }
    return null;
  }

  String? validatePasswordField(String? text) {
    if (text == null || text.isEmpty) {
      return 'Password is empty';
    } else if (text.length < 6) {
      return 'Password must be more then 5 alphabets';
    }
    return null;
  }

  String? validateConfirmPasswordField(String? text) {
    if (text == null || text.isEmpty) {
      return 'Confirm Password is empty';
    } else if (text != signUpPasswordController.text) {
      return 'Password is not matched';
    }
    return null;
  }

  String? validateConfirmNewPasswordField(String? text) {
    if (text == null || text.isEmpty) {
      return 'Confirm Password is empty';
    }
    return null;
  }

  String? validateContactField(String? text) {
    if (text == null || text.isEmpty) {
      return 'Contact is empty';
    } else if (text.contains('03')) {

        if (text.length < 11) {
          return 'Contact must be 11 digits';
        } else {
          return null;
        }

    } else
      if (!text.contains('03')) {
        return 'Contact should contain 03';

    }
    return null;
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgetFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgetPassFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> changePasswordKey = GlobalKey<FormState>();

  RxBool isImage = false.obs;

  File? file;
  String? filePath;
  Uint8List? imageFile;

  getPicture(ImageSource img) async {
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: img,
    );
    if (pickedImage != null) {
      filePath = pickedImage.path;

      file = File(pickedImage.path);
      imageFile = await pickedImage.readAsBytes();
      // String imgUrl = await sl<AdminMainDatabase>().profileImage(file!);
      // AppUser user = appUser!.copyWith(imgUrl: imgUrl);
      // await sl<MainDatabase>().registerUser(user);
      // appUser=user;
      isImage.value = false;
      isImage.value = true;
    } else {}
    Get.back();
  }

  cleanImage() {
    file = null;
    filePath = null;
    imageFile = null;
    isImage.value = true;
    isImage.value = false;
    Get.back();
  }

  callWhatsApp() async {
    var contact = "+923039208843";
    var androidUrl =
        "whatsapp://send?phone=$contact&text=Hi, I need some help.";
    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse("Hi, I'm interested in services you provide.")}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl),
            mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(Uri.parse(androidUrl),
            mode: LaunchMode.externalApplication);
      }
    } on Exception {
      EasyLoading.showError('WhatsApp is not installed.');
    }
  }

  Future<void> openFacebook() async {
    String fbProtocolUrl;
    String fallbackUrl =
        'https://www.facebook.com/profile.php?id=61564963724854&mibextid=LQQJ4d';
    if (Platform.isIOS) {
      fbProtocolUrl =
          'fb://profile/100094637781973&mibextid=ZbWKwL&_rdc=1&_rdr';
    } else {
      // fbProtocolUrl = 'fb://page/100094637781973&mibextid=gjUFcU';
      fbProtocolUrl = fallbackUrl;
    }

    try {
      Uri fbBundleUri = Uri.parse(fbProtocolUrl);
      var canLaunchNatively = await canLaunchUrl(fbBundleUri);

      if (canLaunchNatively) {
        launchUrl(fbBundleUri);
      } else {
        await launchUrl(Uri.parse(fallbackUrl),
            mode: LaunchMode.externalApplication);
      }
    } catch (e, st) {
      // Handle this as you prefer
    }
  }

  Future<void> openTiktok() async {
    String fallbackUrl = 'https://www.tiktok.com/@winner_draw?_t=8pRLhIK363Q&_r=1';

    try {
      Uri fbBundleUri = Uri.parse(fallbackUrl);
      //var canLaunchNatively = await canLaunchUrl(fbBundleUri);

   //   if (canLaunchNatively) {
        await launchUrl(Uri.parse(fallbackUrl),
            mode: LaunchMode.externalApplication);
   //   } else {}
    } catch (e) {
      // Handle this as you prefer
    }
  }

  Future<void> openYoutube() async {

    String youTubeYrl = 'https://youtube.com/@winnerdraw?si=jFkS6WpMTZpKyFPB';

    if (Platform.isIOS) {
      if (await canLaunchUrl(Uri.parse(
          youTubeYrl))) {
        await launchUrl(Uri.parse(
            (youTubeYrl)));
      } else {
        if (await canLaunchUrl(Uri.parse(
            youTubeYrl))) {
          await launchUrl(Uri.parse(
              youTubeYrl));
        } else {
          throw 'Could not launch $youTubeYrl';
        }
      }
    } else {
      const url = 'https://youtube.com/@winnerdraw?si=jFkS6WpMTZpKyFPB';
     // if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      // } else {
      //   throw 'Could not launch $url';
      // }
    }
  }

  reSendOTP() async {
    String emailX = GetStorage().read("email");
    ModelOTP mdl = ModelOTP(email: emailX);
    var results = await reSendOtpUseCase(Params(mdl));
    results.fold((failure) => null, (value) {
      if (value != null) {
        sl<MainNavAdminController>().loadData();
        sl<MainNavAdminController>().getCurrentLuckyDraw();
        sl<MainNavClientController>().getCurrentLuckyDraw();
      }
    });
  }

  Future<void> signInSubmit(BuildContext context) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      CustomSnakeBars.snakeBanner(
          context, 'Failed', 'Please Check Internet Connection', 'failure');
    } else {
      EasyLoading.show();
      if (signInFormKey.currentState!.validate()) {
        GetStorage().write("email", signInEmailController.text);
        GetStorage().write("pass", signInPasswordController.text);
        loginFunc();
      } else {
        CustomSnakeBars.snakeBanner(context, 'Failed',
            'please enter your email and password', 'failure');
      }

      EasyLoading.dismiss();
    }
  }

  Future<void> loginFunc() async {
    EasyLoading.show();
    String email = GetStorage().read("email");
    String pass = GetStorage().read("pass");
    AppUser user = AppUser(email: email, password: pass);

    var results = await loginUserUseCase(Params(user));
    results.fold((failure)  {
    CustomSnakeBars.snakeBanner(
    Get.context!, 'Failed', failure.message, 'failure');
        if (failure.message == "Your account is not verified.") {
      Get.toNamed(Routes.OTPSCREEN);
    }
  }, (value) async {
      if (value != null) {

        sl<MainNavAdminController>().loadData();
        sl<MainNavAdminController>().getCurrentLuckyDraw();
        sl<MainNavClientController>().getCurrentLuckyDraw();
        sl<MainNavClientController>().getMyRequest();
        // sl<MainNavClientController>().loadData();
        sl<MainNavClientController>().appUser = value;
        sl<MainNavClientController>().isUser.value = true;
        if (value.isAdmin!) {
          Get.offAllNamed(Routes.MAINADMIN);
        } else {
          Get.offAllNamed(Routes.MAINCLIENT);
        }
        clearController();
      }
    });
    EasyLoading.dismiss();
  }

  RxBool isOTPComplete = false.obs;
  RxInt opt = 0.obs;

  Future<bool> verifyOTP(BuildContext context) async {
    if (isOTPComplete.value) {
      String emailX = GetStorage().read("email");
      ModelOTP mdl = ModelOTP(email: emailX, otpCode: opt.value);
EasyLoading.show();
      var results = await verifyOtpUseCase(Params(mdl));
      results.fold((failure) => null, (value) {
        print("return : $value");
        if (value) {
          loginFunc();
          EasyLoading.dismiss();
          return true;
        }
      });
    }
    EasyLoading.dismiss();
    return false;
  }

  Future<bool> passOTP(BuildContext context) async {
    if (forgetPassFormKey.currentState!.validate()) {
      if (isOTPComplete.value) {
        EasyLoading.show();
        String emailX = GetStorage().read("email");
        ModelOTP mdl = ModelOTP(
            email: emailX,
            otpCode: opt.value,
            newPassword: newPasswordController.text);
        var results = await passOtpUseCase(Params(mdl));
        results.fold((failure) {
          CustomSnakeBars.snakeBanner(
              context, 'Failed', failure.message, 'failure');
        }, (value) {
          if (value) {
            isForgot.value = true;
            Get.dialog(OtpSuccessDialogBox(
              msg:
              "Your Password Changed Successfully", onTap: () => Get.offAllNamed(Routes.AUTH),
            ));
          }
        });
        EasyLoading.dismiss();
      }else {
        Get.dialog(ForgotPassOTPErrorDialogBox());
        return false;
      }
    }

    return false;
  }





























}
