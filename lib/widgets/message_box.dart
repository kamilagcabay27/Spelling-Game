import 'package:flutter/material.dart';
import 'package:flutter_spelling_game/constant/string_constants.dart';
import 'package:flutter_spelling_game/controller/controller.dart';
import 'package:flutter_spelling_game/view/home_page.dart';
import 'package:provider/provider.dart';

class MessageBox extends StatelessWidget {
  final bool sessionCompleted;
  const MessageBox({super.key, required this.sessionCompleted});

  @override
  Widget build(BuildContext context) {
    String title = StringConstants.title;
    String buttonText = StringConstants.buttonText;
    if (sessionCompleted) {
      title = StringConstants.allWordsCompleted;
      buttonText = StringConstants.replay;
    }
    return AlertDialog(
      backgroundColor: Colors.cyan,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(60),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.displayLarge,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60),
            ),
          ),
          onPressed: () {
            if (sessionCompleted) {
              Provider.of<Controller>(context, listen: false).reset();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            } else {
              Provider.of<Controller>(context, listen: false)
                  .requestWord(request: true);
              Navigator.of(context).pop();
            }
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              buttonText,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(fontSize: 30),
            ),
          ),
        ),
      ],
    );
  }
}
