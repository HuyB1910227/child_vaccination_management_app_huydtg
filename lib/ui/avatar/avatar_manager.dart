import 'package:flutter/foundation.dart';
import '../../services/avatar/avatar_service.dart';
import '../../models/auth_token.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class AvatarManager with ChangeNotifier {
  AuthToken? _authToken;
  final AvatarService _avatarService;
  final String _imageURL = "${dotenv.env['DEFAULT_URL']!}/api/avatar/";
  AvatarManager([AuthToken? authToken])
      : _avatarService = AvatarService(authToken);

  set authToken(AuthToken? authToken) {
    _authToken = authToken;
    _avatarService.authToken = authToken;
    notifyListeners();
  }

  AuthToken? get authToken => _authToken;

  String get imageURL => _imageURL;

  Future<Uint8List> loadImageWithAvatarName (String avatarName) async {
    String url = _imageURL + avatarName;
    return _avatarService.loadImage(url);
  }


  Future<String?> updatePatientAvatar (imageFile, patientId) async {
    return _avatarService.updatePatientAvatar(imageFile, patientId);
  }

  Future<String?> updateUserAvatar (imageFile) async {
    return _avatarService.updateUserAvatar(imageFile);
  }
}