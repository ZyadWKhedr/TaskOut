import 'package:task_out/core/services/prefrences_service.dart';

class CheckFirstTimeUseCase {
  final PreferencesService preferencesService;

  CheckFirstTimeUseCase(this.preferencesService);

  Future<bool> call() {
    return preferencesService.isFirstTimeUser();
  }
}