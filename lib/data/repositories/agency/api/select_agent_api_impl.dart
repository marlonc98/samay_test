import 'package:shared_preferences/shared_preferences.dart';

Future<void> selectAgentApiImpl(
    {required String spKey, required String agentId}) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  await sp.setString(spKey, agentId);
}
