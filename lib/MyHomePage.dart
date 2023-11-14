import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final player = AudioPlayer();
  bool isPlaying = false;

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  void initState() {
    super.initState();

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 11, 75, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    'images/BlueNPink.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: const Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child:
                    Text("Instrumental Spectrum", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold ),),

                      ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child:
                    Text("Inspired Theory", style: TextStyle(fontSize: 20, color: Colors.white,),)

                  ),
                ],
              ),
            ),
            Slider(
              thumbColor: Colors.white,
              inactiveColor: Colors.white,
              activeColor: Color.fromRGBO(234, 20, 155, 1),
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) {
                position = Duration(seconds: value.toInt());
                player.seek(position);
                player.resume();
              },
            ),

            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatTime(position.inSeconds),
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(formatTime((duration - position).inSeconds),
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    player.pause();
                  },
                  icon: Icon(Icons.pause),
                  iconSize: 60,
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () {
                    player.play(AssetSource('music.mp3'));
                  },
                  icon: Icon(Icons.play_circle_outline),
                  iconSize: 60,
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () {
                    player.stop();
                  },
                  icon: Icon(Icons.stop),
                  iconSize: 60,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
