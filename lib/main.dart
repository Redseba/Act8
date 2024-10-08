import 'package:flutter/material.dart';
import "dart:async";
import 'dart:math';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FadingTextAnimation(),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  bool _image = true;
  bool _image2 = true;
  String message = '';
  Random random = Random();
  double batX = 0.0;
  double batY = 0.0;
  double bat2X = 0.0;
  double bat2Y = 0.0;
  double witchX = 0.0;
  double witchY = 0.0;

  final AudioPlayer _audioPlayer = AudioPlayer();

  void updateFlyingObjects() {
    setState(() {
      batX = random.nextDouble() * 300;
      batY = random.nextDouble() * 500;
      bat2X = random.nextDouble() * 300;
      bat2Y = random.nextDouble() * 500; 
      witchX = random.nextDouble() * 300;
      witchY = random.nextDouble() * 500;
    });
  }

  void onBatTap(int batNumber) async {
    setState(() {
      if (batNumber == 1) {
        message = "You Won, Looks like you survived!!";
        _playVictoryMusic();
      } else {
        message = "Bad Luck 100 years!";
      }
    });
  }

  Future<void> _playVictoryMusic() async {
    try {
    await _audioPlayer.setAsset('Assets/final-fantasy-vii-victory-fanfare-1.mp3');
    print("Audio asset loaded successfully.");
    _audioPlayer.play();
    print("Playing audio...");
    } 
    catch (e) 
    {
      print("Error loading or playing audio: $e");
    }
  }

  Future<void> _playHalloweenMusic() async {
    try {
      await _audioPlayer.setAsset('Assets/2020-10-26_-_Groovy_Ghouls_-_www.FesliyanStudios.com_Steve_Oxen.mp3');
      print("Halloween music loaded successfully.");
      _audioPlayer.setLoopMode(LoopMode.all);
      _audioPlayer.play();
      print("Playing Halloween music...");
    } catch (e) 
    {
      print("Error loading or playing Halloween music: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 2), (timer) {
      updateFlyingObjects(); // Update positions every 2 seconds
    });

    _playHalloweenMusic();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
      ),
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(seconds: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 20,
                    left: 20,
                    
                    child: 
                    Image.asset(
                      'Assets/Tomb1.png',
                      height: 200,
                      width: 150,
                    ),
                  ),


                  Positioned(
                    top: 50,
                    right: 20,
                    child: Image.asset(
                    'Assets/Tomb2.png',
                      height: 200,
                    width: 150,
                    ),
                  ),

                  Positioned(
                    top: 70,
                    left: 10,
                    
                    child: 
                    Image.asset(
                      'Assets/Tomb3.png',
                      height: 200,
                      width: 150,
                    ),
                  ),


                  Image.asset(
                    'Assets/Fence.png',
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),


                  Positioned(
                    bottom: -30,
                    child: Image.asset(
                      _image ? 'Assets/ghost_turtle.png' : 'Assets/Basket.png',
                      width: 200,
                      height: 200,
                    ),
                  ),


                  Positioned(
                    bottom: -10,
                    child: Image.asset(
                      _image2 ? 'Assets/Basket.png' : 'Assets/ghost_turtle.png',
                      width: 100,
                      height: 100,
                    ),
                  ),


                  AnimatedPositioned(
                    duration: Duration(seconds: 2),
                    left: batX,
                    top: batY,
                    child: GestureDetector(
                      onTap: () => onBatTap(1),
                      child: Image.asset(
                        'Assets/bat.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),


                  AnimatedPositioned(
                    duration: Duration(seconds: 2),
                    left: bat2X,
                    top: bat2Y,
                    child: GestureDetector(
                      onTap: () => onBatTap(2),
                      child: Image.asset(
                        'Assets/bat2.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),


                  AnimatedPositioned(
                    duration: Duration(seconds: 2),
                    left: witchX,
                    top: witchY,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          message = "Wrong Choice!!!!";
                        });
                      },
                      child: Image.asset(
                        'Assets/bat3.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),


                ],
              ),
              SizedBox(height: 20),
              Text(
                message,
                style: TextStyle(fontSize: 24, color: Colors.orange),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
