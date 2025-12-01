import 'dart:async';
import 'package:bloc/bloc.dart';

abstract class OtpState { const OtpState(); }
class OtpInitial extends OtpState {}
class OtpTick extends OtpState { final int remaining; const OtpTick(this.remaining); }
class OtpVerifying extends OtpState {}
class OtpVerified extends OtpState {}
class OtpError extends OtpState { final String failureKey; const OtpError(this.failureKey); }
class OtpResent extends OtpState {}

class OtpCubit extends Cubit<OtpState> {
  static const int initialSeconds = 60;
  int _remaining = initialSeconds;
  Timer? _timer;
  String _code = '';

  OtpCubit() : super(OtpInitial()) {
    startTimer();
  }

  void startTimer() {
    _remaining = initialSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      _remaining--;
      if (_remaining <= 0) {
        t.cancel();
        emit(const OtpTick(0));
      } else {
        emit(OtpTick(_remaining));
      }
    });
  }

  void updateDigit(int index, String value) {
    // Ensure length 4
    final list = _code.padRight(4).split('');
    if (index < 0 || index > 3) return;
    list[index] = value.isEmpty ? '' : value[0];
    _code = list.join();
  }

  bool get canVerify => _code.length == 4 && !_code.contains('');

  Future<void> verify() async {
    if (!canVerify) return;
    emit(OtpVerifying());
    await Future.delayed(const Duration(milliseconds: 600));
    // Simulate success for any 4-digit code
    if (_code.length == 4) {
      emit(OtpVerified());
    } else {
      emit(const OtpError('failures.validation'));
    }
  }

  Future<void> resend() async {
    if (_remaining > 0) return; // only allow when timer finished
    emit(OtpResent());
    await Future.delayed(const Duration(milliseconds: 500));
    startTimer();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

