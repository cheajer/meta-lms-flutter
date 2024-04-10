import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meta_lms/models/assessments/QuestionModel.dart';
import 'package:meta_lms/utils/AppColors.dart';

class QuizQuestionWidget extends StatelessWidget {
  final QuestionModel question;
  final Function(dynamic) onSelected; // Adjust the type if necessary
  final int index;

  const QuizQuestionWidget(
      {Key? key,
      required this.question,
      required this.onSelected,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (question.type) {
      case 'singleChoice':
        return SingleChoiceQuestion(
          question: question,
          onSelected: (answer) => onSelected(answer),
          index: index,
        );
      case 'multipleChoice':
        return MultipleChoiceQuestion(
            question: question,
            onSelected: (answers) => onSelected(answers),
            index: index);
      case 'Essay':
        return EssayQuestion(
            question: question,
            onTextChange: (text) => onSelected(text),
            index: index);
      default:
        return const Text('Unknown question type');
    }
  }
}

class SingleChoiceQuestion extends StatefulWidget {
  final QuestionModel question;
  final Function(String) onSelected; // Callback for when an option is selected
  final int index;

  const SingleChoiceQuestion(
      {Key? key,
      required this.question,
      required this.onSelected,
      required this.index})
      : super(key: key);

  @override
  _SingleChoiceQuestionState createState() => _SingleChoiceQuestionState();
}

class _SingleChoiceQuestionState extends State<SingleChoiceQuestion> {
  String? selectedChoice;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Expanded(
                child: Center(
                    child: Text(
                        "QUESTION " +
                            (widget.index + 1).toString() +
                            " - SELECT ONE",
                        style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w700))),
              )
            ]),
            const Divider(),
            Text(widget.question.questionDescription),
            ...List<Widget>.from(
                widget.question.choices['choices'].map<Widget>((choice) {
              return RadioListTile<String>(
                title: Text(choice),
                value: choice,
                groupValue: selectedChoice,
                onChanged: (value) {
                  setState(() {
                    selectedChoice = value;
                    widget.onSelected(
                        value!); // Call the callback with the selected value
                  });
                },
              );
            })),
          ],
        ),
      ),
    );
  }
}

class EssayQuestion extends StatefulWidget {
  final QuestionModel question;
  final Function(String) onTextChange;
  final int index;

  const EssayQuestion(
      {Key? key,
      required this.question,
      required this.onTextChange,
      required this.index})
      : super(key: key);

  @override
  _EssayQuestionState createState() => _EssayQuestionState();
}

class _EssayQuestionState extends State<EssayQuestion> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      widget.onTextChange(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                        Row(children: [
                  Expanded(
                    child: Center(
                        child: Text(
                            "QUESTION " +
                                (widget.index + 1).toString() +
                                " - TYPE YOUR ANSWER",
                            style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w700))),
                  )
                ]),
                const Divider(),
            Text(widget.question.questionDescription),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Enter your answer here'),
              maxLines: null, // Allows for multiline input
            ),
          ],
        ),
      ),
    );
  }
}

class MultipleChoiceQuestion extends StatefulWidget {
  final QuestionModel question;
  final Function(List<String>) onSelected;
  final int index;

  const MultipleChoiceQuestion(
      {Key? key,
      required this.question,
      required this.onSelected,
      required this.index})
      : super(key: key);

  @override
  _MultipleChoiceQuestionState createState() => _MultipleChoiceQuestionState();
}

class _MultipleChoiceQuestionState extends State<MultipleChoiceQuestion> {
  List<String> _selectedChoices = [];

  @override
  Widget build(BuildContext context) {
    final choices = List<String>.from(widget.question.choices["choices"]);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Expanded(
                child: Center(
                    child: Text(
                        "QUESTION " +
                            (widget.index + 1).toString() +
                            " - SELECT MULTIPLE",
                        style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w700))),
              )
            ]),
            const Divider(),
            Text(widget.question.questionDescription),
            ...choices.map((choice) {
              return CheckboxListTile(
                title: Text(choice),
                value: _selectedChoices.contains(choice),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _selectedChoices.add(choice);
                    } else {
                      _selectedChoices.remove(choice);
                    }
                    widget.onSelected(_selectedChoices);
                  });
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
