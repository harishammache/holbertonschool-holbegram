import 'package:flutter/foundation.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:holbegram/models/user.dart';

class UserProvider with ChangeNotifier {
	Userd? _user;
	final AuthMethode _authMethode = AuthMethode();

	Userd? get user => _user;

	Future<void> refreshUser() async {
		final user = await _authMethode.getUserDetails();
		_user = user;
		notifyListeners();
	}
}