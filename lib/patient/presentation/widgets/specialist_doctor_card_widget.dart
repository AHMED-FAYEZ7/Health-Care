// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:health_care/core/global/resources/values_manger.dart';
import 'package:health_care/core/global/theme/app_color/color_manager.dart';

class SpecialistDoctorCardWidget extends StatelessWidget {
  SpecialistDoctorCardWidget({
    required this.specialistImage,
    required this.specialistName,
    required this.specialistNoDoctors,
    required this.specialistColor,
    Key? key,
  }) : super(key: key);

  String specialistImage;
  String specialistName;
  int specialistNoDoctors;
  Color specialistColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppSize.s3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      child: Container(
        height: AppSize.s180,
        width: 105,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(specialistImage),
            const SizedBox(
              height: AppSize.s10,
            ),
            Text(
              '$specialistName \n Specialist',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorManager.black,
                fontSize: AppSize.s16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: AppSize.s8,
            ),
            Text(
              '$specialistNoDoctors Doctors',
              style: TextStyle(
                color: ColorManager.black,
                fontSize: AppSize.s12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
