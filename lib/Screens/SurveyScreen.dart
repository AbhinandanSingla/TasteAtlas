import 'package:appetizer/ProductPage/models/SurveyProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'SurveyScreenProduct.dart';

class SurveyScreen extends StatefulWidget {
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen>
    with SingleTickerProviderStateMixin {
  Future Tags;
  List answer;
  final pagecontroller = PageController();
  double progressValue = 0.1;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    SurveyProvider surveyProvider =
        Provider.of<SurveyProvider>(context, listen: false);
    Tags = surveyProvider.tag();
  }

  String tag;
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    SurveyProvider surveyProvider = Provider.of<SurveyProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 25,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Confused! Let us decide for you',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'ltim'),
        ),
      ),
      body: FutureBuilder(
        future: Tags,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return PageView.builder(
            // physics: NeverScrollableScrollPhysics(),
            controller: pagecontroller,
            itemBuilder: (BuildContext context, int index) {
              answer = surveyProvider.questions[index].answers;

              return SafeArea(
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: progressValue,
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation(Colors.pink),
                      minHeight: 7,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      surveyProvider.questions[index].question,
                      style: TextStyle(
                          fontFamily: 'ltim',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              selectedindex = surveyProvider.selectedCategory(
                                  index, selectedindex);
                              tag = answer[index].tag;
                              print(tag);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 50, right: 50, bottom: 10, top: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                        color: selectedindex != null &&
                                                selectedindex == index
                                            ? Colors.pinkAccent
                                            : Colors.grey.shade300,
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                        offset: Offset(0, 0))
                                  ]),
                              height: 80,
                              child: Center(
                                  child: Text(
                                answer[index].answer,
                                style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              )),
                            ),
                          );
                        },
                        itemCount: answer.length,
                        shrinkWrap: true,
                      ),
                    ),
                    FlatButton(
                        onPressed: () {
                          if (tag == null) {
                            tag = answer[selectedindex].tag;
                          }
                          print(tag);
                          progressValue += 1 / surveyProvider.questions.length;
                          pagecontroller.nextPage(
                              duration: Duration(microseconds: 500),
                              curve: Curves.bounceIn);
                          surveyProvider.Answer(tag);
                          tag = null;
                          if (pagecontroller.page + 1 ==
                              surveyProvider.questions.length) {
                            surveyProvider.bubbleSort();
                            surveyProvider.printList();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return SurveyProductScreen();
                            }));
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          width: size.width - 80,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.pinkAccent,
                          ),
                          child: Center(
                            child: pagecontroller.page + 1 ==
                                    surveyProvider.questions.length
                                ? Text(
                                    'Results',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Comfortaa'),
                                  )
                                : Text(
                                    'Next',
                                    style: TextStyle(
                                        fontFamily: 'Comfortaa', fontSize: 20),
                                  ),
                          ),
                        )),
                  ],
                ),
              );
            },
            itemCount: surveyProvider.questions.length,
          );
        },
      ),
    );
  }
}
