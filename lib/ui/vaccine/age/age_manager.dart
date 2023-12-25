import '../../../services/ages/age_service.dart';
import '../../../models/auth_token.dart';
import '../../../models/age/age.dart';
import 'package:flutter/foundation.dart';
class AgeManager with ChangeNotifier{
  final AgeService _ageService;

  AgeManager([AuthToken? authToken])
      : _ageService = AgeService(authToken);

  set authToken(AuthToken? authToken) {
    _ageService.authToken = authToken;

  }

  Future<List<Age>> fetchAgeByVaccineId(String id) async {
    List<Age> result = await _ageService.fetchAgeByVaccineId(id);

    return result;
    notifyListeners();
  }

}