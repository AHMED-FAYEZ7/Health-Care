// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:health_care/core/global/resources/values_manger.dart';
import 'package:health_care/patient/presentation/widgets/shimmer/shimmer_widget.dart';

class TopDoctorShimmerWidget extends StatelessWidget {
  TopDoctorShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) => SizedBox(
        width: AppSize.s140,
        height: AppSize.s180,
        child: Card(
          elevation: AppSize.s3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(AppSize.s12),
                  topLeft: Radius.circular(AppSize.s12),
                ),
                child: ShimmerWidget(
                  width: AppSize.s150,
                  height: AppSize.s120,
                ),
              ),
              SizedBox(
                height: AppSize.s8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p8,
                ),
                child: ShimmerWidget(
                  width: double.infinity,
                  height: AppSize.s15,
                ),
              ),
              SizedBox(
                height: AppSize.s5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p8,
                ),
                child: ShimmerWidget(
                  width: double.infinity,
                  height: AppSize.s15,
                ),
              ),
              SizedBox(
                height: AppSize.s5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p14,
                ),
                child: ShimmerWidget(
                  width: double.infinity,
                  height: AppSize.s10,
                ),
              ),
            ],
          ),
        ),
      ),
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        width: AppSize.s10,
      ),
      itemCount: 5,
    );
  }
}
