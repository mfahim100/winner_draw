
import 'package:get_it/get_it.dart';
import 'package:winner_draw/feature/auth/domain/use_cases/forget_use_case.dart';
import 'package:winner_draw/feature/auth/domain/use_cases/login_user_use_case.dart';

import '../../feature/admin/main_admin/data/data_sources/admin_database_impl.dart';
import '../../feature/admin/main_admin/data/data_sources/admin_database_main.dart';
import '../../feature/admin/main_admin/data/repositories/admin_repository_implementation.dart';
import '../../feature/admin/main_admin/domain/repositories/admin_repository.dart';
import '../../feature/admin/main_admin/domain/use_cases/add_lucky_draw_use_case.dart';
import '../../feature/admin/main_admin/domain/use_cases/add_participant_use_case.dart';
import '../../feature/admin/main_admin/domain/use_cases/add_photo_comment_use_case.dart';
import '../../feature/admin/main_admin/domain/use_cases/add_photo_use_case.dart';
import '../../feature/admin/main_admin/domain/use_cases/clear_all_use_case.dart';
import '../../feature/admin/main_admin/domain/use_cases/complete_draw_use_case.dart';
import '../../feature/admin/main_admin/domain/use_cases/delete_participant_use_case.dart';
import '../../feature/admin/main_admin/domain/use_cases/delete_photo_use_case.dart';
import '../../feature/admin/main_admin/domain/use_cases/get_current_lucky_draw_use_case.dart';
import '../../feature/admin/main_admin/domain/use_cases/get_current_results_use_case.dart';
import '../../feature/admin/main_admin/domain/use_cases/get_firebase_request_usecase.dart';
import '../../feature/admin/main_admin/domain/use_cases/get_participants_use_case.dart';
import '../../feature/admin/main_admin/domain/use_cases/get_photo_comments_use_case.dart';
import '../../feature/admin/main_admin/domain/use_cases/get_photos_use_case.dart';
import '../../feature/admin/main_admin/domain/use_cases/get_request_use_case.dart';
import '../../feature/admin/main_admin/domain/use_cases/get_results_use_case.dart';
import '../../feature/admin/main_admin/domain/use_cases/get_slider_use_case.dart';
import '../../feature/admin/main_admin/domain/use_cases/insert_new_request.dart';
import '../../feature/admin/main_admin/domain/use_cases/like_dislike_photo_use_case.dart';
import '../../feature/admin/main_admin/domain/use_cases/update_lucky_draw_use_case.dart';
import '../../feature/admin/main_admin/presentation/manager/main_nav_admin_controller.dart';
import '../../feature/auth/data/data_sources/database_impl.dart';
import '../../feature/auth/data/data_sources/database_main.dart';
import '../../feature/auth/data/repositories/auth_repository_implementation.dart';
import '../../feature/auth/domain/repositories/auth_repository.dart';
import '../../feature/auth/domain/use_cases/change_password_use_case.dart';
import '../../feature/auth/domain/use_cases/get_all_user_use_case.dart';
import '../../feature/auth/domain/use_cases/get_user_use_case.dart';
import '../../feature/auth/domain/use_cases/logout_use_case.dart';
import '../../feature/auth/domain/use_cases/pass_otp_use_case.dart';
import '../../feature/auth/domain/use_cases/register_user_use_case.dart';
import '../../feature/auth/domain/use_cases/resend_otp_use_case.dart';
import '../../feature/auth/domain/use_cases/update_user_use_case.dart';
import '../../feature/auth/domain/use_cases/verify_otp_use_case.dart';
import '../../feature/auth/presentation/manager/auth_controller.dart';
import '../../feature/auth/presentation/manager/splash_controller.dart';
import '../../feature/client/main_client/presentation/manager/main_nav_client_controller.dart';
import '../controllers/theme_controller.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Controller
  sl.registerLazySingleton(() => ThemeController());
  sl.registerLazySingleton(() => MainNavClientController(
      getPhotosUseCase: sl(),
      getCurrentLuckyDrawUseCase: sl(),
      getSliderUseCase: sl(),
      getParticipantsUseCase: sl(),
      addParticipantUseCase: sl(),
      likeDislikePhotoUseCase: sl(),
      getPhotoCommentsUseCase: sl(),
      addPhotoCommentsUseCase: sl(),
      getCurrentResultsUseCase: sl(),
      insertNewRequestUseCase: sl()));
  sl.registerLazySingleton(() => MainNavAdminController(
      addLuckyDrawUseCase: sl(),
      getCurrentLuckyDrawUseCase: sl(),
      getPhotosUseCase: sl(),
      clearAllUseCase: sl(),
      addPhotoUseCase: sl(),
      deletePhotoUseCase: sl(),
      getPhotoCommentsUseCase: sl(),
      addPhotoCommentsUseCase: sl(),
      getResultsUseCase: sl(),
      addParticipantUseCase: sl(),
      getRequestUseCase: sl(),
      deleteParticipantUseCase: sl(),
      completeDrawUseCase: sl(), updateLuckyDrawUseCase: sl(),
      getFirebaseRequestUseCase: sl()));
  sl.registerLazySingleton(() => AuthController(
      registerUserUseCase: sl(),
      loginUserUseCase: sl(),
      logoutUseCase: sl(),
      getAllUserUseCase: sl(),
      forgetUseCase: sl(),
      reSendOtpUseCase: sl(),
      changePasswordUseCase: sl(), updateUserUseCase: sl(), verifyOtpUseCase: sl(), passOtpUseCase: sl()));
  sl.registerLazySingleton(() => SplashController(getUserUseCase: sl()));

  //! USE CASES
  sl.registerLazySingleton(() => ForgetUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetRequestUseCase(repository: sl()));
  sl.registerLazySingleton(() => RegisterUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => LoginUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAllUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddPhotoUseCase(repository: sl()));
  sl.registerLazySingleton(() => LikeDislikePhotoUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetPhotoCommentsUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddPhotoCommentsUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeletePhotoUseCase(repository: sl()));
  sl.registerLazySingleton(() => ReSendOtpUseCase(repository: sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => PassOtpUseCase(repository: sl()));

  sl.registerLazySingleton(() => AddLuckyDrawUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCurrentLuckyDrawUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetPhotosUseCase(repository: sl()));
  sl.registerLazySingleton(() => ClearAllUseCase(repository: sl()));
  sl.registerLazySingleton(() => CompleteDrawUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetSliderUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetParticipantsUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddParticipantUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetResultsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCurrentResultsUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteParticipantUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateLuckyDrawUseCase(repository: sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(repository: sl()));
  sl.registerLazySingleton(() => InsertNewRequestUseCase(adminRepository: sl()));
  sl.registerLazySingleton(() => GetFirebaseRequestUseCase(adminRepository: sl()));

  //! REPOSITORIES
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDatabase: sl()),
  );
  sl.registerLazySingleton<AdminRepository>(
    () => AdminRepositoryImpl(remoteDatabase: sl()),
  );

  //! DATA SOURCES
  sl.registerLazySingleton<MainDatabase>(() => DatabaseImpl());
  sl.registerLazySingleton<AdminMainDatabase>(() => AdminDatabaseImpl(),
  );
  //! CORE

  //! EXTERNAL
  // sl.registerLazySingleton(() => Dio());
  // final sharedPref = await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPref);

  //! Initial Functions
  sl<SplashController>().mainOrAuth();
  sl<AuthController>().getAllUsers();
  sl<MainNavAdminController>().loadData();
  sl<MainNavClientController>().loadData();
  sl<AdminMainDatabase>().callOrders();
}
