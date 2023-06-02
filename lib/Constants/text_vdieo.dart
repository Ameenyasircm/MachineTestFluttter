import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';






///

///
class YoutubeAppDemo extends StatefulWidget {

  final link;
  YoutubeAppDemo({Key? key,required String this.link}) : super(key: key);

  // YoutubeAppDemo();
  @override
  _YoutubeAppDemoState createState() => _YoutubeAppDemoState();
}

class _YoutubeAppDemoState extends State<YoutubeAppDemo> {
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();


  late YoutubePlayerController _controller;

  @override
  void initState() {

    super.initState();
    print("jhbfscde"+widget.link);
    _controller = YoutubePlayerController(
      initialVideoId: widget.link,
      params:  YoutubePlayerParams(
        playlist: [
          widget.link
        ],
        startAt: const Duration(minutes:0, seconds: 0),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: false,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    _controller.onExitFullscreen = () {
      log('Exited Fullscreen');
    };
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      // Passing controller to widgets below.
      controller: _controller,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (kIsWeb && constraints.maxWidth > 800) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(child: player),
                  // const SizedBox(
                  //   width: 500,
                  //   child: SingleChildScrollView(
                  //     child: Controls(),
                  //   ),
                  // ),
                ],
              );
            }
            return ListView(
              children: [
                Stack(
                  children: [
                    player,
                    Positioned.fill(
                      child:
                              YoutubeValueBuilder(
                              controller: _controller,
                              builder: (context, value) {
                                return AnimatedCrossFade(

                                  firstChild:  SizedBox.shrink(),
                                  secondChild:  Material(
                                    child:  DecoratedBox(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:AssetImage("assets/Answerkey.png"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                  crossFadeState: value.isReady
                                      ? CrossFadeState.showFirst
                                      : CrossFadeState.showSecond,
                                  duration: const Duration(milliseconds: 400),
                                );
                              },
                            ),

                    ),
                  ],
                ),
                // const Controls(),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}


///
// class Controls extends StatelessWidget {
//   ///
//   const Controls();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _space,
//           MetaDataSection(),
//           _space,
//           SourceInputSection(),
//           _space,
//           PlayPauseButtonBar(),
//           _space,
//           VolumeSlider(),
//           _space,
//           PlayerStateSection(),
//         ],
//       ),
//     );
//   }
//
//   Widget get _space => const SizedBox(height: 10);
// }
