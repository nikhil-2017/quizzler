import 'package:flutter/material.dart';
import 'package:quizzler/constants.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizPage(),
        )),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {

  @override
  _QuizPageState createState() => _QuizPageState();

}

class _QuizPageState extends State<QuizPage> {

  int rightAnswer = 0;
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    setState(() {

      if (correctAnswer == userPickedAnswer) {
        rightAnswer++;
        scoreKeeper.add(right);
      } else {
        scoreKeeper.add(wrong);
      }

      if (quizBrain.isFinished()) {
        int halfSize = (quizBrain.getQuestionBankSize()/2).floor();
        String result;
        if (rightAnswer >= halfSize + (halfSize/2).floor()) {
          result = rightAnswer.toString() + '/' + quizBrain.getQuestionBankSize().toString() + '\nFinished! \nGood work!';
        } else {
          result = rightAnswer.toString() + '/' + quizBrain.getQuestionBankSize().toString() + '\nFinished! \nYou Need To Practice.';
        }

        Alert(
          context: context,
          title: result,
          desc: 'You\'ve reached the end of the quiz.',
        ).show();

        rightAnswer = 0;
        quizBrain.reset();
        scoreKeeper = [];

      } else {
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                  checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}