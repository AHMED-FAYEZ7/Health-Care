import 'package:dartz/dartz.dart';
import 'package:health_care/core/error/failure.dart';
import 'package:health_care/doctor/domain/model/blog_model.dart';
import 'package:health_care/doctor/domain/model/comments_likes_model.dart';
import 'package:health_care/doctor/domain/model/time_block_model.dart';

abstract class BaseDoctorRepo {
  Future<Either<Failure, TimeBlock>> createTimeBlocK({
    required int period,
    required String startTime,
    required String callType,
  });

  // /////////////// blog ////////////
  Future<Either<Failure, BlogInfo>> createBlog(
    String blogDescription,
    String blogTitle, {
    String? blogImage,
  });

  Future<Either<Failure, BlogInfo>> getAllBlogs();

  Future<Either<Failure, BlogInfo>> getDoctorBlogsById({
    required String doctorId,
  });

  /////////////// comments & likes ////////
  Future<Either<Failure, BaseComment>> createComment({
    required String blogId,
    required String commentContent,
  });

  Future<Either<Failure, CommentInfo>> getBlogsComments({
    required String blogId,
  });

  Future<Either<Failure, LikesModel>> getBlogsLikes({
    required String blogId,
  });

  Future<Either<Failure, String>> createLike({required String blogId});

  Future<Either<Failure, String>> createDisLike({required String blogId});

  Future<Either<Failure, void>> isExamined({
    required String appointmentId,
    required String status,
  });
}
