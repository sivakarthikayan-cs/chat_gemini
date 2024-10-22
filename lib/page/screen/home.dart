import 'dart:async';

import 'package:chat_gemini/database/database.dart';
import 'package:chat_gemini/page/provider/home/home_provider.dart';
import 'package:chat_gemini/page/provider/home/state/home_state.dart';
import 'package:chat_gemini/page/provider/speech/speech_provider.dart';
import 'package:chat_gemini/page/provider/speech/state/speech_state.dart';
import 'package:chat_gemini/utils/flutter_toast.dart';
import 'package:chat_gemini/utils/google_chat.dart';
import 'package:chat_gemini/utils/typewriter_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isLoading = false;
  String? prompt;
  int currentProcessingId = -1;
  final TextEditingController promptController = TextEditingController();
  final isScrollDownProvider = StateProvider<bool>((ref) => false);
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(homeStateNotifierProvider.notifier)
          .fetchLimitedChat(refresh: true);
    });
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  Future<void> _onScroll() async {
    final isScrollUp = _scrollController.position.pixels > 100;
    ref.read(isScrollDownProvider.notifier).state = isScrollUp;
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.position.pixels) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(homeStateNotifierProvider.notifier)
            .fetchLimitedChat(loadMore: true);
      });
    }
  }

  Future<void> _scrollToDown() async {
    if (homeState.homeResponse?.isNotEmpty ?? false) {
      await _scrollController.animateTo(
        0,
        duration: Duration(
            milliseconds: (_scrollController.position.maxScrollExtent -
                            _scrollController.position.pixels ==
                        0
                    ? 1
                    : _scrollController.position.pixels)
                .toInt()),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    promptController.dispose();
    super.dispose();
  }

  HomeState get homeState => ref.watch(homeStateNotifierProvider);
  SpeechState get speechState => ref.watch(speechStateNotifierProvider);

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeStateNotifierProvider);
    final isScrollDown = ref.watch(isScrollDownProvider);
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Chat Gemini"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await ref
                    .read(homeStateNotifierProvider.notifier)
                    .deleteAllChat();
              },
              icon: const Icon(CupertinoIcons.delete_simple))
        ],
      ),
      body: homeState.homeResponse?.isNotEmpty ?? false
          ? Stack(
              children: [
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  reverse: true,
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      ListView.separated(
                          reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            ChatResponseData? item =
                                homeState.homeResponse?[index];
                            return Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.6),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SelectableText(
                                        item?.message ?? "",
                                      ),
                                    ),
                                  ),
                                ),
                                if (item?.response != null) ...[
                                  const SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: homeState
                                                        .currentProcessingId ==
                                                    item?.id
                                                ? TypewriterText(
                                                    text: item?.response ?? "")
                                                : SelectableText(
                                                    item?.response ?? ""),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () async {
                                                  if (speechState.currentState?[
                                                          item?.id] ==
                                                      SpeechStateConcreteState
                                                          .playing) {
                                                    await ref
                                                        .read(
                                                            speechStateNotifierProvider
                                                                .notifier)
                                                        .pause();
                                                  } else {
                                                    await ref
                                                        .read(
                                                            speechStateNotifierProvider
                                                                .notifier)
                                                        .speak(
                                                            msg: item?.response,
                                                            itemId: item?.id);
                                                  }
                                                },
                                                icon: Icon(speechState
                                                                .currentState?[
                                                            item?.id] ==
                                                        SpeechStateConcreteState
                                                            .playing
                                                    ? Icons.pause
                                                    : Icons.play_arrow)),
                                            if (speechState
                                                    .currentState?[item?.id] ==
                                                SpeechStateConcreteState
                                                    .playing)
                                              IconButton(
                                                  onPressed: () async {
                                                    await ref
                                                        .read(
                                                            speechStateNotifierProvider
                                                                .notifier)
                                                        .stop();
                                                  },
                                                  icon: const Icon(Icons.stop)),
                                            IconButton(
                                                onPressed: () {
                                                  Clipboard.setData(
                                                    ClipboardData(
                                                      text:
                                                          item?.response ?? "",
                                                    ),
                                                  ).then((_) {
                                                    GlobalToast.showToast(
                                                        "Copied",
                                                        textColor: Colors.black,
                                                        backgroundColor:
                                                            Colors.greenAccent);
                                                  });
                                                },
                                                icon:
                                                    const Icon(Icons.copy_all)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ]
                              ],
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount: homeState.homeResponse?.length ?? 0),
                      Visibility(
                        visible: isLoading,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: 100,
                            child: SpinKitThreeBounce(
                              itemBuilder: (BuildContext context, int index) {
                                return DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: index.isEven
                                        ? Colors.grey
                                        : Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 70,
                  left: MediaQuery.of(context).size.width * 0.4,
                  child: AnimatedOpacity(
                    opacity: isScrollDown &&
                            (homeState.homeResponse?.isNotEmpty ?? false) &&
                            _scrollController.position.maxScrollExtent > 0
                        ? 1.0
                        : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: IconButton(
                          onPressed: () => _scrollToDown(),
                          icon: const Icon(
                            CupertinoIcons.arrow_down_circle,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
              ],
            )
          : Align(
              alignment: Alignment.center,
              child: Center(
                child: Image.asset(
                  "assets/image/ic_gemini.png",
                  scale: 5,
                )
                    .animate(
                      onPlay: (controller) => controller.repeat(),
                    )
                    .rotate(begin: 0.5, duration: 3000.ms)
                    .flip(
                        begin: 2, duration: 3000.ms, direction: Axis.horizontal)
                    .flip(
                      begin: 2,
                      duration: 3000.ms,
                      direction: Axis.vertical,
                    ),
              ),
            ),
      bottomSheet: SafeArea(
        child: Container(
          color: Colors.black,
          height: 70,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: promptController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: Colors.grey,
                      filled: true,
                      hintText: "Message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                    ),
                    onSubmitted: (_) async => onSubmit(),
                  ),
                ),
                IconButton(
                    iconSize: 40,
                    onPressed: () async => await onSubmit(),
                    icon: const Icon(CupertinoIcons.arrow_right_circle_fill)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onSubmit() async {
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => TextToSpeech()));
    //
    if (promptController.text.isNotEmpty) {
      setState(() {
        prompt = promptController.text;
        isLoading = true;
        promptController.clear();
      });
      final int? resID = await ref
          .read(homeStateNotifierProvider.notifier)
          .addChat(prompt: prompt!);
      if ((homeState.homeResponse?.length ?? 0) > 2) {
        _scrollToDown();
      }
      if (resID != null) {
        try {
          String? res = await getChat(prompt: prompt!);
          setState(() {
            prompt = null;
            isLoading = false;
          });
          await ref
              .read(homeStateNotifierProvider.notifier)
              .updateChatResponse(id: resID, response: res);
          await _scrollToDown();
        } catch (e) {
          await ref
              .read(homeStateNotifierProvider.notifier)
              .updateChatResponse(id: resID, response: e.toString());
          setState(() {
            prompt = null;
            isLoading = false;
          });
          GlobalToast.showToast(e.toString());
        }
      }
    }
  }
}
