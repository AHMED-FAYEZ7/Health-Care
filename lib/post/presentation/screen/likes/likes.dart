// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/core/global/resources/icons_manger.dart';
import 'package:health_care/core/global/resources/values_manger.dart';
import 'package:health_care/core/global/theme/app_color/color_manager.dart';
import 'package:health_care/core/widgets/app_bar_widget.dart';
import 'package:health_care/doctor/domain/model/comments_likes_model.dart';
import 'package:health_care/doctor/presentation/controller/doctor_cubit/doctor_cubit.dart';
import 'package:health_care/post/presentation/controller/post_cubit.dart';
import 'package:intl/intl.dart';

class LikesWidget extends StatelessWidget {
  LikesWidget({
    // required this.likes,
    Key? key,
  }) : super(key: key);

  // List<LikesModel> likes;

  TextEditingController comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PostCubit.get(context);
        return Scaffold(
          appBar: AppBarWidget(
            isBack: true,
            title: 'Likes',
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p12,
                  ),
                  itemBuilder: (context, index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: AppSize.s25,
                        backgroundImage: NetworkImage(
                          "https://idsb.tmgrup.com.tr/ly/uploads/images/2022/12/19/247181.jpg",
                        ),
                      ),
                      const SizedBox(
                        width: AppSize.s5,
                      ),
                      Flexible(
                        child: Card(
                          elevation: AppSize.s3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.s12),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 5,
                                  bottom: 2,
                                  left: 8,
                                  right: 12,
                                ),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: Text(
                                    cubit.likes[index].userInfo?.name ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 5,
                                  bottom: 2,
                                  left: 8,
                                  right: 12,
                                ),
                                child: Text(
                                  "${DateFormat.jm().format(DateTime.parse(cubit.likes[index].createdAt))} ${DateFormat.yMMMMd('en_US').format(DateTime.parse(cubit.likes[index].createdAt))}",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: AppSize.s15,
                  ),
                  itemCount: cubit.likes.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}