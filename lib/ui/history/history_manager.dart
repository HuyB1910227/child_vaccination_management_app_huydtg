import '../../models/auth_token.dart';
import '../../models/history/history.dart';
import '../../models/history/history_general_information.dart';
import '../../services/history/history_service.dart';
import 'package:flutter/foundation.dart';


class HistoryManager with ChangeNotifier{

  List<HistoryGeneralInformation> _historyGeneralInformations = [];

  final HistoryService _historyService;

  HistoryManager([AuthToken? authToken])
      : _historyService = HistoryService(authToken);

  set authToken(AuthToken? authToken) {
    _historyService.authToken = authToken;

  }

  Future<void> fetchAllHistoryForCustomer() async {
    _historyGeneralInformations = await _historyService.fetchAllHistoryForCustomer();
    _historyGeneralInformations.sort((a, b) => a.vaccinationDate.compareTo(b.vaccinationDate));
  }

  Future<History?> fetchHistoryById(int id) async {
    History? history = await _historyService.fetchHistoryById(id);
    return history;
  }

  int get historyGeneralInformationsCount {
    return _historyGeneralInformations.length;
  }

  List<HistoryGeneralInformation> get historyGeneralInformations {
    return [..._historyGeneralInformations];
  }

}