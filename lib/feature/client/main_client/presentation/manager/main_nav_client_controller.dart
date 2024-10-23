import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:confetti/confetti.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:wheel_spin/wheelspin.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../../core/utils/use_case.dart';
import '../../../../../core/widgets/snake_bars.dart';
import '../../../../admin/main_admin/data/data_sources/admin_database_main.dart';
import '../../../../admin/main_admin/domain/entities/model_participants.dart';
import '../../../../admin/main_admin/domain/entities/model_photos.dart';
import '../../../../admin/main_admin/domain/entities/model_photos_comment.dart';
import '../../../../admin/main_admin/domain/entities/model_prize.dart';
import '../../../../admin/main_admin/domain/entities/model_results.dart';
import '../../../../admin/main_admin/domain/entities/model_slider.dart';
import '../../../../admin/main_admin/domain/entities/request_model.dart';
import '../../../../admin/main_admin/domain/use_cases/add_participant_use_case.dart';
import '../../../../admin/main_admin/domain/use_cases/add_photo_comment_use_case.dart';
import '../../../../admin/main_admin/domain/use_cases/get_current_lucky_draw_use_case.dart';
import '../../../../admin/main_admin/domain/use_cases/get_current_results_use_case.dart';
import '../../../../admin/main_admin/domain/use_cases/get_participants_use_case.dart';
import '../../../../admin/main_admin/domain/use_cases/get_photo_comments_use_case.dart';
import '../../../../admin/main_admin/domain/use_cases/get_photos_use_case.dart';
import '../../../../admin/main_admin/domain/use_cases/get_slider_use_case.dart';
import '../../../../admin/main_admin/domain/use_cases/insert_new_request.dart';
import '../../../../admin/main_admin/domain/use_cases/like_dislike_photo_use_case.dart';
import '../../../../auth/data/data_sources/database_main.dart';
import '../../../../auth/domain/entities/app_user.dart';
import '../widgets/dialogbox_winner.dart';
import 'package:audioplayers/audioplayers.dart';

class MainNavClientController extends GetxController {

  AudioPlayer player = AudioPlayer();
  AudioPlayer player2 = AudioPlayer();
  RxBool isPlaying = false.obs;
  RxBool isPlaying2 = false.obs;
  Duration duration = Duration.zero;
  Duration duration2 = Duration.zero;
  Duration position = Duration.zero;
  Duration position2 = Duration.zero;

  List<String> pakistanStates = [

    "kpk",
    "Punjab",
    "Sindh",
    "Balochistan",
    "Azad jammu kashmir",
    "Gilgit Baldistan",
  ];
  RxString selectedProvince = "".obs;

  setProvince(String val) async {
    selectedProvince.value = val;
    EasyLoading.show();
    AppUser usr = appUser!.copyWith(province: selectedProvince.value);

    await sl<MainDatabase>().registerUser(usr);

    EasyLoading.dismiss();
  }

  void closeConfitte() {
    if (isPlaying.value) {
      player.stop();
    }
    controllerCenter.stop();
  }

  setCelebration() {
    if (isPlaying.value) {
      player.stop();
      controllerCenter.stop();
    }
    player.play(AssetSource("sound_celebration.mp3"));
    // player.play(AssetSource("wheel_spin.mp3"));
    controllerCenter.play();

    Timer(const Duration(seconds: 10), () {
      if (isPlaying.value) {
        player.stop();
      }
      controllerCenter.stop();
    });
  }

  final ConfettiController controllerCenter =
      ConfettiController(duration: const Duration(seconds: 5));

  @override
  void dispose() {
    controllerCenter.dispose();

    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 15;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  /// PAGE VIEWVER !@#$%^&*()(*&^%$#@!@#$%^&*()_)(*&^%$#@!
  final PageController _pageController = PageController();

  PageController get pageController => _pageController;

  RxInt currentPage = 0.obs;

  setPage(int page) {
    currentPage.value = page;
  }

  RxString typeSelected = ''.obs;

  setType() {
    Timer(const Duration(seconds: 5), () {
      setPage(currentPage.value);
      if (_pageController.hasClients) {
        _pageController.animateToPage(currentPage.value,
            duration: const Duration(seconds: 1), curve: Curves.easeInOut);

        currentPage.value++;
        currentPage.value =
            currentPage.value == pageViewData.length ? 0 : currentPage.value;
      }
      setType();
    });
  }

  RxBool isPageLoaded = false.obs;
  List<ModelSlider> pageViewData = [];

  /// PAGE VIEWVER !@#$%^&*()(*&^%$#@!@#$%^&*()_)(*&^%$#@!
  final GetCurrentLuckyDrawUseCase getCurrentLuckyDrawUseCase;
  final GetPhotosUseCase getPhotosUseCase;
  final GetPhotoCommentsUseCase getPhotoCommentsUseCase;
  final GetSliderUseCase getSliderUseCase;
  final GetParticipantsUseCase getParticipantsUseCase;
  final AddParticipantUseCase addParticipantUseCase;
  final LikeDislikePhotoUseCase likeDislikePhotoUseCase;
  final AddPhotoCommentsUseCase addPhotoCommentsUseCase;
  final GetCurrentResultsUseCase getCurrentResultsUseCase;
  final InsertNewRequestUseCase insertNewRequestUseCase;

  RxInt selectedTab = 0.obs;
  RxInt selectedTabIndex = 0.obs;

  AppUser? appUser;
  RxBool isUser = false.obs;

  loadData() {
    player.onPlayerStateChanged.listen((event) {
      isPlaying.value = event == PlayerState.playing;
    });
    player.onDurationChanged.listen((event) {
      duration = event;
    });
    player.onPositionChanged.listen((event) {
      position = event;
    });
    player2.onPlayerStateChanged.listen((event) {
      isPlaying2.value = event == PlayerState.playing;
    });
    player2.onDurationChanged.listen((event) {
      duration2 = event;
    });
    player2.onPositionChanged.listen((event) {
      position2 = event;
    });
    _pageController.initialPage;
    getPhotos();
    getSliders();
    getParticipants();
    // getCurrentUser();
    getCurrentResults();
  }

  MainNavClientController({
    required this.getCurrentResultsUseCase,
    required this.getPhotoCommentsUseCase,
    required this.addPhotoCommentsUseCase,
    required this.likeDislikePhotoUseCase,
    required this.addParticipantUseCase,
    required this.getParticipantsUseCase,
    required this.getSliderUseCase,
    required this.getPhotosUseCase,
    required this.getCurrentLuckyDrawUseCase,
    required this.insertNewRequestUseCase,
  });

  setSelectedTab(int val) {
    selectedTab.value = val;
    setSelectedTabIndex(val);
  }

  setSelectedTabIndex(int val) {
    selectedTabIndex.value = val;
  }

  List<String> bottomTitle = [
    "Home",
    'Photos',
  ];
  List<IconData> bottomIcon = [
    Icons.home,
    Icons.dashboard,
  ];

  ///    Showing Lucky Draw !@#$%^&*()(*&^%$#@!@#$%^&*()!@#$%^&*()(*&^%$#@!
  RxBool isCurrentLuckyDraw = false.obs;
  List<ModelPrize> luckyDrawList = [];

  getCurrentLuckyDraw() async {
    isCurrentLuckyDraw.value = false;
    luckyDrawList.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    var results = await getCurrentLuckyDrawUseCase(NoParams());

    results.fold((failure) => null, (value) {
      luckyDrawList = value;
      if (luckyDrawList.isNotEmpty) {
        isCurrentLuckyDraw.value = true;
        timerValues();
      }
    });
  }

  RxString timerVal1 = '00:00'.obs;
  RxString timerVal2 = '00:00'.obs;
  RxString timerVal3 = '00:00'.obs;

  RxBool isTimer1 = false.obs;
  RxBool isTimer2 = false.obs;
  RxBool isTimer3 = false.obs;
  RxBool isPayable = true.obs;

  timerValues() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      for (var element in luckyDrawList) {
        DateTime given = DateTime.fromMillisecondsSinceEpoch(element.timer!);

        DateTime timeNow = DateTime.now().subtract(const Duration(minutes: 5));
        Duration d = given.difference(timeNow);


        String dur = d.toString().substring(0, 8);
        String timerVal = d.inMilliseconds > 0 ? dur : "00:00:00";

        // wheelSpinController1.startWheel();
        // wheelSpinController1.stopWheel(2);

        // print("::::::::::::ZZZZZZ:::::::::");
        // print(element.no.toString());
        // print(timerVal);
        // print(given);
        // print(dur);
        // print(d.inMilliseconds );
        if (element.no == 1) {
          timerVal1.value = timerVal;
          if (d.inMilliseconds < 0 && !isTimer1.value) {
            isTimer1 = false.obs;
            isTimer1 = true.obs;

            if (isPlaying2.value) {
              player2.stop();
            }
            if ((d.inMilliseconds) < 5000 && (d.inMilliseconds) > -5000) {
              player2.play(AssetSource("wheel_spin.mp3"));
            }

             getCurrentResults();
            try {
              wheelSpinController1.startWheel();
            } catch (e) {}
            Timer(const Duration(seconds: 5), () {
              try {
                wheelSpinController1.stopWheel(2);
              } catch (e) {}
              isTimer1 = false.obs;
              isTimer1 = true.obs;

              isPayable.value = false;
              Iterable<ModelResults> results =
                  currentResultList.where((element) => element.prizeNo == 1);

              if ((d.inMilliseconds) < 5000 && (d.inMilliseconds) > -5000) {
                setCelebration();
                Get.dialog(
                    WinnerDialogBox(
                      prize: results.first,
                    ),
                    barrierDismissible: false);
              }

              if (isPlaying2.value) {
                player2.stop();
              }
            });
          }
        }
        if (element.no == 2) {
          timerVal2.value = timerVal;
          if (d.inMilliseconds < 0 && !isTimer2.value) {
            isTimer2 = false.obs;
            isTimer2 = true.obs;
            getCurrentResults();
            if (isPlaying2.value) {
              player2.stop();
            }
            if ((d.inMilliseconds) < 5000 && (d.inMilliseconds) > -5000) {
              player2.play(AssetSource("wheel_spin.mp3"));
            }
            try {
              wheelSpinController2.startWheel();
            } catch (e) {}

            Timer(const Duration(seconds: 5), () {
              try {
                wheelSpinController2.stopWheel(2);
              } catch (e) {}

              Iterable<ModelResults> results =
                  currentResultList.where((element) => element.prizeNo == 2);

              if ((d.inMilliseconds) < 5000 && (d.inMilliseconds) > -5000) {
                setCelebration();
                Get.dialog(
                    WinnerDialogBox(
                      prize: results.first,
                    ),
                    barrierDismissible: false);
              }
              if (isPlaying2.value) {
                player2.stop();
              }
            });
          }
        }
        if (element.no == 3) {
          timerVal3.value = timerVal;
          if (d.inMilliseconds < 0 && !isTimer3.value) {
            isTimer3 = false.obs;
            isTimer3 = true.obs;
            getCurrentResults();
            if (isPlaying2.value) {
              player2.stop();
            }
            if ((d.inMilliseconds) < 5000 && (d.inMilliseconds) > -5000) {
              player2.play(AssetSource("wheel_spin.mp3"));
            }
            try {
              wheelSpinController3.startWheel();
            } catch (e) {}
            Timer(const Duration(seconds: 5), () {
              try {
                wheelSpinController3.stopWheel(2);
              } catch (e) {}

              Iterable<ModelResults> results =
                  currentResultList.where((element) => element.prizeNo == 3);

              if ((d.inMilliseconds) < 5000 && (d.inMilliseconds) > -5000) {
                setCelebration();
                Get.dialog(
                    WinnerDialogBox(
                      prize: results.first,
                    ),
                    barrierDismissible: false);
              }

              isTimer3.value = !isTimer3.value;
              isTimer3.value = !isTimer3.value;
              if (isPlaying2.value) {
                player2.stop();
              }
            });
          }
        }
      }
    });
  }

  Timer timerDialog = Timer(Duration.zero, () {});

  Future<void> addParticipant() async {
    String userId = GetStorage().read("UserId") ?? "";
    if(userId.isNotEmpty){
      isProcessing.value=true;
    }else{

      isProcessing.value=false;
    }
    EasyLoading.show();
    var results = await addParticipantUseCase(NoParams());

    results.fold((failure) => null, (value) {
      getParticipants();

      paymentOptionSelection.value = 0;
    });
    EasyLoading.dismiss();
    String userIdX = GetStorage().read("UserId") ?? "";
    if(userIdX.isNotEmpty){
      isProcessing.value=true;
    }else{

      isProcessing.value=false;
    }
  }

  Future<void> getSliders() async {
    isPageLoaded.value = false;
    pageViewData.clear();
    EasyLoading.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var results = await getSliderUseCase(NoParams());

    results.fold((failure) => null, (value) {
      pageViewData = value;
      if (pageViewData.isNotEmpty) {
        isPageLoaded.value = true;
      }

      print("pageViewData : ${pageViewData.length}");
    });
    EasyLoading.dismiss();
    if (isPageLoaded.value) {
      setType();
    }
  }

  RxBool isParticipantsLoaded = true.obs;
  RxBool isPayed = false.obs;
  RxBool isProcessing = false.obs;
  List<ModelParticipants> participantsData = [];

  Future<void> getParticipants() async {
    print("getParticipants");
    isParticipantsLoaded.value = false;
    participantsData.clear();

    // EasyLoading.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var results = await getParticipantsUseCase(NoParams());

    results.fold((failure) => null, (value) {

      String userId = GetStorage().read("UserId") ?? "";
      participantsData = value;
      if (participantsData.isNotEmpty) {
        isParticipantsLoaded.value = true;
      }
      print("getParticipants : userId : $userId");
      print("getParticipants : participantsData : ${participantsData.length}");

      for (var element in participantsData) {
        print(element.uid);
        print(element.email);
        print(element.phone);
        print(element.imgUrl);
        print("getParticipants  in for : ${element.uid} : $userId");
        if (element.uid == userId) {

          isPayed.value = false;
          isPayed.value = true;
        }
      }

      print("pageViewData : ${pageViewData.length}");
    });
    EasyLoading.dismiss();
  }

  // Future<void> getCurrentUser() async {
  //   String userId = GetStorage().read("UserId") ?? "";
  //   appUser = await sl<MainDatabase>()
  //       .getUser(userId);
  //
  //   print("getCurrentUser : ${appUser!.uid} : ${appUser!.province}");
  //   // print("getCurrentUser : ${appUser!.uid} : ${appUser!.province}");
  //   if (appUser!.province!.trim().isNotEmpty) {
  //     print("isChanged");
  //
  //     selectedProvince.value = appUser!.province!;
  //   }
  //   isUser.value = appUser == null;
  //   isUser.value = appUser != null;
  // }
  Future<void> getCurrentUser(AppUser user) async {

    appUser = user;
    isUser.value = appUser == null;
    isUser.value = appUser != null;
  }

  Future<void> changeStatus() async {
    EasyLoading.show();
    AppUser usr = appUser!.copyWith(status: 2);
    addParticipant();
    // await sl<MainDatabase>().registerUser(usr);
    appUser=usr;
    // await getCurrentUser();
    EasyLoading.dismiss();
    isPayed.value = !isPayed.value;
    isPayed.value = !isPayed.value;
  }

  RxInt paymentOptionSelection = 0.obs;

  ///    Showing Lucky Draw !@#$%^&*()(*&^%$#@!@#$%^&*()!@#$%^&*()(*&^%$#@!
  ///    Photos !@#$%^&*()(*&^%$#@!@#$%^&*()!@#$%^&*()(*&^%$#@!
  RxBool isImagePhoto = false.obs;

  String? filePathPhoto;
  Uint8List? imageFilePhoto;

  File? filePhoto;

  getPicturePhoto(ImageSource img) async {
    final picker = ImagePicker();

    final XFile? pickedImage = await picker.pickImage(
      source: img,
    );
    if (pickedImage != null) {
      filePathPhoto = pickedImage.path;

      filePhoto = File(pickedImage.path);
      imageFilePhoto = await pickedImage.readAsBytes();

      isImagePhoto.value = false;
      isImagePhoto.value = true;
    } else {}
  }

  RxBool isPhotosLoaded = false.obs;
  List<ModelPhotos> photosList = [];

  Future<void> getPhotos() async {
    isPhotosLoaded.value = false;
    photosList.clear();
    EasyLoading.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var results = await getPhotosUseCase(NoParams());

    results.fold((failure) => null, (value) {
      photosList = value;
      if (photosList.isNotEmpty) {
        isPhotosLoaded.value = true;
      }
    });
    EasyLoading.dismiss();
  }

  RxBool isCurrentResultLoaded = false.obs;
  List<ModelResults> currentResultList = [];

  Future<void> getCurrentResults() async {
    isCurrentResultLoaded.value = false;
    EasyLoading.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var results = await getCurrentResultsUseCase(NoParams());

    results.fold((failure) => null, (value) {
      currentResultList = value;
      if (currentResultList.isNotEmpty) {
        isCurrentResultLoaded.value = true;
        isTimer3.value = !isTimer3.value;
        isTimer3.value = !isTimer3.value;
      }
    });

    for (var element in currentResultList) {
      print("XXXXXXXXX : ");
      print(element.name);
      print(element.phone);
      print(element.prizeNo.toString());
    }
    EasyLoading.dismiss();
  }

  Future<void> likeDislike(ModelPhotos photos) async {
    EasyLoading.show();

    String userId = GetStorage().read("UserId") ?? "";
    FocusManager.instance.primaryFocus?.unfocus();
    ModelPhotos photo=photos.copyWith(uid: userId);
    var results = await likeDislikePhotoUseCase(Params(photo));

    results.fold((failure) => print(failure.message), (value) {
      getPhotos();
    });
    EasyLoading.dismiss();
  }

  TextEditingController photoCommentController = TextEditingController();

  Future<void> addComment(ModelPhotos photos) async {
    EasyLoading.show();
    if (photoCommentController.text.trim().isNotEmpty) {
      String id = const Uuid().v1();
      String uid = GetStorage().read("UserId") ?? "";
      ModelPhotoComments comments = ModelPhotoComments(
          id: id,
          uid: uid,
          pid: photos.id,
          comment: photoCommentController.text,
          millis: DateTime.now().millisecondsSinceEpoch,
          status: 0);

      FocusManager.instance.primaryFocus?.unfocus();
      var results = await addPhotoCommentsUseCase(Params(comments));

      results.fold((failure) => print(failure.message), (value) {
        getPhotos();
        getPhotoComment(photos.id!);
        photoCommentController.clear();
      });
    }
    EasyLoading.dismiss();
  }

  RxBool isPhotoCommentsLoaded = false.obs;
  List<ModelPhotoComments> photoCommentList = [];

  Future<void> getPhotoComment(String pid) async {
    EasyLoading.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var results = await getPhotoCommentsUseCase(Params(pid));

    results.fold((failure) => null, (value) {
      photoCommentList = value;
      if (photoCommentList.isNotEmpty) {
        isPhotoCommentsLoaded.value = false;
        isPhotoCommentsLoaded.value = true;
      }
    });
    EasyLoading.dismiss();
  }

  ///    Photos !@#$%^&*()(*&^%$#@!@#$%^&*()!@#$%^&*()(*&^%$#@!
  ///  Spinner !@#$%^&*()(*&^%$#@!@#$%^&*()!@#$%^&*()(*&^%$#@!

  WheelSpinController wheelSpinController1 = WheelSpinController();
  WheelSpinController wheelSpinController2 = WheelSpinController();
  WheelSpinController wheelSpinController3 = WheelSpinController();


  ///  Spinner !@#$%^&*()(*&^%$#@!@#$%^&*()!@#$%^&*()(*&^%$#@!
  ///  WhatsApp & Telegram !@#$%^&*()(*&^%$#@!@#$%^&*()!@#$%^&*()(*&^%$#@!
  callWhatsApp() async {
    var contact = "+923039208843";
    var androidUrl =
        "whatsapp://send?phone=$contact&text=Hi, I'm interested in services you provide.";
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

  callTelegram() async {
    var contact = "+923039208843";
    var androidUrl = "https://t.me/$contact";
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

  ///  WhatsApp & Telegram !@#$%^&*()(*&^%$#@!@#$%^&*()!@#$%^&*()(*&^%$#@!
  ///  Profile Picture !@#$%^&*()(*&^%$#@!@#$%^&*()!@#$%^&*()(*&^%$#@!
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
      EasyLoading.show();
      filePath = pickedImage.path;

      file = File(pickedImage.path);
      imageFile = await pickedImage.readAsBytes();

      String imgUrl = filePath!;
      AppUser user = appUser!.copyWith(profilePicture: imgUrl,file: file);
      // AppUser user = appUser!.copyWith(imgUrl: imgUrl);
      await sl<MainDatabase>().updateUser(user);
      appUser = user;
      isImage.value = false;
      isImage.value = true;
      EasyLoading.showSuccess("Success");
      EasyLoading.dismiss();
    } else {}
    Get.back();
  }

  tryAvatar() async {
    EasyLoading.show();
    AppUser user = appUser!.copyWith(profilePicture: "");
    // AppUser user = appUser!.copyWith(imgUrl: "");
    await sl<MainDatabase>().registerUser(user);
    appUser = user;
    isImage.value = true;
    isImage.value = false;
    EasyLoading.showSuccess("Success");
    EasyLoading.dismiss();

    Get.back();
  }



  ///  Profile Picture !@#$%^&*()(*&^%$#@!@#$%^&*()!@#$%^&*()(*&^%$#@!
  ///  Pay !@#$%^&*()(*&^%$#@!@#$%^&*()!@#$%^&*()(*&^%$#@!

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneNumber =TextEditingController();
  Future<void> callingPayApi(BuildContext context) async {
    // if (formKey.currentState!.validate()) {
    EasyLoading.show();
  // String res =  await   sl<AdminMainDatabase>().getPayCustomAuth();

  //   print("in Result Controller $res");
  // if(res.toString() == 'Authorized'){
  //
  //   print("in Result Controller Order $resPay");
  //   if (resPay.toString() == "00"){
  //     addParticipant();
  //   }
  // }
      // Navigator.pop(context);
      String orderId =  "Test-${DateTime.now().millisecondsSinceEpoch}";
      String resPay =  await   sl<AdminMainDatabase>().getPayCustomOrder(orderId);



    EasyLoading.dismiss();
          paymentOptionSelection.value = 0;
      phoneNumber.clear();


  }
  ///  Bank !@#$%^&*()(*&^%$#@!@#$%^&*()!@#$%^&*()(*&^%$#@!
  RxString cardNumber="".obs;
  RxString expiryDate="".obs;
  RxString cardHolderName="".obs;
  RxString cvvCode="".obs;
  RxBool isCvvFocused=false.obs;
  final GlobalKey<FormState> bankFormKey = GlobalKey<FormState>();
  void onCreditCardModelChange(CreditCardModel creditCardModel) {

      cardNumber.value = creditCardModel.cardNumber;
      expiryDate.value= creditCardModel.expiryDate;
      cardHolderName.value = creditCardModel.cardHolderName;
      cvvCode.value = creditCardModel.cvvCode;
      isCvvFocused.value = creditCardModel.isCvvFocused;
      if (bankFormKey.currentState?.validate() ?? false) {
        print('valid!');
      } else {
        print('invalid!');
      }
  }

  submitBank(BuildContext context){
    if (bankFormKey.currentState?.validate() ?? false) {
      sl<AdminMainDatabase>().getPayAuth();
    }else {
      CustomSnakeBars.snakeBanner(
          context, 'Failed', 'Please Enter All Fields', 'failure');
    }
  }


///  Pay !@#$%^&*()(*&^%$#@!@#$%^&*()!@#$%^&*()(*&^%$#@!
///

  Future<void> insertRequestController(BuildContext context,String screenShotUrl) async {
    final connectivityResult = await (Connectivity().checkConnectivity());


    if (connectivityResult == ConnectivityResult.none) {
      print('check your connection');
    } else {
      EasyLoading.show();
      RequestModel itemModel = RequestModel(
          name: appUser!.name,
        phoneNumber: appUser!.contact,
        date: DateTime.now().millisecondsSinceEpoch,
        screenShotUrl: screenShotUrl,
        userUid: appUser!.uid
      );
      var results = await insertNewRequestUseCase(Params(itemModel));
      results.fold((e) {
        CustomSnakeBars.snakeBanner(context, 'Sorry', e.message, 'failure');
        print('the error in insertRequestController is //////${e.message}');

        EasyLoading.dismiss();
      }, (b) {
        CustomSnakeBars.snakeBanner(
            context, 'Hello', 'Request Has been added', 'success');
        EasyLoading.dismiss();
      });
    }
  }



}
