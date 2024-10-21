import 'dart:async';

import 'package:chat_gemini/page/provider/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TypewriterText extends ConsumerStatefulWidget {
  final String text;
  final Duration duration;

  const TypewriterText(
      {super.key,
      required this.text,
      this.duration = const Duration(milliseconds: 10)});

  @override
  ConsumerState createState() => _TypewriterTextState();
}

class _TypewriterTextState extends ConsumerState<TypewriterText> {
  String _displayedText = "";
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(widget.duration, (_) {
      setState(() {
        if (_currentIndex < widget.text.length) {
          _displayedText += widget.text[_currentIndex];
          _currentIndex++;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(homeStateNotifierProvider.notifier)
          .updateCurrentProcessingId(id: -1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SelectableText(_displayedText);
  }
}
