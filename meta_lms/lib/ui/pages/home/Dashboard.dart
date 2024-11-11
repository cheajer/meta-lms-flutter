import 'package:flutter/material.dart';
import 'package:meta_lms/utils/AppColors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Dashboard extends StatelessWidget {
  final int numAssessments;
  final String nextDueStr;
  const Dashboard(
      {Key? key, required this.numAssessments, required this.nextDueStr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.18,
            child: Column(
              children: [
                Expanded(
                  child: Row(children: [
                    Expanded(
                        child: Center(
                            child: Text(
                                AppLocalizations.of(context)
                                        ?.nextAssessmentDue ??
                                    "NEXT ASSESSMENT DUE IN",
                                style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700))))
                  ]),
                ),
                const Divider(),
                Expanded(
                  child: Row(children: [
                    const Spacer(),
                    Text(nextDueStr),
                    const Spacer()
                  ]),
                ),
                const Divider(),
                Expanded(
                  child: Row(children: [
                    Expanded(
                        child: Center(
                            child: Text(
                                AppLocalizations.of(context)
                                        ?.numberOfOpenAssessments ??
                                    "NUMBER OF OPEN ASSESSMENTS",
                                style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700))))
                  ]),
                ),
                const Divider(),
                Expanded(
                  child: Row(children: [
                    const Spacer(),
                    Text(numAssessments.toString()),
                    const Spacer()
                  ]),
                ),
              ],
            )),
      ),
    );
  }
}
