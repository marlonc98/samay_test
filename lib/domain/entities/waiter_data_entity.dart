import 'package:either_dart/either.dart';
import 'package:samay/domain/entities/exception_entity.dart';

enum WaiterDataEntityStatus {
  loading,
  loaded,
  error,
}

class WaiterDataEntity<T> {
  T? data;
  WaiterDataEntityStatus status;

  WaiterDataEntity({this.data, this.status = WaiterDataEntityStatus.loading});

  WaiterDataEntity<T> fromEither(Either<ExceptionEntity, T> either) {
    return WaiterDataEntity(
      data: either.isRight ? either.right : null,
      status: either.isRight
          ? WaiterDataEntityStatus.loaded
          : WaiterDataEntityStatus.error,
    );
  }
}
