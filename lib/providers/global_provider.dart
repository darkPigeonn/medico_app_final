import 'package:medico_app/services/auth/auth_service.dart';
import 'package:medico_app/services/logs/log_service.dart';
import 'package:medico_app/services/mitra/mitra_availabilities_service.dart';
import 'package:medico_app/services/mitra/mitra_service.dart';
import 'package:medico_app/services/mitra/mitra_service_service.dart';
import 'package:medico_app/services/reservation/master_service.dart';
import 'package:medico_app/services/reservation/reservation_service.dart';
import 'package:medico_app/services/user/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authService = Provider((_) => AuthService());
final userService = Provider((_) => UserService());
final reservationService = Provider((_) => ReservationService());
final reservationServiceRef = Provider((ref) => ReservationService());
final masterService = Provider((_) => MasterService());
final logService = Provider((_) => LogService());
final mitraAvailabilityService = Provider((_) => MitraAvailabilityService());
final mitraServiceService = Provider((_) => MitraServiceService());
final mitraService = Provider((_) => MitraService());
final globalLoading = StateProvider.autoDispose<bool>((ref) => false);
