import 'package:quizzler/questions.dart';

class QuizBrain {

  int _questionNumber = 0;

  List<Questions> _questionBank = [
    Questions('In Python, you can define a variable without specifying its data type ?', true),
    Questions('The print function is used to receive data from keyboard in a  program ?', false),
    Questions('The input function can be used to read a value from keyword. However, by using this statement you need to supply the value in single quotes ?', true),
    Questions('In Python, by using the raw_input function the value input from keyboard can be read without the use of single quotes ?', true),
    Questions('In Python, to access the type of a variable, you can the type function ?', true),
    Questions('A comment in Python language can start with # sign ?', true),
    Questions('Python is an interpreted language ?', true),
    Questions('Python does not support OOP ?', false),
    Questions('Python is not case sensitive ? ', false),
    Questions('Random module is the standard module that is used to generate a random number ? ', true),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getQuestionAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  int getQuestionBankSize() {
    return _questionBank.length;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    }
    return false;
  }

  void reset() {
    _questionNumber = 0;
  }
}