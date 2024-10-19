import 'package:chat_gemini/database/database.dart';
import 'package:equatable/equatable.dart';

enum HomeStateConcreteState { initial, loading, success, failure }

class HomeState extends Equatable {
  final List<ChatResponseData>? homeResponse;
  final HomeStateConcreteState state;
  final int currentProcessingId;
  final int totalChatCount;
  final bool showMoreLoad;
  final bool refreshLoad;

  const HomeState(
      {required this.state,
      required this.homeResponse,
      this.currentProcessingId = -1,
      required this.showMoreLoad,
      required this.refreshLoad,
      required this.totalChatCount});

  const HomeState.initial(
      {this.state = HomeStateConcreteState.initial,
      this.homeResponse,
      this.currentProcessingId = -1,
      this.showMoreLoad = false,
      this.refreshLoad = false,
      this.totalChatCount = 0});

  HomeState copyWith(
      {List<ChatResponseData>? homeResponse,
      HomeStateConcreteState? state,
      int? currentProcessingId,
      bool? showMoreLoad,
      bool? refreshLoad,
      int? totalChatCount}) {
    return HomeState(
        homeResponse: homeResponse ?? this.homeResponse,
        state: state ?? this.state,
        currentProcessingId: currentProcessingId ?? this.currentProcessingId,
        showMoreLoad: showMoreLoad ?? this.showMoreLoad,
        refreshLoad: refreshLoad ?? this.refreshLoad,
        totalChatCount: totalChatCount ?? this.totalChatCount);
  }

  @override
  String toString() {
    return 'HomeState(state:$state, logHistoryLength:${homeResponse?.length}, Total Chat Count:$totalChatCount';
  }

  @override
  List<Object?> get props => [homeResponse, state];
}
