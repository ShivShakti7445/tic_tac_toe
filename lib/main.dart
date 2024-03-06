import 'package:flutter/material.dart';
import 'package:gradients/gradients.dart';




void main() {
  runApp(  MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TicTacToeGame(),
    );
  }
}
class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<List<String>> board = List.generate(3, (_) => List.generate(3, (_) => ''));
  String currentPlayer = 'X';
  String winner = '';
  bool isDraw = false;

  void checkWinner() {
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == currentPlayer && board[i][1] == currentPlayer && board[i][2] == currentPlayer) {
        winner = currentPlayer;
      }
      if (board[0][i] == currentPlayer && board[1][i] == currentPlayer && board[2][i] == currentPlayer) {
        winner = currentPlayer;
      }
    }

    if (board[0][0] == currentPlayer && board[1][1] == currentPlayer && board[2][2] == currentPlayer) {
      winner = currentPlayer;
    }
    if (board[0][2] == currentPlayer && board[1][1] == currentPlayer && board[2][0] == currentPlayer) {
      winner = currentPlayer;
    }

    // Check for a draw

    if (!board.any((row) => row.contains(''))) {
      isDraw = true;
    }
  }

  void makeMove(int row, int col) {
    if (board[row][col] == '' && winner.isEmpty) {
      setState(() {
        board[row][col] = currentPlayer;
        currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
        checkWinner();
      });
    }
  }

  void restartGame() {
    setState(() {
      board = List.generate(3, (_) => List.generate(3, (_) => ''));
      currentPlayer = 'X';
      winner = '';
      isDraw = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          children: [
            for (int i = 0; i < 3; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int j = 0; j < 3; j++)
                    GestureDetector(
                      onTap: () => makeMove(i, j),
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: Flutter.romance(),
                        ),
                        child: Text(
                          board[i][j],
                          style: const TextStyle(fontSize: 32.0),
                        ),
                      ),
                    ),
                ],
              ),
            if (winner.isNotEmpty) Text('Winner: $winner'),
            if (isDraw) const Text('It\'s a draw!'),
            ElevatedButton(
              onPressed: () {
                restartGame();
              },
              child: const Text('Restart'),
            ),
          ],
        ),
      ),
    );
  }
}

class Flutter {
  static romance() {}
}

