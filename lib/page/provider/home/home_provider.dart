import 'package:chat_gemini/database/database.dart';
import 'package:chat_gemini/page/provider/home/state/home_notifier.dart';
import 'package:chat_gemini/page/provider/home/state/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeStateNotifierProvider =
    StateNotifierProvider<HomeNotifier, HomeState>(
  (ref) {
    final AppDatabase db = AppDatabase();
    return HomeNotifier(db: db);
  },
);
