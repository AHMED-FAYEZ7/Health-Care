// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:health_care/authentication/data/data_source/doctor/doctor_auth_remote_data_source.dart';
import 'package:health_care/authentication/data/data_source/patient/patient_auth_remote_data_source.dart';
import 'package:health_care/authentication/data/data_source/user/user_data_source.dart';
import 'package:health_care/authentication/data/network/doctor_auth_api/doctor_auth_api.dart';
import 'package:health_care/authentication/data/network/patient_auth_api/patient_auth_api.dart';
import 'package:health_care/authentication/data/network/user_api/user_api.dart';
import 'package:health_care/authentication/data/repository/doctor_auth_repository_impl.dart';
import 'package:health_care/authentication/data/repository/patient_repository_impl.dart';
import 'package:health_care/authentication/data/repository/user_repository_impl.dart';
import 'package:health_care/authentication/domain/repository/doctor_auth_repository.dart';
import 'package:health_care/authentication/domain/repository/patient_auth_repository.dart';
import 'package:health_care/authentication/domain/repository/user_repository.dart';
import 'package:health_care/authentication/domain/usecase/doctor_sinup_usecase.dart';
import 'package:health_care/authentication/domain/usecase/patient_signup_usecase.dart';
import 'package:health_care/authentication/domain/usecase/user_delete_me_usecse.dart';
import 'package:health_care/authentication/domain/usecase/user_email_confirmation_usecase.dart';
import 'package:health_care/authentication/domain/usecase/user_forget_password_usecase.dart';
import 'package:health_care/authentication/domain/usecase/user_login_usecase.dart';
import 'package:health_care/authentication/domain/usecase/user_update_info_usecase.dart';
import 'package:health_care/authentication/domain/usecase/user_update_password_usecase.dart';
import 'package:health_care/authentication/presentation/controller/auth_cubit.dart';
import 'package:health_care/chat/data/data_source/chat_remote_data_source.dart';
import 'package:health_care/chat/data/network/doctor_api/chat_api.dart';
import 'package:health_care/chat/data/repository/chat_repo_impl.dart';
import 'package:health_care/chat/domain/repository/chat_repository.dart';
import 'package:health_care/chat/domain/usecase/get_all_messages_use_case.dart';
import 'package:health_care/chat/domain/usecase/get_messages_use_case.dart';
import 'package:health_care/chat/domain/usecase/get_stream_messages_use_case.dart';
import 'package:health_care/chat/domain/usecase/user_create_chat_use_case.dart';
import 'package:health_care/chat/domain/usecase/user_send_message_use_case.dart';
import 'package:health_care/chat/presentation/controller/chat_cubit.dart';
import 'package:health_care/doctor/data/data_source/doctor_remote_data_source.dart';
import 'package:health_care/doctor/data/network/doctor_api/doctor_api.dart';
import 'package:health_care/doctor/data/repository/doctor_repo_impl.dart';
import 'package:health_care/doctor/domain/repository/doctor_repo.dart';
import 'package:health_care/doctor/domain/usecase/create_blog_use_case.dart';
import 'package:health_care/doctor/domain/usecase/create_comment_use_case.dart';
import 'package:health_care/doctor/domain/usecase/create_dislike_use_case.dart';
import 'package:health_care/doctor/domain/usecase/create_like_use_case.dart';
import 'package:health_care/doctor/domain/usecase/create_time_block_use_case.dart';
import 'package:health_care/doctor/domain/usecase/get_blogs_comments_use_case.dart';
import 'package:health_care/doctor/domain/usecase/get_blogs_likes_use_case.dart';
import 'package:health_care/doctor/domain/usecase/get_doctor_blogs_by_id.dart';
import 'package:health_care/doctor/domain/usecase/is_patient_examined_use_case.dart';
import 'package:health_care/doctor/presentation/controller/doctor_cubit/doctor_cubit.dart';
import 'package:health_care/doctor/domain/usecase/get_all_blogs_use_case.dart';
import 'package:health_care/patient/data/data_source/patient_remote_data_source.dart';
import 'package:health_care/patient/data/network/patient_api/patient_api.dart';
import 'package:health_care/patient/data/repository/patient_repo_impl.dart';
import 'package:health_care/patient/domain/repository/patient_repo.dart';
import 'package:health_care/patient/domain/usecase/after_payment_use_case.dart';
import 'package:health_care/patient/domain/usecase/book_appointment_use_case.dart';
import 'package:health_care/patient/domain/usecase/delete_review_use_case.dart';
import 'package:health_care/patient/domain/usecase/get_all_doctors_use_case.dart';
import 'package:health_care/patient/domain/usecase/get_available_appointment_by_day_use_case.dart';
import 'package:health_care/patient/domain/usecase/get_available_apponitments_for_doctor_use_case.dart';
import 'package:health_care/patient/domain/usecase/get_docotrs_specialization_use_case.dart';
import 'package:health_care/patient/domain/usecase/get_doctor_by_id_use_case.dart';
import 'package:health_care/patient/domain/usecase/get_doctor_search_use_case.dart';
import 'package:health_care/patient/domain/usecase/get_my_appointments_use_case.dart';
import 'package:health_care/patient/domain/usecase/get_patient_data_use_case.dart';
import 'package:health_care/patient/domain/usecase/get_rate_use_case.dart';
import 'package:health_care/patient/domain/usecase/get_top_doctors_use_case.dart';
import 'package:health_care/patient/domain/usecase/make_doctor_review_use_case.dart';
import 'package:health_care/patient/domain/usecase/open_stripe_session_use_case.dart';
import 'package:health_care/patient/domain/usecase/update_doctor_review_use_case.dart';
import 'package:health_care/patient/presentation/controller/Patient_cubit/patient_cubit.dart';
import 'package:health_care/post/presentation/controller/post_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../chat/domain/usecase/send_message_use_case.dart';
import '../network/dio_factory.dart';
import '../network/network_info.dart';
import '../app/app_prefs.dart';

final sl = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  // shared prefs instance
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  sl.registerLazySingleton<AppPreferences>(() => AppPreferences(sl()));

  // network info
  sl.registerLazySingleton<NetworkInfo>(
      () => NetWorkInfoImpl(DataConnectionChecker()));

  // dio factory
  sl.registerLazySingleton<DioFactory>(() => DioFactory(sl()));

  // app  service client
  final dio = await sl<DioFactory>().getDio();

  sl.registerLazySingleton<PatientAuthServiceClient>(
      () => PatientAuthServiceClient(dio));

  sl.registerLazySingleton<PatientServiceClient>(
      () => PatientServiceClient(dio));

  sl.registerLazySingleton<DoctorAuthServiceClient>(
      () => DoctorAuthServiceClient(dio));

  sl.registerLazySingleton<DoctorServiceClient>(() => DoctorServiceClient(dio));

  sl.registerLazySingleton<UserServiceClient>(() => UserServiceClient(dio));

  sl.registerLazySingleton<ChatServiceClient>(() => ChatServiceClient(dio));
  // remote data source

  sl.registerLazySingleton<PatientAuthRemoteDataSource>(
      () => PatientAuthRemoteDataSourceImplementer(sl()));

  sl.registerLazySingleton<BasePatientRemoteDataSource>(
      () => PatientRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<BaseDoctorAuthRemoteDataSource>(
      () => DoctorAuthRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<BaseDoctorRemoteDataSource>(
      () => DoctorRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImplementer(sl()));

/////////// chat /////////////
  sl.registerLazySingleton<BaseChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(sl()));

  // local data source

  // repository

  sl.registerLazySingleton<BasePatientAuthRepository>(
      () => PatientAuthRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<BasePatientRepo>(() => PatientRepoImpl(sl(), sl()));

  sl.registerLazySingleton<BaseDoctorAuthRepository>(
      () => DoctorAuthRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<BaseDoctorRepo>(() => DoctorRepoImpl(sl(), sl()));

  sl.registerLazySingleton<BaseUserRepository>(
      () => BaseUserRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<BaseChatRepository>(() => ChatRepoImpl(sl(), sl()));

  // useCase

  sl.registerLazySingleton<PatientSignUpUseCase>(
      () => PatientSignUpUseCase(sl()));

  sl.registerLazySingleton<DoctorSignUpUseCase>(
      () => DoctorSignUpUseCase(sl()));

  sl.registerLazySingleton<UserLoginUseCase>(() => UserLoginUseCase(sl()));

  sl.registerLazySingleton<UserForgetPasswordUseCase>(
      () => UserForgetPasswordUseCase(sl()));

  sl.registerLazySingleton<UserUpdatePasswordUseCase>(
      () => UserUpdatePasswordUseCase(sl()));

  sl.registerLazySingleton<UserDeleteMeUseCase>(
      () => UserDeleteMeUseCase(sl()));

  sl.registerLazySingleton<UserEmailConfirmationUseCase>(
      () => UserEmailConfirmationUseCase(sl()));

  sl.registerLazySingleton<UserUpdateInfoUseCase>(
      () => UserUpdateInfoUseCase(sl()));

  sl.registerLazySingleton<GetAllDoctorsUseCase>(
      () => GetAllDoctorsUseCase(sl()));

  sl.registerLazySingleton<GetTopDoctorsUseCase>(
      () => GetTopDoctorsUseCase(sl()));

  sl.registerLazySingleton<GetDoctorByIdUseCase>(
      () => GetDoctorByIdUseCase(sl()));

  sl.registerLazySingleton<GetDoctorSearchUseCase>(
      () => GetDoctorSearchUseCase(sl()));

  sl.registerLazySingleton<GetDoctorsSpecializationUseCase>(
      () => GetDoctorsSpecializationUseCase(sl()));

  sl.registerLazySingleton<GetUserDataUseCase>(() => GetUserDataUseCase(sl()));

///////// Appointments ///////////

  sl.registerLazySingleton<GetAvailableAppointmentsForDoctorUseCase>(
      () => GetAvailableAppointmentsForDoctorUseCase(sl()));

  sl.registerLazySingleton<GetAvailableAppointmentsByDayUseCase>(
      () => GetAvailableAppointmentsByDayUseCase(sl()));

  sl.registerLazySingleton<GetMyAppointmentsUseCase>(
      () => GetMyAppointmentsUseCase(sl()));

  sl.registerLazySingleton<BookAppointmentUseCase>(
      () => BookAppointmentUseCase(sl()));

  sl.registerLazySingleton<IsPatientExaminedUseCase>(
      () => IsPatientExaminedUseCase(sl()));

///////// Rate & Reviews ///////////

  sl.registerLazySingleton<GetDoctorRateUseCase>(
      () => GetDoctorRateUseCase(sl()));

  sl.registerLazySingleton<MakeDoctorReviewUseCase>(
      () => MakeDoctorReviewUseCase(sl()));

  sl.registerLazySingleton<UpdateDoctorReviewUseCase>(
      () => UpdateDoctorReviewUseCase(sl()));

  sl.registerLazySingleton<DeleteReviewUseCase>(
      () => DeleteReviewUseCase(sl()));

  //  // // // // DOCTOR  //  // // // //

  sl.registerLazySingleton<CreateTimeBlockUseCase>(
      () => CreateTimeBlockUseCase(sl()));

  // ////////////// chat////////////

  sl.registerLazySingleton<UserCreateChatUseCase>(
      () => UserCreateChatUseCase(sl()));

  sl.registerLazySingleton<GetAllChatsUseCase>(() => GetAllChatsUseCase(sl()));

  sl.registerLazySingleton<SendMessageUseCase>(() => SendMessageUseCase(sl()));

  sl.registerLazySingleton<GetMessagesUseCase>(() => GetMessagesUseCase(sl()));

  sl.registerLazySingleton<UserSendMessageUseCase>(
      () => UserSendMessageUseCase(sl()));

  sl.registerLazySingleton<GetStreamMessagesUseCase>(
      () => GetStreamMessagesUseCase(sl()));

// /////////////////////// blog /////////////

  sl.registerLazySingleton<CreateBlogUseCase>(() => CreateBlogUseCase(sl()));
  sl.registerLazySingleton<GetAllBlogsUseCase>(() => GetAllBlogsUseCase(sl()));
  sl.registerLazySingleton<GetDoctorBlogsById>(() => GetDoctorBlogsById(sl()));

// /////////////////////// comments likes /////////////

  sl.registerLazySingleton<CreateCommentUseCase>(
      () => CreateCommentUseCase(sl()));

  sl.registerLazySingleton<GetBlogsCommentsUseCase>(
      () => GetBlogsCommentsUseCase(sl()));

  sl.registerLazySingleton<GetBlogsLikesUseCase>(
      () => GetBlogsLikesUseCase(sl()));

  sl.registerLazySingleton<CreateLikeUseCase>(() => CreateLikeUseCase(sl()));

  sl.registerLazySingleton<CreateDisLikeUseCase>(
      () => CreateDisLikeUseCase(sl()));

// /////////////////////// Payment /////////////

  sl.registerLazySingleton<OpenStripeSessionUseCase>(
      () => OpenStripeSessionUseCase(sl()));

  sl.registerLazySingleton<AfterPaymentUseCase>(
      () => AfterPaymentUseCase(sl()));

  // cubit

  sl.registerFactory<AuthCubit>(() => AuthCubit(
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
      ));

  sl.registerFactory<PatientCubit>(() => PatientCubit(
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
      ));

  sl.registerFactory<DoctorCubit>(() => DoctorCubit(
        sl(),
        sl(),
        sl(),
        sl(),
      ));

  sl.registerFactory<PostCubit>(() => PostCubit(
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
      ));
  sl.registerFactory<ChatCubit>(() => ChatCubit(
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
      ));
}

resetModules() {
  sl.reset(dispose: false);
  initAppModule();
}
