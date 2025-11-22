// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:linkify/main.export.dart';

typedef FutureEither<F, T> = Future<Either<F, T>>;

typedef Report<T> = Either<Failure, T>;
typedef FutureReport<T> = Future<Report<T>>;

Either<Failure, R> failure<R>(String msg, {Object? e, StackTrace? s}) {
  return Left(Failure(msg, error: e, stackTrace: s ?? StackTrace.current));
}

Future<T> failToErr<T>(Failure f) {
  return f.toFuture<T>();
}

class Failure {
  const Failure(
    this.message, {
    this.errors = const <String, String>{},
    this.error,
    StackTrace? stackTrace,
    this.isTimeOut = false,
    this.endpoint,
    this.statusCode = -1,
    this.event,
  }) : _stackTrace = stackTrace;

  /// The original error obj
  final Object? error;

  /// List of error messages in KEY-VALUE format
  final Map<String, String> errors;

  /// The main message of the error
  final String message;

  final StackTrace? _stackTrace;
  final bool isTimeOut;
  final String? endpoint;
  final int statusCode;
  final String? event;

  @override
  String toString() => message;

  StackTrace get stackTrace => _stackTrace ?? StackTrace.current;

  Map<String, dynamic> toMap() {
    return {'message': message, 'errors': errors, 'error': error, 'isTimeOut': isTimeOut};
  }

  String? getErr([String? key]) => key != null ? errors[key] : errors.values.firstOrNull;

  String err([String? name]) => errors.values.firstOrNull ?? error?.toString() ?? kError(name);

  String errOrMsg() => errors.values.firstOrNull ?? message;

  String get safeMsg => kReleaseMode ? kError('debug: $message') : message;
  String? get safeBody => kReleaseMode ? 'Please try again later.' : null;

  Failure copyWith({
    String? message,
    Map<String, String>? errors,
    Object? apiError,
    StackTrace? stackTrace,
    bool? isTimeOut,
    String? endpoint,
    int? statusCode,
    String? event,
  }) {
    return Failure(
      message ?? this.message,
      errors: errors ?? this.errors,
      stackTrace: stackTrace ?? _stackTrace,
      error: apiError ?? error,
      isTimeOut: isTimeOut ?? this.isTimeOut,
      endpoint: endpoint ?? this.endpoint,
      statusCode: statusCode ?? this.statusCode,
      event: event ?? this.event,
    );
  }

  Future<T> toFuture<T>() {
    final future = Future<T>.error(this, stackTrace);
    return future;
  }

  AsyncError<T> toAsyncError<T>() {
    final error = AsyncError<T>(message, stackTrace);

    return error;
  }

  Failure copyWithMessage(String msg) => copyWith(message: msg);

  void log(String name) {
    catErr('$name :: [code: $statusCode]', message, stackTrace);
    if (errors.isNotEmpty) cat(errors, 'Failure Errors');
  }
}
