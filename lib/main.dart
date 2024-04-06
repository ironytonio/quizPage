import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(
      MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.purple[100],
        ),
        home: QuizPage(),
      ),
    );

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  //вивожу в код основне
  int _questionIndex = 0;
  int _score = 0;
  Color _feedbackColor = Colors.transparent;
  int _secondsRemaining = 300;
  late Timer
      _timer; //змінна буде ініціалізована пізніше, а не в момент оголошення

  final List<Map<String, Object>> _questions = [
    //final змінні значення яких не може змінюватися ,Map колекцію пар ключ-значення, де кожен ключ унікальний.
    {
      'questionText':
          'What movie won the Academy Award for Best Picture in 1994?',
      'answers': [
        "Forrest Gump",
        "Pulp Fiction",
        "Schindler's List",
        "The Shawshank Redemption"
      ],
      'correctAnswer': 'Forrest Gump',
    },
    {
      'questionText': 'What animated film features a character named Simba?',
      'answers': ["Finding Nemo", "The Lion King", "Shrek", "Toy Story"],
      'correctAnswer': 'The Lion King',
    },
    {
      'questionText':
          'Which actress won an Academy Award for her role in the 2019 film "Joker"?',
      'answers': [
        "Scarlett Johansson",
        "Natalie Portman",
        "Emma Stone",
        "Renée Zellweger"
      ],
      'correctAnswer': 'Renée Zellweger',
    },
    {
      'questionText':
          'Who directed the science fiction film "Inception", released in 2010?',
      'answers': [
        "Christopher Nolan",
        "James Cameron",
        "Quentin Tarantino",
        "Steven Spielberg"
      ],
      'correctAnswer': 'Christopher Nolan',
    },
    {
      'questionText': 'Which film features a character named Harry Potter?',
      'answers': [
        "The Lord of the Rings",
        "Harry Potter and the Sorcerer's Stone",
        "Twilight",
        "The Hunger Games"
      ],
      'correctAnswer': 'Harry Potter and the Sorcerer\'s Stone',
    },
    {
      'questionText': 'What is the capital city of France?',
      'answers': ["London", "Paris", "Berlin", "Rome"],
      'correctAnswer': 'Paris',
    },
    {
      'questionText': 'Who is the author of "Romeo and Juliet"?',
      'answers': [
        "William Shakespeare",
        "Charles Dickens",
        "Jane Austen",
        "Leo Tolstoy"
      ],
      'correctAnswer': 'William Shakespeare',
    },
    {
      'questionText': 'What is the chemical symbol for water?',
      'answers': ["H2O", "CO2", "NaCl", "O2"],
      'correctAnswer': 'H2O',
    },
    {
      'questionText': 'Which planet is known as the Red Planet?',
      'answers': ["Mars", "Venus", "Jupiter", "Saturn"],
      'correctAnswer': 'Mars',
    },
    {
      'questionText': 'Who painted the Mona Lisa?',
      'answers': [
        "Leonardo da Vinci",
        "Pablo Picasso",
        "Vincent van Gogh",
        "Michelangelo"
      ],
      'correctAnswer': 'Leonardo da Vinci',
    },
    {
      'questionText': 'What is the capital of Japan?',
      'answers': ['Seoul', 'Beijing', 'Tokyo', 'Bangkok'],
      'correctAnswer': 'Tokyo',
    },
    {
      'questionText': 'Who wrote "To Kill a Mockingbird"?',
      'answers': ['J.K. Rowling', 'Stephen King', 'Harper Lee', 'Mark Twain'],
      'correctAnswer': 'Harper Lee',
    },
    {
      'questionText': 'What is the largest mammal in the world?',
      'answers': ['Elephant', 'Blue Whale', 'Giraffe', 'Hippopotamus'],
      'correctAnswer': 'Blue Whale',
    },
    {
      'questionText': 'What is the chemical symbol for gold?',
      'answers': ['Au', 'Ag', 'Hg', 'Pb'],
      'correctAnswer': 'Au',
    },
    {
      'questionText': 'Who painted "The Starry Night"?',
      'answers': [
        'Leonardo da Vinci',
        'Vincent van Gogh',
        'Pablo Picasso',
        'Claude Monet'
      ],
      'correctAnswer': 'Vincent van Gogh',
    },
    {
      'questionText': 'What is the currency of Russia?',
      'answers': ['Euro', 'Dollar', 'Ruble', 'Pound'],
      'correctAnswer': 'Ruble',
    },
    {
      'questionText': 'Who invented the telephone?',
      'answers': [
        'Thomas Edison',
        'Nikola Tesla',
        'Alexander Graham Bell',
        'Albert Einstein'
      ],
      'correctAnswer': 'Alexander Graham Bell',
    },
    {
      'questionText': 'What is the capital of Australia?',
      'answers': ['Sydney', 'Melbourne', 'Canberra', 'Perth'],
      'correctAnswer': 'Canberra',
    },
    {
      'questionText': 'What is the tallest mountain in the world?',
      'answers': ['Mount Everest', 'K2', 'Kangchenjunga', 'Lhotse'],
      'correctAnswer': 'Mount Everest',
    },
    {
      'questionText': 'Who wrote "The Great Gatsby"?',
      'answers': [
        'F. Scott Fitzgerald',
        'Ernest Hemingway',
        'William Faulkner',
        'John Steinbeck'
      ],
      'correctAnswer': 'F. Scott Fitzgerald',
    }
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
          _goToScorePage();
        }
      });
    });
  }

  void _checkQuestionIndex() {
    if (_questionIndex >= _questions.length) {
      _questionIndex = 0; // Скидаємо індекс на початок
      _timer.cancel();
      _goToScorePage();
    }
  }

  void _answerQuestion(String selectedAnswer) {
    setState(() {
      if (_questions[_questionIndex]['correctAnswer'] == selectedAnswer) {
        _score++;
        _feedbackColor = Colors.green;
      } else {
        _feedbackColor = Colors.red;
      }
      _questionIndex++;

      if (_questionIndex >= _questions.length) {
        _checkQuestionIndex();
      }
    });
  }

  void _goToScorePage() {
    int finalScore =
        _score; // Зберегти остаточний результат перед очищенням змінних
    _score = 0; // Обнулити бал
    _questionIndex = 0; // Скинути індекс питання на початок
    _timer.cancel(); // Зупинити таймер
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScorePage(score: finalScore),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star),
                      Text('$_questionIndex/20'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.timer),
                      Text('$_secondsRemaining s'),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _questions[_questionIndex]['questionText'] as String,
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ...(_questions[_questionIndex]['answers'] as List<String>)
                      .map(
                    (answer) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: ElevatedButton(
                          onPressed: () => _answerQuestion(answer),
                          child: Text(answer),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    color: _feedbackColor,
                    alignment: Alignment.center,
                    child: Text(
                      _feedbackColor == Colors.green
                          ? 'Correct!'
                          : _feedbackColor == Colors.red
                              ? 'Incorrect!'
                              : '',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10), // gap
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Correct Answer"),
                    content: Text(
                        _questions[_questionIndex]['correctAnswer'] as String),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Close'),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                color: Colors.white,
                child: Center(
                  child: Text(
                    "Need a hint?",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class ScorePage extends StatelessWidget {
  final int score;

  ScorePage({required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Correct Answers: $score out of 20',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Start Over'),
            ),
          ],
        ),
      ),
    );
  }
}
