import 'dart:isolate';

import 'package:chat_gemini/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_state.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  final AppDatabase db;
  HomeNotifier({required this.db}) : super(const HomeState.initial());
  int _page = 1;
  final int _limit = 5;

  Future<void> pendingOrdersPaginate({
    bool? loadMore,
  }) async {
    _page = _page + 1;
    await fetchLimitedChat(loadMore: loadMore);
  }

  Future<String> startDownloadUsingRun() async {
    final imageData = await Isolate.run(_readAndParseJsonWithoutIsolateLogic);
    print(imageData);
    return imageData;
  }

  Future<String> _readAndParseJsonWithoutIsolateLogic() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'this is downloaded data';
  }

  Future<void> fetchLimitedChat({bool? loadMore, bool? refresh}) async {
    if (refresh == true) {
      _page = 1;
      state = state.copyWith(refreshLoad: true);
    } else if (loadMore == true) {
      _page = _page + 1;
      state = state.copyWith(showMoreLoad: true);
    } else {
      state = state.copyWith(state: HomeStateConcreteState.loading);
    }
    try {
      List<ChatResponseData> res =
          await db.chatResponseDao.fetchLimitedChat(limit: _limit, page: _page);

      int? totalCount = await getTotalChatCount();
      List<ChatResponseData>? finalRes = [
        ...?state.homeResponse,
        ...res,
      ];
      state = state.copyWith(
          state: HomeStateConcreteState.success,
          homeResponse: refresh ?? false ? res : finalRes,
          showMoreLoad: false,
          refreshLoad: false,
          totalChatCount: totalCount);
    } catch (e) {
      state = state.copyWith(
          state: HomeStateConcreteState.failure,
          showMoreLoad: false,
          refreshLoad: false);
    }
  }

  Future<void> fetchAllChat() async {
    state = state.copyWith(state: HomeStateConcreteState.loading);
    try {
      List<ChatResponseData> res =
          await db.chatResponseDao.fetchChatResponsesForSync();
      int? totalCount = await getTotalChatCount();
      state = state.copyWith(
          state: HomeStateConcreteState.success,
          homeResponse: res,
          totalChatCount: totalCount);
    } catch (e) {
      state = state.copyWith(state: HomeStateConcreteState.failure);
    }
  }

  Future<int?> addChat(
      {required ChatResponseCompanion chatResponseCompanion}) async {
    int? res;
    state = state.copyWith(state: HomeStateConcreteState.loading);
    try {
      res = await db.chatResponseDao.addChatResponse(chatResponseCompanion);
      await fetchLimitedChat(refresh: true);
      state = state.copyWith(
          state: HomeStateConcreteState.success, currentProcessingId: res);
    } catch (e) {
      state = state.copyWith(state: HomeStateConcreteState.failure);
    }
    return res;
  }

  Future<void> deleteAllChat() async {
    state = state.copyWith(state: HomeStateConcreteState.loading);
    try {
      int res = await db.chatResponseDao.clearTable();
      await fetchLimitedChat(refresh: true);
      state = state.copyWith(state: HomeStateConcreteState.success);
    } catch (e) {
      state = state.copyWith(state: HomeStateConcreteState.failure);
    }
  }

  Future<void> updateChatResponse(
      {required int id, String? response, String? updateDate}) async {
    state = state.copyWith(state: HomeStateConcreteState.loading);
    try {
      int res = await db.chatResponseDao.updateChatResponseRecord(
          id: id, response: response, updateDate: updateDate);
      await fetchLimitedChat(refresh: true);
      state = state.copyWith(state: HomeStateConcreteState.success);
    } catch (e) {
      state = state.copyWith(state: HomeStateConcreteState.failure);
    }
  }

  Future<int?> getTotalChatCount() async {
    int? res;
    state = state.copyWith(state: HomeStateConcreteState.loading);
    try {
      res = await db.chatResponseDao.getTotalChatCount();

      state = state.copyWith(state: HomeStateConcreteState.success);
    } catch (e) {
      state = state.copyWith(state: HomeStateConcreteState.failure);
    }
    return res;
  }

  void updateCurrentProcessingId({required int id}) async =>
      state = state.copyWith(currentProcessingId: id);
}
