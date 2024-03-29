// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/core/app/app_prefs.dart';
import 'package:health_care/core/global/resources/values_manger.dart';
import 'package:health_care/core/global/theme/app_color/color_manager.dart';
import 'package:health_care/core/routes/app_routes.dart';
import 'package:health_care/core/services/services_locator.dart';
import 'package:health_care/core/usecase/base_usecase.dart';
import 'package:health_care/core/widgets/snack_bar_widget.dart';
import 'package:health_care/doctor/presentation/controller/doctor_cubit/doctor_cubit.dart';
import 'package:health_care/doctor/presentation/screens/appointments/widget/appointment_doctor_widget.dart';
import 'package:health_care/patient/presentation/widgets/empty_list_widget.dart';
import 'package:health_care/patient/presentation/widgets/shimmer/doctor_shimmer_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AppointmentDoctorScreen extends StatefulWidget {
  AppointmentDoctorScreen({
    this.isRefresh = false,
    Key? key,
  }) : super(key: key);
  bool isRefresh = false;

  int appointmentIndex = 0;

  final AppPreferences _appPreferences = sl<AppPreferences>();
  String? type;

  getType() async {
    type = await _appPreferences.getType();
  }

  @override
  State<AppointmentDoctorScreen> createState() =>
      _AppointmentDoctorScreenState();
}

class _AppointmentDoctorScreenState extends State<AppointmentDoctorScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    widget.getType();
    if (widget.isRefresh == false) {
      DoctorCubit.get(context).getMyAppointments(const NoParameters());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorState>(
      listener: (context, state) {
        if (state is GetMyAppointmentsSuccessState ||
            state is GetMyAppointmentsFailureState) {
          widget.isRefresh = true;
        }
      },
      builder: (context, state) {
        var cubit = DoctorCubit.get(context);
        return Scaffold(
          body: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: ToggleSwitch(
                  minWidth: AppSize.s150,
                  cornerRadius: 20.0,
                  borderWidth: 1,
                  borderColor: [ColorManager.primary],
                  activeBgColors: [
                    [ColorManager.primary],
                    [ColorManager.primary],
                  ],
                  activeFgColor: ColorManager.white,
                  inactiveBgColor: ColorManager.white,
                  inactiveFgColor: ColorManager.primary,
                  initialLabelIndex: widget.appointmentIndex,
                  totalSwitches: 2,
                  labels: const ['Upcoming', 'Past'],
                  customTextStyles: const [
                    TextStyle(
                      fontSize: AppSize.s16,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                  radiusStyle: true,
                  onToggle: (index) {
                    setState(() {
                      widget.appointmentIndex = index!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s5,
              ),
              ConditionalBuilder(
                condition: widget.appointmentIndex == 0,
                builder: (context) => Expanded(
                  child: ConditionalBuilder(
                    condition: state is! GetMyAppointmentsLoadingState,
                    builder: (context) => cubit.upcomingAppointments.isNotEmpty
                        ? SmartRefresher(
                            controller: _refreshController,
                            onRefresh: () async {
                              await cubit
                                  .getMyAppointments(const NoParameters());
                              _refreshController.refreshCompleted();
                            },
                            child: ListView.separated(
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppPadding.p12,
                              ),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) =>
                                  InkWell(
                                onTap: () {
                                  if (cubit.upcomingAppointments[index].paid) {
                                    Navigator.pushNamed(
                                        context, Routes.startFuncRoute,
                                        arguments: {
                                          'model':
                                              cubit.upcomingAppointments[index],
                                          'type': widget.type,
                                        });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBarWidget(
                                        text: Text(
                                          'Sorry, doctor ${cubit.doctorData?.name ?? ''} Not Paid yet',
                                          style: TextStyle(
                                            color: ColorManager.white,
                                            fontSize: AppSize.s16,
                                          ),
                                        ),
                                        backGroundColor: ColorManager.error,
                                      ),
                                    );
                                  }
                                },
                                child: AppointmentDoctorWidget(
                                  model: cubit.upcomingAppointments[index],
                                ),
                              ),
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(
                                width: AppSize.s10,
                              ),
                              itemCount: cubit.upcomingAppointments.length,
                            ),
                          )
                        : SmartRefresher(
                            controller: _refreshController,
                            onRefresh: () async {
                              await cubit
                                  .getMyAppointments(const NoParameters());
                              _refreshController.refreshCompleted();
                            },
                            child: EmptyListWidget(
                              text: 'No Upcoming Appointments Here',
                            ),
                          ),
                    fallback: (context) => DoctorShimmerWidget(),
                  ),
                ),
                fallback: (context) => Expanded(
                  child: ConditionalBuilder(
                    condition: state is! GetMyAppointmentsLoadingState,
                    builder: (context) => cubit.pastAppointments.isNotEmpty
                        ? SmartRefresher(
                            controller: _refreshController,
                            onRefresh: () async {
                              await cubit
                                  .getMyAppointments(const NoParameters());
                              _refreshController.refreshCompleted();
                            },
                            child: ListView.separated(
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppPadding.p12,
                              ),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) =>
                                  AppointmentDoctorWidget(
                                model: cubit.pastAppointments[index],
                              ),
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(
                                width: AppSize.s10,
                              ),
                              itemCount: cubit.pastAppointments.length,
                            ),
                          )
                        : SmartRefresher(
                            controller: _refreshController,
                            onRefresh: () async {
                              await cubit
                                  .getMyAppointments(const NoParameters());
                              _refreshController.refreshCompleted();
                            },
                            child: EmptyListWidget(
                              text: 'No Past Appointments Here',
                            ),
                          ),
                    fallback: (context) => DoctorShimmerWidget(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
