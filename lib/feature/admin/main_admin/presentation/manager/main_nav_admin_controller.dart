import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../../core/utils/use_case.dart';
import '../../../../../core/widgets/snake_bars.dart';
import '../../../../auth/data/data_sources/database_main.dart';
import '../../../../auth/domain/entities/app_user.dart';
import '../../domain/entities/model_photos.dart';
import '../../domain/entities/model_photos_comment.dart';
import '../../domain/entities/model_prize.dart';
import '../../domain/entities/model_results.dart';
import '../../domain/entities/request_model.dart';
import '../../domain/use_cases/add_lucky_draw_use_case.dart';
import '../../domain/use_cases/add_participant_use_case.dart';
import '../../domain/use_cases/add_photo_comment_use_case.dart';
import '../../domain/use_cases/add_photo_use_case.dart';
import '../../domain/use_cases/clear_all_use_case.dart';
import '../../domain/use_cases/complete_draw_use_case.dart';
import '../../domain/use_cases/delete_participant_use_case.dart';
import '../../domain/use_cases/delete_photo_use_case.dart';
import '../../domain/use_cases/get_current_lucky_draw_use_case.dart';
import '../../domain/use_cases/get_firebase_request_usecase.dart';
import '../../domain/use_cases/get_photo_comments_use_case.dart';
import '../../domain/use_cases/get_photos_use_case.dart';
import '../../domain/use_cases/get_request_use_case.dart';
import '../../domain/use_cases/get_results_use_case.dart';
import '../../domain/use_cases/update_lucky_draw_use_case.dart';
import '../widgets/dialogbox_show_results.dart';

class MainNavAdminController extends GetxController {
  final AddLuckyDrawUseCase addLuckyDrawUseCase;
  final AddPhotoUseCase addPhotoUseCase;
  final UpdateLuckyDrawUseCase updateLuckyDrawUseCase;
  // final UploadPhotoUseCase uploadPhotoUseCase;
  final GetCurrentLuckyDrawUseCase getCurrentLuckyDrawUseCase;
  final GetPhotosUseCase getPhotosUseCase;
  final ClearAllUseCase clearAllUseCase;
  final CompleteDrawUseCase completeDrawUseCase;
  final DeletePhotoUseCase deletePhotoUseCase;
  final GetPhotoCommentsUseCase getPhotoCommentsUseCase;
  final AddPhotoCommentsUseCase addPhotoCommentsUseCase;
  final GetResultsUseCase getResultsUseCase;
  final AddParticipantUseCase addParticipantUseCase;
  final GetRequestUseCase getRequestUseCase;
  final DeleteParticipantUseCase deleteParticipantUseCase;
  final GetFirebaseRequestUseCase getFirebaseRequestUseCase;

  RxInt selectedTab = 0.obs;
  RxInt selectedTabIndex = 0.obs;

  loadData() {
    getCurrentLuckyDraw();
    getRequests();
    getPhotos();
    getResults();
    getAllRequestController();
  }

  MainNavAdminController(
      {required this.completeDrawUseCase,
      required this.deleteParticipantUseCase,
      required this.updateLuckyDrawUseCase,
      required this.getRequestUseCase,
      required this.addParticipantUseCase,
      required this.getResultsUseCase,
      required this.addPhotoCommentsUseCase,
      required this.getPhotoCommentsUseCase,
      required this.deletePhotoUseCase,
      required this.addPhotoUseCase,
      required this.clearAllUseCase,
      required this.getPhotosUseCase,
      // required this.uploadPhotoUseCase,
      required this.getCurrentLuckyDrawUseCase,
      required this.addLuckyDrawUseCase,
      required this.getFirebaseRequestUseCase

      });

  setSelectedTab(int val) {
    selectedTab.value = val;
    setSelectedTabIndex(val);
  }

  setSelectedTabIndex(int val) {
    selectedTabIndex.value = val;
    // if (val == 2) {
    //   getRequests();
    // }
  }

  List<String> bottomTitle = [
    "Draw",
    "Results",
    "Requests",
    'Photos',
    'Logout',
  ];
  List<IconData> bottomIcon = [
    Icons.star,
    Icons.draw,
    Icons.request_page,
    Icons.post_add,
    Icons.logout,
  ];

  Future<void> addParticipant(AppUser user) async {
    EasyLoading.show();
    var results = await addParticipantUseCase(NoParams());

    results.fold((failure) => null, (value) {
      AppUser usr = user.copyWith(status: 2);
      sl<MainDatabase>().registerUser(usr);
      getRequests();
    });
    EasyLoading.dismiss();
  }

  Future<void> decline(AppUser user) async {
    EasyLoading.show();
    AppUser usr = user.copyWith(status: 0);
    sl<MainDatabase>().registerUser(usr);
    var results = await deleteParticipantUseCase(Params(user.uid));
    // var results = await deleteParticipantUseCase(Params(user.uid));

    results.fold((failure) => null, (value) {
      getRequests();
    });
    EasyLoading.dismiss();
  }

  ///    Adding Lucky Draw !@#$%^&*()(*&^%$#@!@#$%^&*()!@#$%^&*()(*&^%$#@!
  RxBool isCurrentLuckyDraw = false.obs;
  RxBool isAddingLuckyDraw = false.obs;
  List<ModelPrize> mainList = [];

  getCurrentLuckyDraw() async {
    isCurrentLuckyDraw.value = false;
    mainList.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    var results = await getCurrentLuckyDrawUseCase(NoParams());

    results.fold((failure) => null, (value) {
      mainList = value;
      if (mainList.isNotEmpty) {
        isCurrentLuckyDraw.value = true;
        timerValues();
      }
    });
  }

  RxInt activeStep = 0.obs;
  RxInt upperBound = 3.obs;

  List<Icon> icons = const [
    Icon(Icons.looks_one_rounded),
    Icon(Icons.looks_two_rounded),
    Icon(Icons.flag),
  ];

  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController timerController = TextEditingController();
  Rx<DateTime> timer = DateTime.now().obs;

  changeTimer(DateTime val, BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
    );
    if (picked != null) {
      timer.value =
          DateTime(val.year, val.month, val.day, picked.hour, picked.minute);
    }
    timerController.text =
        "${timer.value.day}/${timer.value.month}/${timer.value.year} ${timer.value.hour}:${timer.value.minute}";
    formKey.currentState!.validate();

    Get.back();
  }

  File? file;
  File? file1;
  File? file2;
  File? file3;

  String filePath1 = '';
  String filePath2 = '';
  String filePath3 = '';

  String title1 = '';
  String title2 = '';
  String title3 = '';

  String price1 = '';
  String price2 = '';
  String price3 = '';

  String desc1 = '';
  String desc2 = '';
  String desc3 = '';

  DateTime timer1 = DateTime.now();
  DateTime timer2 = DateTime.now();
  DateTime timer3 = DateTime.now();

  void clearAllAdding() {
    titleController.clear();
    priceController.clear();
    descController.clear();
    timerController.clear();
    timer.value = DateTime.now();
    file = null;
    isImage.value = false;
  }

  RxBool editImageFromDatabase = false.obs;
  RxString editImageFromDatabaseUrl = ''.obs;

  editPrize(ModelPrize prize) {
    file = null;
    isImage.value = false;
    editImageFromDatabase.value = prize.imgUrl!.isNotEmpty;
    if (editImageFromDatabase.value) {
      editImageFromDatabaseUrl.value = prize.imgUrl!;
    }
    titleController.text = prize.title!;
    priceController.text = prize.price!.toString();
    descController.text = prize.description!;
    timer.value = DateTime.fromMillisecondsSinceEpoch(prize.timer!);

    timerController.text =
        "${timer.value.day}/${timer.value.month}/${timer.value.year} ${timer.value.hour}:${timer.value.minute}";
  }

  editPrizeButton(BuildContext context, ModelPrize prize) async {
    if (formKey.currentState!.validate()) {
      String imgUrl = prize.imgUrl!;
      if (isImage.value) {
        imgUrl = filePath!;
      }

      ModelPrize p = prize.copyWith(
        file: file,
          title: titleController.text,
          price: int.parse(priceController.text),
          description: descController.text,
          timer: timer.value.millisecondsSinceEpoch,
          imgUrl: imgUrl);

      var results = await updateLuckyDrawUseCase(Params(p));

      results.fold(
          (failure) => CustomSnakeBars.snakeBanner(
              context, 'Failed', 'Edit Lucky Draw Failed', 'failure'), (value) {
        getCurrentLuckyDraw();
        Get.back();
      });
    }
  }

  savePrizeButton(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (isImage.value) {
        savePrize();
        if (activeStep.value == 0) {
          activeStep.value = 1;

          clearAllAdding();
        } else if (activeStep.value == 1) {
          activeStep.value = 2;

          clearAllAdding();
        } else {
          timerValuesFromDialogBox();
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return ShowResultsDialogBox();
              });
        }
      } else {
        CustomSnakeBars.snakeBanner(
            context, 'Failed', 'Please Add Image', 'failure');
      }
    } else {
      CustomSnakeBars.snakeBanner(
          context, 'Failed', 'Please Validate All Fields', 'failure');
    }
  }

  savePrize() {
    if (activeStep.value == 0) {
      file1 = file;
      filePath1 = filePath!;
      title1 = titleController.text;
      price1 = priceController.text;
      desc1 = descController.text;
      timer1 = timer.value;
    } else if (activeStep.value == 1) {
      file2 = file;
      filePath2 = filePath!;
      title2 = titleController.text;
      price2 = priceController.text;
      desc2 = descController.text;
      timer2 = timer.value;
    } else {
      file3 = file;
      filePath3 = filePath!;
      title3 = titleController.text;
      price3 = priceController.text;
      desc3 = descController.text;
      timer3 = timer.value;
    }
  }

  RxBool isImage = false.obs;

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

      isImage.value = false;
      isImage.value = true;

      editImageFromDatabase.value = false;
    } else {}
    Get.back();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validateTitleField(String? text) {
    if (text == null || text.isEmpty) {
      return 'Title is empty';
    } else if (text.length < 6) {
      return 'Title must be more then 5 alphabets';
    }
    return null;
  }

  String? validatePriceField(String? text) {
    if (text == null || text.isEmpty) {
      return 'Price is empty';
    }
    return null;
  }

  String? validateDescField(String? text) {
    if (text == null || text.isEmpty) {
      return 'Description is empty';
    } else if (text.length < 6) {
      return 'Description must be more then 5 alphabets';
    }
    return null;
  }

  String? validateDateField(String? text) {
    if (text == null || text.isEmpty) {
      return 'Date is empty';
    }
    return null;
  }

  saveAllPricesToDataBase(BuildContext context) async {
    EasyLoading.show();
    String id1 = "First";
    String imgUrl1 = filePath1;
    String id2 = "Second";
    String imgUrl2 = filePath2;
    String id3 = "Third";
    String imgUrl3 = filePath3;


    String uid = GetStorage().read("UserId") ?? "";
    ModelPrize prize1 = ModelPrize(
      no: 1,
      id: id1,
      uid: uid,
      title: title1,
      price: int.parse(price1),
      description: desc1,
      timer: timer1.millisecondsSinceEpoch,
      imgUrl: imgUrl1,
      status: 0,
      file: file1,
    );
    ModelPrize prize2 = ModelPrize(
      no: 2,
      id: id2,
      uid: uid,
      title: title2,
      price: int.parse(price2),
      description: desc2,
      timer: timer2.millisecondsSinceEpoch,
      imgUrl: imgUrl2,
      status: 0,
      file: file2,
    );
    ModelPrize prize3 = ModelPrize(
      no: 3,
      id: id3,
      uid: uid,
      title: title3,
      price: int.parse(price3),
      description: desc3,
      timer: timer3.millisecondsSinceEpoch,
      imgUrl: imgUrl3,
      status: 0,
      file: file3,
    );
    var results1 = await addLuckyDrawUseCase(Params(prize1));

    results1.fold(
        (failure) => CustomSnakeBars.snakeBanner(
            context, 'Failed', 'First Lucky Draw Failed', 'failure'),
        (value) async {
      var results2 = await addLuckyDrawUseCase(Params(prize2));

      results2.fold(
          (failure) => CustomSnakeBars.snakeBanner(
              context, 'Failed', 'Second Lucky Draw Failed', 'failure'),
          (value) async {
        var results3 = await addLuckyDrawUseCase(Params(prize3));

        results3.fold(
            (failure) => CustomSnakeBars.snakeBanner(
                context, 'Failed', 'Third Lucky Draw Failed', 'failure'),
            (value) {
          getCurrentLuckyDraw();
          Get.back();
        });
      });
    });

    if (timerDialog.isActive) {
      timerDialog.cancel();
    }
    EasyLoading.dismiss();
  }

  cancelSaving() {
    if (timerDialog.isActive) {
      timerDialog.cancel();
    }
    Get.back();
  }

  setActiveStep(int index) {
    activeStep.value = index;
    isImage.value = false;
    if (activeStep.value == 0) {
      file = file1;
      titleController.text = title1;
      priceController.text = price1;
      descController.text = desc1;
      timer.value = timer1;
    } else if (activeStep.value == 1) {
      file = file2;
      titleController.text = title2;
      priceController.text = price2;
      descController.text = desc2;
      timer.value = timer2;
    } else {
      file = file3;
      titleController.text = title3;
      priceController.text = price3;
      descController.text = desc3;
      timer.value = timer3;
    }

    isImage.value = file != null;
  }

  ///    Adding Lucky Draw !@#$%^&*()(*&^%$#@!@#$%^&*()!@#$%^&*()(*&^%$#@!
  ///    Showing Lucky Draw !@#$%^&*()(*&^%$#@!@#$%^&*()!@#$%^&*()(*&^%$#@!
  RxString timerVal1 = '00:00'.obs;
  RxString timerVal2 = '00:00'.obs;
  RxString timerVal3 = '00:00'.obs;

  timerValues() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      for (var element in mainList) {
        DateTime given = DateTime.fromMillisecondsSinceEpoch(element.timer!);

        DateTime timeNow = DateTime.now().subtract(const Duration(minutes: 5));
        Duration d = given.difference(timeNow);

        // print("Given : ${given.hour}:${given.minute}:${given.second}");
        // print("Now :  ${timeNow.hour}:${timeNow.minute}:${timeNow.second}");

        String dur = d.toString().substring(0, 8);
        String timerVal = d.inMilliseconds > 0 ? dur : "00:00:00";

        if (element.no == 1) {
          timerVal1.value = timerVal;
        }
        if (element.no == 2) {
          timerVal2.value = timerVal;
        }
        if (element.no == 3) {
          timerVal3.value = timerVal;
        }
      }
    });
  }

  Timer timerDialog = Timer(Duration.zero, () {});

  timerValuesFromDialogBox() {
    timerDialog = Timer.periodic(const Duration(seconds: 1), (timer) {
      DateTime given1 = timer1;
      DateTime given2 = timer2;
      DateTime given3 = timer3;

      DateTime timeNow = DateTime.now();
      Duration d1 = given1.difference(timeNow);
      Duration d2 = given2.difference(timeNow);
      Duration d3 = given3.difference(timeNow);

      double min1 = d1.inMinutes % 60;
      double min2 = d2.inMinutes % 60;
      double min3 = d3.inMinutes % 60;
      double sec1 = d1.inSeconds % 60;
      double sec2 = d3.inSeconds % 60;
      double sec3 = d3.inSeconds % 60;

      timerVal1.value =
          "${d1.inHours}:${min1.round() < 10 ? "0" : ""}${min1.round()}:${sec1.round() < 10 ? "0" : ""}${sec1.round()}";
      timerVal2.value =
          "${d2.inHours}:${min2.round() < 10 ? "0" : ""}${min2.round()}:${sec2.round() < 10 ? "0" : ""}${sec2.round()}";
      timerVal3.value =
          "${d3.inHours}:${min3.round() < 10 ? "0" : ""}${min3.round()}:${sec3.round() < 10 ? "0" : ""}${sec3.round()}";
    });
  }

  ///    Showing Lucky Draw !@#$%^&*()(*&^%$#@!@#$%^&*()!@#$%^&*()(*&^%$#@!
  ///    Photos !@#$%^&*()(*&^%$#@!@#$%^&*()!@#$%^&*()(*&^%$#@!

  TextEditingController photoDescController = TextEditingController();

  RxBool isImagePhoto = false.obs;

  String? filePathPhoto;
  Uint8List? imageFilePhoto;

  File? filePhoto;

  RxBool isPhotoDate = false.obs;
  DateTime photoDateTime = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: photoDateTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != photoDateTime) {
      photoDateTime = picked;
      isPhotoDate.value = false;
      isPhotoDate.value = true;
    }
  }

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

  savePhoto(BuildContext context) async {
    EasyLoading.show();
    //
    // var results = await uploadPhotoUseCase(Params(filePhoto));
    //
    // results.fold(
    //     (failure) => CustomSnakeBars.snakeBanner(
    //         context, 'Failed', 'Uploading Photo Failed', 'failure'),
    //     (value) async {

    print("filePathPhoto");
    print(filePathPhoto);
    print("filePath");
    print(filePath);
      ModelPhotos photos = ModelPhotos(
        file: filePhoto,
        imgUrl: filePathPhoto,
          description: photoDescController.text,
          millis: photoDateTime.millisecondsSinceEpoch.toString());
      var results = await addPhotoUseCase(Params(photos));

      results.fold(
          (failure) => CustomSnakeBars.snakeBanner(
              context, 'Failed', 'Adding Photo Failed', 'failure'), (value) {
        getPhotos();
      });
    // });
    Navigator.pop(context);
    EasyLoading.dismiss();
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

  RxBool isResultLoaded = false.obs;
  List<List<ModelResults>> resultList = [];
  RxList<dynamic> resultsDates = [].obs;

  Future<void> getResults() async {
    isResultLoaded.value = false;
    List<dynamic> resultsDts = [];
    resultList.clear();
    resultsDates.clear();
    EasyLoading.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var results = await getResultsUseCase(NoParams());

    results.fold((failure) => null, (value) {
      resultList = value;
      print("MMMMMMMM");
      print(resultList.length);

      if (resultList.isNotEmpty) {
        int i = 0;
        for (var element in resultList) {
          DateTime d = DateTime.fromMillisecondsSinceEpoch(element[0].timer!);
          String date = "${d.day}/${d.month}/${d.year}";
          resultsDts.add({i: date});
          i++;
        }

        for (var element in resultsDts.reversed) {
          resultsDates.add(element);
        }
      }
      print("ZXC___");
      print(resultsDates.length);
      resultsDates.forEach((action){print(action.toString());});
      isResultLoaded.value = true;
    });
    EasyLoading.dismiss();
  }

  RxBool isRequestLoaded = false.obs;
  List<AppUser> requestList = [];

  Future<void> getRequests() async {
    isRequestLoaded.value = false;
    EasyLoading.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var results = await getRequestUseCase(NoParams());

    results.fold((failure) => null, (value) {
      requestList.clear();
      requestList = value;

      if (requestList.isNotEmpty) {
        isRequestLoaded.value = true;
      }
      print("ZXC___requestList");
      print(requestList.length);
    });
    EasyLoading.dismiss();
  }

  Future<void> completeDraw(BuildContext context) async {
    EasyLoading.show();
    var results = await completeDrawUseCase(NoParams());
    results.fold(
        (failure) => CustomSnakeBars.snakeBanner(
            context, 'Failed', 'Clearing Failed', 'failure'), (value) {
      EasyLoading.showSuccess("Draw Completed");
      loadData();
    });
    EasyLoading.dismiss();
  }

  Future<void> clearAll(BuildContext context) async {
    // EasyLoading.show();
    var results = await clearAllUseCase(NoParams());

    isCurrentLuckyDraw.value = false;
    isAddingLuckyDraw.value = false;
    results.fold(
        (failure) => CustomSnakeBars.snakeBanner(
            context, 'Failed', 'Clearing Failed', 'failure'), (value) {
      loadData();
    });
    EasyLoading.dismiss();
  }

  Future<void> deletePhoto(BuildContext context, ModelPhotos photos) async {
    EasyLoading.show();

    var results = await deletePhotoUseCase(Params(photos));

    results.fold(
        (failure) => CustomSnakeBars.snakeBanner(
            context, 'Failed', 'Deleting Photo Failed', 'failure'),
        (value) async {
      getPhotos();
    });
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

  ///    Photos !@#$%^&*()(*&^%$#@!@#$%^&*()!@#$%^&*()(*&^%$#@!
///




  RxBool isRequestLoading = false.obs;
  List<RequestModel> getAllRequest = [];

  Future<void> getAllRequestController() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    getAllRequest.clear();

    if (connectivityResult == ConnectivityResult.none) {
      print('check your connection');
    }
    else {
      var results = await getFirebaseRequestUseCase(Params('uid'));
      results.fold((e) {
        // CustomSnakeBars.snakeBanner(context, 'Sorry', e.message, 'failure');
        print('the error in getAllRequestController() is //////${e.message}');
      }, (b) {
        getAllRequest = b;
        print(getAllRequest);
        isRequestLoading.value = true;
        isRequestLoading.value = false;
      });
    }
  }






}
