import 'package:appetizer/ProductPage/models/TagModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'featuredItem.dart';

class SurveyProvider extends ChangeNotifier {
  List questions = [];
  List tagList = [];
  List filterList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  tag() async {
    questions.clear();
    print('single is best');
    await _firestore.collection('TagQuestions').get().then((value) {
      value.docs.forEach((element) {
        List answer = [];
        element.data().forEach((key, value) {
          answer.add(AnswerModel(answer: key, tag: value));
        });
        questions.add(QuestionModel(question: element.id, answers: answer));
      });
    });
    return questions;
  }

  void Answer(String tag) {
    bool isVerified = true;
    tagList.forEach((element) {
      element.tag.forEach((value) {
        if (value == tag) {
          element.priority += 1;
          filterList.forEach((e) {
            if (e.id == element.id) {
              isVerified = false;
              e.priority = element.priority;
            }
          });
          if (isVerified) {
            filterList.add(FeaturedItem(
                price: element.price,
                id: element.id,
                priority: element.priority,
                url: element.url,
                rating: element.rating,
                isFirstTime: element.isFirstTime,
                name: element.name));
          }
        }
      });
    });
  }

  selectedCategory(int index, int selectedIndex) {
    selectedIndex = index;
    notifyListeners();
    return selectedIndex;
  }

  bubbleSort() {
    if (filterList == null || filterList.length == 0) return;

    int n = filterList.length;
    int i, step;
    for (step = 0; step < n; step++) {
      for (i = 0; i < n - step - 1; i++) {
        if (filterList[i].priority < filterList[i + 1].priority) {
          swap(filterList, i);
        }
      }
    }
    printList();
  }

  swap(List list, int i) {
    var temp = list[i];
    list[i] = list[i + 1];
    list[i + 1] = temp;
  }

  printList() {
    filterList.forEach((element) {
      print(element.name.toString());
    });
  }
}
