import 'package:flutter/material.dart';
import 'package:meta_lms/models/assessments/AssessmentDetailModel.dart';
import 'package:meta_lms/ui/pages/topics/assessments/QuizQuestionWidget.dart';
import 'package:meta_lms/ui/widgets/GlobalAppBar.dart';
import 'package:meta_lms/utils/AppColors.dart';

class QuizPage extends StatefulWidget {
  final AssessmentDetailModel assessment;

  const QuizPage({Key? key, required this.assessment}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Map<int, dynamic> answers = {}; // Store answers keyed by question ID

  void _updateAnswer(int questionId, dynamic answer) {
    setState(() {
      answers[questionId] = answer;
    });
  }

  Widget _buildAssessmentHeaderBar() {

    IconData headerIcon() {
    switch(widget.assessment.type) {
      case "exam":
        return Icons.biotech;
      case "assignment":
        return Icons.assignment;
      case "quiz":
        return Icons.quiz;
      case "essay":
        return Icons.book;
      default:
        return Icons.error;
      }
      
    }


    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width,
        child: Material(
          elevation: 1,
          color: AppColors.primaryColor,
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Icon(headerIcon(), color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(widget.assessment.name, style: const TextStyle(color: Colors.white)),
            )
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(),
      backgroundColor: AppColors.surfaceColor,
      body: Column(
        children: [
          _buildAssessmentHeaderBar(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.assessment.questions.length,
            itemBuilder: (context, index) {
              final question = widget.assessment.questions[index];
              return QuizQuestionWidget(
                question: question,
                index: index,
                onSelected: (answer) {
                  _updateAnswer(question.id, answer);
                },
              );
              // You need to modify QuizQuestionWidget or create similar widgets for handling each type of question accordingly.
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Here you can use the answers Map for your needs, e.g., submitting the quiz
          print(answers); // Debugging: print selected answers
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
