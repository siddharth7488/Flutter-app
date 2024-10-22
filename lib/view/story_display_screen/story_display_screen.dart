import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/story_model/story_model.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/widgets/story_view_screen/appbar.dart';
import 'dart:async';

import 'package:gofriendsgo/widgets/story_view_screen/body.dart';
import 'package:gofriendsgo/widgets/story_view_screen/loading_indicator.dart';

class StoryDisplayScreen extends StatefulWidget {
  final List<Story> allStories;
  final int currentIndex;

  const StoryDisplayScreen(
      {super.key, required this.allStories, required this.currentIndex});

  @override
  State<StoryDisplayScreen> createState() => _StoryDisplayScreenState();
}

class _StoryDisplayScreenState extends State<StoryDisplayScreen> {
  late PageController _pageController;
  late Timer _timer;
  late int _currentIndex;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _progress += 0.01; // Adjust this value to reduce display time
        if (_progress >= 1.0) {
          _progress = 0.0;
          _currentIndex++;
          if (_currentIndex >= widget.allStories.length) {
            _currentIndex = 0; // Loop back to the first story
          }
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, mediaqueryheight(0.09, context)),
          child: AppBarOfStoryViewScreen(
              widget: widget, currentIndex: _currentIndex)),
      body: Stack(children: [
        storyViewArea(
          pageController: _pageController,
          storyLength: widget.allStories.length,
          currentImagePath: widget.allStories[_currentIndex].image,
          callBack: (index) {
            setState(() {
              _currentIndex = index;
              _progress = 0.0;
            });
          },
        ),
        LoadingIndicatorOnStoryViewScreen(progress: _progress)
      ]),
    );
  }
}
